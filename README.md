# Sébastien Barbier - Resume & Cover Letter

LaTeX source for my resume and a cover-letter template I rewrite for each job offer.

**[Resume PDF](./resume.pdf)** · **[Cover letter PDF](./cover-letter.pdf)** · [sebastienbarbier.com](https://sebastienbarbier.com) · [contact@sebastienbarbier.com](mailto:contact@sebastienbarbier.com)

---

## Preview

### Resume

<p align="center">
  <a href="./resume.pdf">
    <img src="./assets/page-1.png" alt="Resume page 1" width="720" />
  </a>
</p>

<p align="center">
  <a href="./resume.pdf">
    <img src="./assets/page-2.png" alt="Resume page 2" width="720" />
  </a>
</p>

### Cover letter

<p align="center">
  <a href="./cover-letter.pdf">
    <img src="./assets/cover-letter.png" alt="Cover letter preview" width="720" />
  </a>
</p>

---

## Per-application workflow

1. Create `applications/YYYY-MM-DD-company/`, copy [`resume.tex`](./resume.tex), [`ats-report.tex`](./ats-report.tex), and [`cover-letter.tex`](./cover-letter.tex) if needed, then tailor for the job ad (see [`AGENTS.md`](./AGENTS.md)).
2. Build the application PDFs (`make -f ../../Makefile` from that folder, or copy the root `Makefile` workflow).
3. Run the **ATS and HR check** from [`AGENTS.md`](./AGENTS.md): fill [`ats-report.tex`](./ats-report.tex) (copy from repo root), classify keywords with coloured **MATCH / PARTIAL MATCH / MISSING** rows, iterate up to 3 rounds, then build **`ats-report.pdf`** (`make -f ../../Makefile ats-report` in the application folder).
4. For the public repo demo only: edit root [`cover-letter.tex`](./cover-letter.tex) fields and four **AIDA** paragraphs when not using an application folder.
5. Build public PDFs when needed:

```bash
make
```

That refreshes root `resume.pdf` and `cover-letter.pdf`. Optional README preview images:

```bash
make previews
```

The cover letter in this repo is a **demo** (Example AG / Senior Frontend Engineer) structured as **AIDA** (Attention, Interest, Desire, Action). Replace company fields, `\JobAdHook`, and the four body paragraphs before sending anything; see [`AGENTS.md`](./AGENTS.md).

A GitHub Action ([`.github/workflows/privacy-check.yml`](./.github/workflows/privacy-check.yml)) fails the build if a phone number or street address is committed. Intentional demo placeholders go in [`.github/pii-allowlist.txt`](./.github/pii-allowlist.txt).

Run the same check locally:

```bash
bash scripts/check-pii.sh
```

Or as a **pre-commit hook** (once per clone):

```bash
git config core.hooksPath hooks
```

That points Git at [`hooks/pre-commit`](./hooks/pre-commit), which runs the privacy scan before every commit.

---

## What’s inside

| File | Role |
|------|------|
| [`resume.tex`](./resume.tex) / [`resume.pdf`](./resume.pdf) | Resume source and built PDF |
| [`cover-letter.tex`](./cover-letter.tex) / [`cover-letter.pdf`](./cover-letter.pdf) | Cover letter template and demo PDF |
| [`assets/`](./assets/) | PNG previews for GitHub |
| [`ats-report.tex`](./ats-report.tex) / [`ats-report.pdf`](./ats-report.pdf) | ATS/HR check template (copy per application; demo PDF) |
| [`Makefile`](./Makefile) | `make`, `make resume`, `make cover-letter`, `make ats-report`, `make previews` |
| [`LICENSE`](./LICENSE) | MIT |

---

## Build

You need `pdflatex`, or [Docker](https://www.docker.com/) (uses `texlive/texlive`).

```bash
make                 # resume.pdf and cover-letter.pdf
make resume          # resume.pdf only
make cover-letter    # cover-letter.pdf only
make ats-report      # ats-report.pdf (demo template at repo root)
make previews        # refresh assets/*.png
make clean           # aux files only
```

Or compile directly:

```bash
pdflatex resume.tex && pdflatex resume.tex
pdflatex cover-letter.tex && pdflatex cover-letter.tex
pdflatex ats-report.tex && pdflatex ats-report.tex
```

---

## Layout notes

- **Paper:** A4. Resume uses tight margins; cover letter uses a classic letter layout that matches the resume typography.
- **Template:** Resume adapted from [Jake Gutierrez's resume](https://github.com/jakegut/resume) (MIT), inspired by [sb2nov/resume](https://github.com/sb2nov/resume).
- **PDF metadata:** Title and author set for search and ATS scanners.

Feel free to reuse the structure - keep the MIT attribution if you ship a derivative of the resume template.

---

## License

MIT © Sébastien Barbier. Resume layout adapted from [jakegut/resume](https://github.com/jakegut/resume) by Jake Gutierrez (MIT), itself based on [sb2nov/resume](https://github.com/sb2nov/resume).
