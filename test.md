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
      template: ./templates/eisvogel.tex
      verbose: false
      variable:
        - papersize=A4
        - graphics=true
        - geometry=a4paper,bindingoffset=0.3in,left=1in,right=1in,top=1in,bottom=1.2in,footskip=.6in
      toc: true
      toc-depth: 2
      number-sections: true
      filter:
        - pandoc-include
        - pandoc-crossref
      lua-filter:
        - filters/diagram-generator.lua
      citeproc: true # !!! http://lierdakil.github.io/pandoc-crossref/#citeproc-and-pandoc-crossref
      bibliography:
        - ./bib/testbib.bib
      csl: ./bib/computer.csl
    postprocessors: []

---
# Main1

## Some Section

### Some Subsection

...and here (@eq:eqn01) is the result, see also [@cit01]!

$$ P_i(x) = \sum_i a_i x^i $$ {#eq:eqn01}


### Some Other Subsection

Looking forward to hearing your feedback.

And here some `plantuml` (see @fig:plantfig).

```{#fig:plantfig .plantuml caption="A PlantUML Diagram" }
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response

Alice -> Bob: Another authentication Request
Alice <-- Bob: another authentication Response
```

# Last

## Conclusion