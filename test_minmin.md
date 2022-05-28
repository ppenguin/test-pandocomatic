---
mainfont: TeX Gyre Pagella
papersize: A4

title: Test pandocomatic
author:
  - John Doe

# date: \AdvanceDate[-5]\today

lang: en-GB

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