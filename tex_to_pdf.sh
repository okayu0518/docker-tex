#!/bin/bash

if [[ $# != $((1)) ]] ;then
	echo "Usage $0 <tex-file>"
	exit 1
fi

TEX_FILE=$1
CONTAINER_NAME="tex-env"

# イメージが存在しない場合のみビルド
if ! docker image inspect $CONTAINER_NAME >/dev/null 2>&1; then
    echo "Building Docker image..."
    docker build -t $CONTAINER_NAME .
else
    echo "Using existing Docker image..."
fi

# LaTeXファイルをコンパイル
docker run --rm -v "$(pwd)":/data $CONTAINER_NAME sh -c "latexmk -pdf -interaction=nonstopmode $TEX_FILE && latexmk -c"

