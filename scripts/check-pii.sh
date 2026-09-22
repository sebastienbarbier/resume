#!/usr/bin/env bash
# Fail if personal phone numbers or street addresses appear in the repo.
# Demo / company placeholders can be listed in .github/pii-allowlist.txt
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

ALLOWLIST_FILE=".github/pii-allowlist.txt"
TMP_HITS="$(mktemp)"
FILTERED="$(mktemp)"
trap 'rm -f "$TMP_HITS" "$FILTERED" "${TMP_HITS}.raw"' EXIT

: >"$TMP_HITS"

scan_text() {
  local file="$1"
  local kind="$2"

  if grep -nEi \
    -e '\+[[:space:]]*41[[:space:][:punct:]]*[0-9]' \
    -e '00[[:space:]]*41[[:space:][:punct:]]*[0-9]' \
    -e '\b0[76][0-9]([[:space:][:punct:]]*[0-9]){7,}\b' \
    "$file" >"${TMP_HITS}.raw" 2>/dev/null; then
    while IFS= read -r line; do
      printf '%s\t%s:%s\n' "$kind" "$file" "$line" >>"$TMP_HITS"
    done <"${TMP_HITS}.raw"
  fi

  if grep -nEi \
    -e '[[:alpha:]]+(strasse|straße|str\.)[[:space:]]+[0-9]+[[:alpha:]/]*' \
    -e '[[:alpha:]]+(weg|gasse|platz|allee)[[:space:]]+[0-9]+[[:alpha:]/]*' \
    "$file" >"${TMP_HITS}.raw" 2>/dev/null; then
    while IFS= read -r line; do
      printf 'ADDRESS\t%s:%s\n' "$file" "$line" >>"$TMP_HITS"
    done <"${TMP_HITS}.raw"
  fi
}

scan_pdf() {
  local file="$1"

  if grep -aEi \
    -e '\+[[:space:]]*41[[:space:][:punct:]]*[0-9]' \
    -e '00[[:space:]]*41[[:space:][:punct:]]*[0-9]' \
    -e '[[:alpha:]]+(strasse|straße|str\.)[[:space:]]+[0-9]+' \
    -e '[[:alpha:]]+(weg|gasse|platz|allee)[[:space:]]+[0-9]+' \
    "$file" >"${TMP_HITS}.raw" 2>/dev/null; then
    while IFS= read -r line; do
      snippet="$(printf '%s' "$line" | tr -cd '[:print:][:space:]' | tr -s '[:space:]' ' ' | cut -c1-160)"
      [[ -n "$snippet" ]] || continue
      if printf '%s' "$snippet" | grep -qiE '\+[[:space:]]*41|00[[:space:]]*41|(strasse|straße|str\.|weg|gasse|platz|allee)[[:space:]]+[0-9]'; then
        printf 'PDF\t%s: %s\n' "$file" "$snippet" >>"$TMP_HITS"
      fi
    done <"${TMP_HITS}.raw"
  fi
}

while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  case "$f" in
    .github/pii-allowlist.txt) continue ;;
  esac
  scan_text "$f" "TEXT"
done < <(
  git ls-files \
    | grep -Ei '\.(tex|md|txt|html|css|js|ts|json|yml|yaml|toml|csv)$|^(Makefile|LICENSE)$' \
    || true
)

while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  scan_pdf "$f"
done < <(git ls-files '*.pdf' || true)

if [[ ! -s "$TMP_HITS" ]]; then
  echo "Privacy check passed: no phone numbers or street addresses found."
  exit 0
fi

: >"$FILTERED"
if [[ -f "$ALLOWLIST_FILE" ]]; then
  while IFS= read -r hit; do
    allowed=0
    while IFS= read -r rule || [[ -n "${rule:-}" ]]; do
      [[ -z "${rule:-}" || "$rule" =~ ^[[:space:]]*# ]] && continue
      if printf '%s' "$hit" | grep -qiF -- "$rule"; then
        allowed=1
        break
      fi
    done <"$ALLOWLIST_FILE"
    [[ "$allowed" -eq 1 ]] || printf '%s\n' "$hit" >>"$FILTERED"
  done <"$TMP_HITS"
else
  cat "$TMP_HITS" >"$FILTERED"
fi

sort -u "$FILTERED" -o "$FILTERED"

if [[ ! -s "$FILTERED" ]]; then
  echo "Privacy check passed: hits were allowlisted (.github/pii-allowlist.txt)."
  exit 0
fi

echo "::error::Privacy check failed: phone number or street address detected."
echo
echo "Blocked matches:"
cat "$FILTERED"
echo
echo "Remove personal contact details before pushing."
echo "If this is an intentional demo placeholder, add a substring to .github/pii-allowlist.txt."
exit 1
