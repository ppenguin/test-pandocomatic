---
mainfont: TeX Gyre Pagella
papersize: A4

title: Test pandocomatic
author:
  - John Doe

# date: \AdvanceDate[-5]\today

lang: en-GB

pandocomatic_:
    preprocessors: []
    pandoc:
      from: markdown
      to: pdf
      pdf-engine: lualatex
      template: templates/divlatex/eisvogel.tex
      verbose: true
      variable:
        - papersize=A4
        - graphics=true
        - templatepath=~/.pandoc/templates/divlatex/
        - geometry=a4paper,bindingoffset=0.3in,left=1in,right=1in,top=1in,bottom=1.2in,footskip=.6in
      # toc: true
      toc-depth: 2
      number-sections: true
      filter:
        - pandoc-include
        - pandoc-crossref
      lua-filter:
        - diagram-generator.lua
      citeproc: true
      bibliography:
        - ./testbib.bib
      csl: bib/computer.csl
    postprocessors: []

---
# Main1

## Some Section

### Some Subsection

...and here () is the result, see also [@cit01]!

$$ P_i(x) = \sum_i a_i x^i $$


### Some Other Subsection

Looking forward to hearing your feedback.

And here some `plantuml` (see ).

```{ .plantuml caption="A PlantUML Diagram" }
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response

Alice -> Bob: Another authentication Request
Alice <-- Bob: another authentication Response
```

# Last

## Conclusion