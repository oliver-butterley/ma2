#!/bin/bash

echo 'Typesetting graphics...'
latexmk -pdf -shell-escape -cd --output-directory=build graphics/*.tex
# echo 'Removing aux files related to graphics'
# latexmk -pdf -c -cd --output-directory=build graphics/*.tex
echo 'Typesetting main text...'
mkdir --parents build/chapters build/frontmatter
latexmk -pdf --output-directory=build main.tex
# echo 'removing aux files related to main text...'
# latexmk -pdf -c --output-directory=build main.tex
echo 'Moving final typeset document...'
mkdir dist
cp build/main.pdf dist/main.pdf
cp build/booklets.aux dist/booklets.aux
# rmdir build/chapters build/frontmatter build

echo 'Read parts of the document and format for booklet printing'
part=0
while read line; do 
    echo "Creating booklet for page range $range"
    pdfjam --booklet true --delta '1.0cm 0cm' --paper a4paper --landscape --outfile dist/part$part.pdf --no-tidy -- dist/main.pdf $line
    part=$((++part))
done < dist/booklets.aux