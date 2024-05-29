#!/bin/bash

if [[ $# != $((1)) ]] ;then
	echo "Usage $0 $1"
	exit 1
fi

latexmk -pdfdvi $1.tex
rm -f $1.aux $1.dvi 
