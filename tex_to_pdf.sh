#!/bin/bash
set -euo pipefail

usage() {
  echo "Usage: $0 <tex-file>"
  exit 1
}

[[ $# -eq 1 ]] || usage

TEX_FILE=$1
CONTAINER_NAME="tex-env"

for cli in docker podman; do
  if command -v "$cli" >/dev/null 2>&1; then
    CONTAINER_CLI=$cli
    break
  fi
done

if [[ -z ${CONTAINER_CLI:-} ]]; then
  echo "Error: neither docker nor podman was found on PATH." >&2
  exit 1
fi

if ! "$CONTAINER_CLI" image inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
  echo "Building container image with $CONTAINER_CLI..."
  "$CONTAINER_CLI" build -t "$CONTAINER_NAME" .
fi

"$CONTAINER_CLI" run --rm \
  -v "$(pwd)":/workspace \
  "$CONTAINER_NAME" \
  sh -c "latexmk -pdfdvi -f -interaction=nonstopmode \"$TEX_FILE\" ; latexmk -c"
