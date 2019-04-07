---
layout: post
title:  Markdown, Pandoc, and LaTeX 
date:    2019-04-07 07:57:10 
categories: writing
synopsis: Using Markdown and Pandoc to create LaTEX formatted documents
---

I've always wanted to learn how to typeset documents using [LaTeX](https://www.latex-project.org/), but found the syntax forbidding.  On the other hand, [Markdown](https://daringfireball.net/projects/markdown/) is really simple to use, but is lacking in features for print such as page breaks.

Whilst writing my current assignment, I decided to take the opportunity to ditch Microsoft Word, and write directly in Markdown. This decision was largely based on being able to quickly write at home (where I exclusively use Linux), and pickup where I left off when in class.

My initial thoughts were that I could render the final draft to a Word document, which could then be tidied up.  However when reading around the subject, I found references to [Pandoc flavoured Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown) which includes some syntax from LaTex, allowing (amongst other things) pagebreaks to be added.  When combined with BibTex, and YAML metadata, this provides all the power I'll ever need from LaTeX combined with the lightweight, easy to remember syntax of Markdown.

## Setting up

### Install texlive-latex-base and Pandoc. 
Rather than install the 1.8G of LaTeX, the base package (around 180M) seems to have everything required for my purposes

```bash
    apt-get install texlive-latex-base pandoc
``` 

### Create your Markdown and metadata

```bash
    echo "\pagebreak\n\n# Hello, World\nAs cited in [@lemin2019]\pagebreak\n\n# References" > example.md
    echo "---\n
    author: [James Lemin]\ntitle: [\"Markdown, Pandoc, and LaTeX\"]\ndate: [2019]\n---" > metadata.yaml
    echo "@book{lemin2019,\ntitle={Markdown, Pandoc, and LaTeX},\nauthor={Lemin, J},\nurl={www.james-lemin.com},\njournal={James-Lemin.com},\nyear={2019}}" > bibliography.bib
```
### Compile your document

```bash
    pandoc example.md --metadata=metadata.yaml --toc --biblio=bibliography.bib --latex-engine=xelatex -o test.pdf 
```
And that's it!