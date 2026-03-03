.PHONY: build resume cover-letter previews clean watch docker

RESUME_TEX = resume.tex
COVER_TEX = cover-letter.tex
RESUME_PDF = resume.pdf
COVER_PDF = cover-letter.pdf

build: resume cover-letter

resume: $(RESUME_PDF)

cover-letter: $(COVER_PDF)

$(RESUME_PDF): $(RESUME_TEX)
	@$(MAKE) compile TEX=$(RESUME_TEX)

$(COVER_PDF): $(COVER_TEX)
	@$(MAKE) compile TEX=$(COVER_TEX)

compile:
	@if command -v pdflatex >/dev/null 2>&1; then \
		pdflatex -interaction=nonstopmode -halt-on-error $(TEX); \
		pdflatex -interaction=nonstopmode -halt-on-error $(TEX); \
	elif command -v docker >/dev/null 2>&1; then \
		$(MAKE) docker TEX=$(TEX); \
	else \
		echo "Need pdflatex or docker to build $(TEX)"; exit 1; \
	fi

docker:
	docker run --rm -v "$(CURDIR):/workdir" -w /workdir texlive/texlive:latest \
		pdflatex -interaction=nonstopmode -halt-on-error $(TEX)
	docker run --rm -v "$(CURDIR):/workdir" -w /workdir texlive/texlive:latest \
		pdflatex -interaction=nonstopmode -halt-on-error $(TEX)

# Refresh README preview PNGs (needs poppler's pdftoppm, or Docker image below)
previews: resume cover-letter
	@if command -v pdftoppm >/dev/null 2>&1; then \
		pdftoppm -png -r 150 resume.pdf assets/page; \
		pdftoppm -png -r 150 -singlefile cover-letter.pdf assets/cover-letter; \
	elif command -v docker >/dev/null 2>&1; then \
		docker run --rm -v "$(CURDIR):/workdir" -w /workdir minidocks/poppler \
			pdftoppm -png -r 150 resume.pdf assets/page; \
		docker run --rm -v "$(CURDIR):/workdir" -w /workdir minidocks/poppler \
			pdftoppm -png -r 150 -singlefile cover-letter.pdf assets/cover-letter; \
	else \
		echo "Need pdftoppm or docker for previews"; exit 1; \
	fi

watch:
	latexmk -pdf -pvc $(RESUME_TEX)

clean:
	rm -f *.aux *.log *.out *.toc *.fls *.fdb_latexmk *.synctex.gz
