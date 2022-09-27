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
rmdir build/chapters build/frontmatter build

echo 'Extract parts of the document and format for booklet printing'
pdfjam dist/main.pdf '1-12' --booklet true --delta '1.0cm 0cm' --paper a4paper --landscape --outfile dist/part0.pdf
pdfjam dist/main.pdf '13-24' --booklet true --delta '1.0cm 0cm' --paper a4paper --landscape --outfile dist/part1.pdf
