PDFVIEWER ?= okular

.PHONY: clean all pdf% tstpipe
all: test_minmin.pdf

clean:
	rm -f *.pdf* *.out *.docx

%.pdf: %.md
	pandocomatic -b -o $@ $< && $(PDFVIEWER) $@

test_minmin.pdf: test_minmin.md defaults.yaml
	pandoc --defaults $(firstword $(filter %.yaml,$^)) $< -o $@ && $(PDFVIEWER) $@

test_minimal.pdf: test_minimal.md
	pandocomatic -b --data-dir=$(CURDIR) -o $@ $< && $(PDFVIEWER) $@

tstpipe: test_minmin.md defaults.yaml
	pandoc --verbose --defaults $(firstword $(filter %.yaml,$^)) -o $(subst .md,-tstpipe.pdf,$<) < $< && $(PDFVIEWER) $(subst .md,-tstpipe.pdf,$<)
