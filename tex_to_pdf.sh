#!/bin/bash

# ファイル名が与えられていない場合のエラーメッセージを修正
if [[ $# -ne 1 ]] ; then
    echo "Usage: $0 <filename_without_extension>"
    exit 1
fi

# ファイル名の変数を設定
filename=$1

# LaTeXファイルをPDFに変換
latexmk -pdfdvi "$filename.tex"

# 一時ファイルを削除
latexmk -c
rm "$filename.dvi"

