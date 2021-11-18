#!/bin/bash

latexmk -pdf -shell-escape -cd --output-directory=build graphics/*.tex
latexmk -pdf -c -cd --output-directory=build graphics/*.tex
latexmk -pdf --output-directory=build main.tex
latexmk -pdf -c --output-directory=build main.tex
mkdir dist
mv build/main.pdf dist/main.pdf