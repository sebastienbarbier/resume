# AGENTS.md

Instructions for AI agents generating or editing resumes in this repo. The candidate lives and applies in Switzerland, so follow Swiss CV conventions below unless the user says otherwise.

## Candidate facts (source of truth)

Use these exactly. Never invent dates, numbers, employers, titles, levels, or technologies. If a fact is missing, ask the user instead of guessing.

| Field         | Value                                                                    |
| ------------- | ------------------------------------------------------------------------ |
| Name          | Sébastien Barbier                                                        |
| Date of birth | 31 January 1988 (shown without a "Born" label)                           |
| Location      | 8005 Zürich, Switzerland                                                 |
| Nationality   | French (shown as "French nationality")                                   |
| Work permit   | B permit (EU/EFTA)                                                       |
| Email         | contact@sebastienbarbier.com                                             |
| Website       | sebastienbarbier.com                                                     |
| Phone         | Only in `applications/` copies; use the placeholder `+41~xx~xxx~xx~xx` in the root `resume.tex` |
| Languages     | French: native, English: fluent (no CEFR level), German: B1 (Goethe-Zertifikat B1, passed July 2026) |
| Education     | Master's in Computer Science (2011) and Bachelor's in Computer Science (2009), University of Franche-Comté, France. The Erasmus year and HNC stay off the resume |

Decided by the user, do not add: photo, interests, availability or notice period, mention of work certificates, a "References available on request" line.

Product name: always write `Shellui` (never ShellUI). Shellui is a **personal project** (started Jan 2026, ongoing), not a job: show it in a "Personal Project" section (plural once there are several) with the title "Full-Stack Developer". Never use the word "Founder" for Shellui, in the header, the page header, bullets, or cover letters.

From Aug 2021 to Nov 2023, Sébastien was a **liquidity provider in crypto**, investing his own capital. Show it as "Liquidity Provider, Decentralized Finance (DeFi)" with the organisation line "Private investor (own capital)", never "Self-employed" (it was private asset management, not a registered business). Activity: on-chain DeFi AMM pools, which fully funded his living costs for over two years (no protocol names, no custom tooling claimed). In parallel, Sébastien worked on personal projects, which may be mentioned:

- **Seven23** (seven23.io, since 2011): open-source, end-to-end encrypted, fully manual budget app. Web app in React, Redux, MUI, D3 and Workbox (offline-first, runs without an account); backend on Django and Django REST Framework with Swagger/Redoc API docs, Docker images and GitHub Actions CI. 112 + 59 GitHub stars (170+ across both repositories).
- **FromEdwin.com**: learning project on asynchronous performance metrics; stopped and no longer online. Do not describe it as a live product.

SAP: employer legal name is **SAP (Schweiz) AG**, department Field Service Management (FSM) Self-Service & Platform Extensibility, Feb 2020 to Jul 2021, last title Associate Development Architect (earlier Technical Lead). Details come from `references/`.

## Reference documents

`references/` holds private source documents (work certificates, contracts, job descriptions, project notes). Read them before writing or rewriting experience: they are the preferred source for scope, technologies, and results, together with the facts above. Rules:

- Never quote or name the documents in the resume (no mention of work certificates), and never copy referee names or contact details.
- The folder is git-ignored and must never be pushed. `scripts/check-pii.sh` (pre-commit hook and CI) fails if any file under `references/` or `applications/` is tracked.
- If a fact is not in `references/`, the facts above, or the root `resume.tex`, ask the user.

## Swiss CV conventions

1. **Personal details in the header**: name, target title, email, phone, website, then one line with postcode and city, date of birth, nationality, and work permit. Swiss recruiters expect date of birth, nationality and permit; the permit tells them no visa sponsorship is needed.
2. **Length and format**: A4, two pages maximum, reverse chronological, `Mon YYYY -- Mon YYYY` dates.
   - **Never write "Present"** (or "today", "now") as an end date, for experience and projects alike: ATS parsers handle a real date better. Use the current month and year on the day the PDF is generated (for example `Jan 2026 -- Oct 2026`), and update it on every rebuild, in the root resume and in application copies.
