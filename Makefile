.PHONY: build clean watch docker

TEX = resume.tex
PDF = resume.pdf

build: $(PDF)

$(PDF): $(TEX)
	@if command -v pdflatex >/dev/null 2>&1; then \
		pdflatex -interaction=nonstopmode -halt-on-error $(TEX); \
		pdflatex -interaction=nonstopmode -halt-on-error $(TEX); \
	elif command -v docker >/dev/null 2>&1; then \
		$(MAKE) docker; \
	else \
		echo "Need pdflatex or docker to build $(PDF)"; exit 1; \
	fi

docker:
	docker run --rm -v "$(CURDIR):/workdir" -w /workdir texlive/texlive:latest \
		pdflatex -interaction=nonstopmode -halt-on-error $(TEX)
	docker run --rm -v "$(CURDIR):/workdir" -w /workdir texlive/texlive:latest \
		pdflatex -interaction=nonstopmode -halt-on-error $(TEX)

watch:
	latexmk -pdf -pvc $(TEX)

clean:
	rm -f *.aux *.log *.out *.toc *.fls *.fdb_latexmk *.synctex.gz
