PDFVIEWER ?= okular

.PHONY: clean all pdf%
all: test_minmin.pdf

clean:
	rm -f *.pdf* *.out *.docx

%.pdf: %.md
	./md2pdf.sh $<

test_minmin.pdf: test_minmin.md defaults.yaml
	pandoc --defaults $(firstword $(filter %.yaml,$^)) $< -o $@ && $(PDFVIEWER) $@

test_minimal.pdf: test_minimal.md
	pandocomatic -b --data-dir=$(CURDIR) -o $@ $< && $(PDFVIEWER) $@
