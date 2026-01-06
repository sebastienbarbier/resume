# Sébastien Barbier - Resume

Source for my resume as a Software Engineer based in Zurich.

**[Download PDF](./resume.pdf)** · [sebastienbarbier.com](https://sebastienbarbier.com) · [contact@sebastienbarbier.com](mailto:contact@sebastienbarbier.com)

This repository is the source of truth: LaTeX you can read, fork, or rebuild yourself.

---

## Preview

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

---

## What’s inside

| File | Role |
|------|------|
| [`resume.pdf`](./resume.pdf) | Built resume (2 pages, A4) |
| [`resume.tex`](./resume.tex) | Full resume content and layout |
| [`Makefile`](./Makefile) | One-command PDF build |
| [`LICENSE`](./LICENSE) | MIT |

Sections cover experience, projects ([Shellui](https://shellui.com), [Seven23](https://seven23.io)), skills, education, and languages.

---

## Build the PDF

You need `pdflatex`, or [Docker](https://www.docker.com/) (uses `texlive/texlive`).

```bash
make
```

That refreshes `resume.pdf`. Aux files only:

```bash
make clean
```

Or compile directly:

```bash
pdflatex resume.tex
pdflatex resume.tex   # second pass for stable links/refs
```

---

## Layout notes

- **Paper:** A4, tight margins, compact item spacing so two pages stay dense but readable.
- **Template:** Adapted from [Jake Gutierrez / sb2nov](https://github.com/sb2nov/resume) (MIT).
- **PDF metadata:** Title and author set for search and ATS scanners.

Feel free to reuse the structure for your own resume - keep the MIT attribution if you ship a derivative of the template.

---

## License

MIT © Sébastien Barbier. The underlying LaTeX template is also MIT, originally by Jake Gutierrez based on [sb2nov/resume](https://github.com/sb2nov/resume).
