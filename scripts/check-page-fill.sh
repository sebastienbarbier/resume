#!/usr/bin/env bash
# Fail if any resume page ends with a blank band above the bottom margin.
# Usage: scripts/check-page-fill.sh [resume.pdf] [max_gap_pt]
set -euo pipefail

PDF="${1:-resume.pdf}"
MAX_GAP="${2:-15}"

# A4 height 841.89pt minus the 1.65cm bottom margin set in resume.tex.
TEXT_BOTTOM=795.1

DIR="$(cd "$(dirname "$PDF")" && pwd)"
NAME="$(basename "$PDF")"

if command -v pdftotext >/dev/null 2>&1; then
  BBOX="$(cd "$DIR" && pdftotext -bbox "$NAME" -)"
else
  BBOX="$(docker run --rm -v "$DIR:/workdir" -w /workdir minidocks/poppler pdftotext -bbox "$NAME" -)"
fi

printf '%s' "$BBOX" | python3 -c '
import re, sys
bottom, max_gap = float(sys.argv[1]), float(sys.argv[2])
pages, page = [], None
for line in sys.stdin:
    if "<page " in line:
        page = []
        pages.append(page)
    m = re.search(r"yMax=\"([\d.]+)\">([^<]*)<", line)
    if m and page is not None and float(m.group(1)) < bottom:
        page.append(float(m.group(1)))
failed = False
for i, ys in enumerate(pages, 1):
    gap = bottom - max(ys) if ys else bottom
    status = "ok" if gap <= max_gap else "BLANK AT END"
    failed |= gap > max_gap
    print(f"page {i}: {gap:.0f}pt blank at the bottom ({status}, limit {max_gap:.0f}pt)")
sys.exit(1 if failed else 0)
' "$TEXT_BOTTOM" "$MAX_GAP"
