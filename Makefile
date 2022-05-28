PDFVIEWER ?= okular

.PHONY: clean all pdf%
all: test_minmin.pdf

clean:
	rm -f *.pdf* *.out *.docx

%.pdf: %.md
	./md2pdf.sh $<

test_minmin.pdf: test_minmin.md defaults.yaml
	pandoc --defaults defaults.yaml $< -o $@ && $(PDFVIEWER) $@
