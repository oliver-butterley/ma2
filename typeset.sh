#!/bin/bash

echo 'Typesetting graphics...'
latexmk -pdf -shell-escape -cd --output-directory=build graphics/*.tex
echo 'Removing aux files related to graphics'
latexmk -pdf -c -cd --output-directory=build graphics/*.tex
echo 'Typesetting main text...'
mkdir --parents build/chapters build/frontmatter
latexmk -pdf --output-directory=build main.tex
echo 'removing aux files related to main text...'
latexmk -pdf -c --output-directory=build main.tex
echo 'Moving final typeset document and cleaning up...'
mkdir dist
mv build/main.pdf dist/main.pdf
rmdir --parents build/chapters build/frontmatter build