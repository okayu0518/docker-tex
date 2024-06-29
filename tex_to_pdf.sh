#!/bin/bash

if [[ $# != $((1)) ]] ;then
	echo "Usage $0 $1"
	exit 1
fi

latexmk  -pdfdvi $1.tex
latexmk  -c
rm $1.dvi
