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
mv build/booklets.aux dist/booklets.aux

rmdir build/chapters build/frontmatter build

echo 'Extract parts of the document and format for booklet printing'
start=1
part=0
while read line; do 
    end="$line"
    range="$start-$end"
    echo "Creating booklet for page range $range"
    pdfjam --booklet true --delta '1.0cm 0cm' --paper a4paper --landscape --outfile dist/part$part.pdf --no-tidy -- dist/main.pdf $range 
    start=$(( "$end" + 1 ))
    part=$((++part))
done < dist/booklets.aux