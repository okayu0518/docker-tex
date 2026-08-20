#!/usr/bin/env bash
set -euo pipefail

IMAGE_DEFAULT="texlive/texlive:latest"
SAFE_DIR_NAME="$(basename "$PWD" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9_.-' '-')"
IMAGE_TAG="tex-env-${SAFE_DIR_NAME}"
HASH_FILE=".image-hash"

usage() {
  cat <<EOF
Usage: $(basename "$0") [latexmk options...] <tex-file>

Compile a LaTeX document using TeX Live in a Docker/Podman container.
Japanese and English text can be mixed in a single .tex file.

Examples:
  $0 main.tex
  $0 -pvc main.tex          # Watch mode (recompile on save)
  $0 -outdir=build main.tex # Output to build directory
  $0 -c main.tex            # Clean intermediate files
EOF
  exit 1
}

if [[ $# -lt 1 ]]; then
  usage
fi

# Determine container runtime (docker or podman)
CONTAINER_CMD=""
if command -v docker >/dev/null 2>&1 && docker version >/dev/null 2>&1; then
  CONTAINER_CMD="docker"
elif command -v podman >/dev/null 2>&1; then
  CONTAINER_CMD="podman"
else
  echo "Error: Neither docker nor podman is available." >&2
  exit 1
fi

# Last argument is the tex file; preceding arguments are forwarded to latexmk
TEX_FILE="${@: -1}"
LATEXMK_ARGS=("${@:1:$#-1}")

if [[ ! -f "$TEX_FILE" ]]; then
  echo "Error: File '$TEX_FILE' not found." >&2
  exit 1
fi

# Determine image to use
IMAGE="$IMAGE_DEFAULT"
if [[ -f Dockerfile ]]; then
  # Only build if Dockerfile contains custom instructions beyond base FROM
  has_custom_instructions() {
    grep -Ev '^\s*(#|$|FROM\s)' Dockerfile >/dev/null 2>&1
  }

  needs_rebuild() {
    [[ ! -f "$HASH_FILE" ]] && return 0
    [[ "$(sha256sum Dockerfile | cut -d' ' -f1)" != "$(< "$HASH_FILE")" ]]
  }

  if has_custom_instructions; then
    if needs_rebuild; then
      echo "Building custom container image '$IMAGE_TAG'..."
      $CONTAINER_CMD build -t "$IMAGE_TAG" .
      sha256sum Dockerfile | cut -d' ' -f1 > "$HASH_FILE"
    else
      echo "Using cached container image '$IMAGE_TAG'..."
    fi
    IMAGE="$IMAGE_TAG"
  fi
fi

# Check for watch mode (-pvc)
WATCH=0
for arg in "${LATEXMK_ARGS[@]}"; do
  if [[ "$arg" == "-pvc" ]]; then
    WATCH=1
    break
  fi
done

RUN_OPTS=(
  --rm
  -v "$PWD":/workspace
  -w /workspace
  --user "$(id -u):$(id -g)"
  -e HOME=/workspace
  -e TEXFILE="$TEX_FILE"
)

if [[ $WATCH -eq 1 ]]; then
  # Use interactive TTY in watch mode for clean Ctrl+C handling
  $CONTAINER_CMD run -it "${RUN_OPTS[@]}" "$IMAGE" \
    latexmk -pdfdvi -f -interaction=nonstopmode -view=none "${LATEXMK_ARGS[@]}" "$TEX_FILE"
else
  $CONTAINER_CMD run "${RUN_OPTS[@]}" "$IMAGE" \
    sh -c 'latexmk -pdfdvi -f -interaction=nonstopmode "$@" "$TEXFILE" && latexmk -c "$TEXFILE"' \
    _ "${LATEXMK_ARGS[@]}"
fi
