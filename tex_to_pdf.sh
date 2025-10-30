#!/bin/bash

# usage function
usage() {
  echo "Usage: $0 <tex-file>"
  exit 1
}

# determine docker or podman
if command -v docker >/dev/null 2>&1; then
  DOCKER="docker"
elif command -v podman >/dev/null 2>&1; then
  DOCKER="podman"
else
  echo "Error: neither docker nor podman found."
  exit 1
fi

# build image
build_image() {
  echo "Building container image with $DOCKER..."
  $DOCKER build -t $CONTAINER_NAME .
}

# compile tex
compile_tex() {
  $DOCKER run --rm -v "$(pwd)":/workspace $CONTAINER_NAME sh -c \
    "latexmk -pdfdvi -f -interaction=nonstopmode $TEX_FILE; \
   latexmk -c"
}

# check arguments
if [[ $# -ne 1 ]]; then
  usage
fi

TEX_FILE=$1
CONTAINER_NAME="tex-env"

# check if image exists
if ! $DOCKER image inspect $CONTAINER_NAME >/dev/null 2>&1; then
  build_image
else
  echo "Using existing container image..."
fi

# compile
compile_tex