3. **No unexplained gaps**: every period since 2009 is covered by a role, self-employment, or project. Gaps longer than three months need a one-line explanation.
4. **Languages with levels**: CEFR (A1 to C2) where known, otherwise native or fluent, exactly as in the facts table. German level matters for German-speaking Switzerland, so keep it visible.
5. **Facts over hype**: Swiss readers value precision and an understated tone. Prefer concrete scope, numbers, and outcomes; avoid words like "passionate", "rockstar", or "world-class".
6. **Soft skills section**: four or five short lines, each backed by evidence from the experience section (who, where, what). No unbacked adjectives.
7. **Education**: degree, field, institution, country, and year. Keep foreign degree names clear (for example "Master's in Computer Science").
8. **References**: no references line (user's choice). Never list referee names or contacts without explicit consent, and do not mention Swiss work certificates (Arbeitszeugnisse).
9. **Language of the CV**: match the job ad (English, German, or French). In German versions use Swiss spelling (`ss`, never `ß`) and `DD.MM.YYYY` dates.
10. **Leave out**: salary expectations, reasons for leaving, religion, marital status, and anything not relevant to the role. No photo, interests, or availability line (user's choice).
11. **Spelling of places**: use local names (`Zürich`) and company legal forms (`AG`, `GmbH`).

## Writing style

- No long blocks of text: the summary is at most three lines, and any text longer than two lines becomes separate bullets.
- Bullets: one idea each, ideally one line, never more than two. Prefer several short bullets over one long one.
- **What, how, result:** every experience and project bullet is one sentence that says what was done, how (with concrete technical terms: languages, frameworks, protocols, tools), and the result (scope, outcome, or number). Example: "Built durable background jobs (what) on Celery and Redis with retries and a transactional outbox (how), so no webhook is lost on failure (result)." Results must come from real facts (`references/`, facts above, root `resume.tex`); if no result is known, ask the user rather than inventing one.
- At most five bullets per role, fewer for older roles.
- Bold only job-relevant keywords, sparingly (a few per section).
- Older roles (before 2014) go in "Earlier Experience" with one bullet each.

## Tailoring for a job offer

1. Create `applications/YYYY-MM-DD-company/` (git-ignored) and copy `resume.tex` and [`ats-report.tex`](./ats-report.tex) into it.
2. Save the job description as **`job-offer.pdf`** in that folder, so the ad survives after the posting goes offline:
   - **Link:** download the page content and save it as PDF (for example, headless Chrome `--print-to-pdf`, or fetch the text and use the text method below). Keep the source URL and the download date at the top. If the page needs a login or blocks the download, ask the user to paste the text.
   - **Pasted text:** write it verbatim into `job-offer.tex` (company, job title, location, date saved, then the full ad, without rewording) and build it with `make -f ../../Makefile docker TEX=job-offer.tex CURDIR=$(pwd)`.
3. Extract keywords from the job ad (stack, responsibilities, soft skills) and make them visible in the title, summary, bullets, and skills, but only where they are true.
4. Follow any per-application instruction from the user (for example, hiding a project) without changing the root resume.
5. Add the real phone number only in the application copy. Name the final PDF `sebastien_barbier_resume.pdf`.
6. List keywords from the ad that could not be covered honestly, so the user can decide.
7. After the tailored CV is built and verified (PDF, page fill, PII), run the **ATS and HR check** below before handoff. Fill in `ats-report.tex` and build **`ats-report.pdf`** in the same application folder (`make -f ../../Makefile ats-report` from that folder).

## ATS and HR check

Run this workflow **whenever a tailored CV is generated from a job offer** (application copy under `applications/YYYY-MM-DD-company/`). Act as an **HR and ATS expert for the Swiss labour market**. Use the job spec (and Swiss context: permit, languages, local titles, AG/GmbH employers). **Never use em or en dashes as punctuation** in the report; use commas, colons, or full stops.

### 1. Extract keywords

From the job spec, list all relevant terms, grouped as needed:

- Hard skills and tools (languages, frameworks, cloud, methods)
- Domain and product context (industry, compliance, customer type)
- Seniority and role scope (lead, staff, architect, ownership)
- Soft skills and ways of working (only if stated in the ad)
- Languages and location or permit requirements

### 2. Classify each keyword against the CV

For every extracted keyword, check the generated CV (LaTeX/PDF text) and assign **one status** (shown in the PDF with a **coloured row** and in the legend; **no emoji** in the report):

| Status | Meaning | PDF row colour |
| ------ | ------- | -------------- |
| **MATCH** | Keyword clearly present (same term or unambiguous equivalent in context) | Green background |
| **PARTIAL MATCH** | Implied by experience but not explicitly stated; ATS may miss it | Yellow background |
| **MISSING** | Important in the ad but absent or not supportable from master data | Red background |

In `ats-report.tex`, add one row per keyword using `\MatchRow{keyword}{notes}`, `\PartialRow{keyword}{notes}`, or `\MissingRow{keyword}{notes}`. The template includes a visual legend with coloured boxes.

### 3. Score and verdict

- **Match score:** percent of keywords that are **MATCH** (state numerator and denominator; optional half weight for PARTIAL MATCH, but always report MATCH-only percent as the primary score in `\RoundOneScore`, `\RoundTwoScore`, `\RoundThreeScore`).
- **ATS screening verdict:** pass / borderline / fail, with one short paragraph (parseability, exact terms, title alignment, length).
- **HR check verdict:** pass / borderline / fail, with one short paragraph (Swiss expectations, clarity, permit/nationality visible if relevant, gaps, tone).

### 4. Line manager view

Add a subsection **Line manager view:** what a hiring manager will skim first (title, last roles, stack proof), and **top concerns** (missing must-haves, weak proof, seniority mismatch, domain gap). Be direct and factual, not motivational.

### 5. Iterate (up to 3 rounds)

1. Improve the tailored CV to turn PARTIAL MATCH and honest MISSING rows into MATCH (title, summary, bullets, skills only).
2. Rebuild PDF; re-run page fill and PII checks.
3. Re-run steps 2 to 4 and record the new match score.

**Strict rule:** never add a skill, keyword, or claim that is not backed by real facts in the **master resume data** (this file’s candidate facts table, documents in `references/`, root `resume.tex`, and existing true bullets). Do not invent employers, metrics, or tools.

Stop when:

- No further honest gains, or
- **3 rounds** completed.

Keywords that remain MISSING or PARTIAL MATCH after iteration go under **Gaps to address in interview** in the template (brief bullet each: what to say with evidence from real experience, without adding them to the CV as false claims).

### 6. Save `ats-report.pdf`

On every run, overwrite the application copy of **`ats-report.tex`** and rebuild **`ats-report.pdf`** (root template: [`ats-report.tex`](./ats-report.tex), `make ats-report`). The PDF must include:

- Job title, company, date of report, language of CV (header macros)
- **Legend** with green, yellow, and red boxes (MATCH, PARTIAL MATCH, MISSING)
- Keyword table with **real background colours** per row
- **Score per round** (Round 1, Round 2, Round 3) so progress is visible
- Final **ATS** and **HR** verdicts and **Line manager view**
- **Gaps to address in interview**
- Optional: keywords from the ad that were deliberately not added (with reason), in notes or gaps section

Do not commit application reports; they stay under git-ignored `applications/`. The root `ats-report.tex` may keep demo placeholder content for agents to copy.

## Cover letters (AIDA)

Every generated cover letter must follow the **AIDA** structure below. Use the language of the job ad (English, German, or French). **One A4 page maximum.** Tone: sober and professional, Swiss-style precision; no sales language, clichés, or hype (for example avoid "passionate", "thrilled", or "perfect fit"). **Never use em or en dashes as punctuation** in prose; use commas, colons, or full stops. Job titles and `Shellui` rules (spelling, personal project, no "Founder") still apply. Use only facts from the resume and job ad; if a hook needs company detail you do not have, ask the user instead of inventing it.

| Step | Purpose |
| ---- | ------- |
| **Attention** | Open with a **specific, factual hook** tied to the company or role (a concrete detail from the ad, product, stack, or scope). Not a generic "I am applying for…" opener. |
| **Interest** | The **most relevant experience** for this posting: role, employer, technologies, and outcomes that match the ad. |
| **Desire** | **Concrete proof of value** Sébastien would bring this employer, using **only real facts** from the resume (scope, systems shipped, leadership, domain). |
| **Action** | A **clear, confident close** that asks for a conversation (interview or call). No pressure tactics or availability deadlines unless the user supplies them. |

For each application, copy [`cover-letter.tex`](./cover-letter.tex) into the application folder (or edit the copy there), set the header fields, and replace the four AIDA body paragraphs. The root `cover-letter.tex` is the public demo; keep it on one page when rebuilt.

## Build and verify

- Build with `make` (pdflatex), or `make docker TEX=resume.tex` when pdflatex is missing (start Docker Desktop first). For an application folder: `make -f ../../Makefile docker TEX=resume.tex CURDIR=$(pwd)`.
- Render previews with `docker run --rm -v "$(pwd):/workdir" -w /workdir minidocks/poppler pdftoppm -png -r 80 resume.pdf preview`, then check them visually.
- Verify: exactly two pages, no orphaned headings, no overfull lines, `scripts/check-page-fill.sh <pdf>` passes, and `bash scripts/check-pii.sh` passes.
- Delete preview images and LaTeX aux files afterwards.

## Page fill (strict)

- **No blank at the end of any page.** The last line of page 1 and page 2 must end within 15pt (about one line, 5 mm) of the bottom margin.
- This is a hard gate: run `scripts/check-page-fill.sh <pdf>` after every build. It must print `ok` for every page. Never hand over a PDF while it reports `BLANK AT END`; keep adjusting content until it passes.
- Fill with content, never with spacing: keep the preamble's fixed spacing and do not add `\vspace`, `\vfill`, stretchable glue, or extra line spacing to pad a page.
- Balance first by moving whole roles across the `\newpage` (never split a role), then add or trim short, true bullets until each page is full.
- Use the full width too: every bullet or skill line either fits on one line or fills its second line by at least half. No last line holding only one or two words; reword until it fits.

## Privacy

- The root `resume.tex` and `resume.pdf` are public: no phone number and no street address there. `scripts/check-pii.sh` (also the pre-commit hook and CI) enforces this.
- Postcode and city, date of birth, and permit are fine in the public resume.
- `references/` and `applications/` are private and git-ignored; the privacy check fails if anything under them is tracked.
