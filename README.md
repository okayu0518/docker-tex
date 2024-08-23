# Docker-based LaTeX Project

This project provides a Dockerized environment to compile LaTeX files into PDFs using `latexmk`. It supports Japanese language documents and includes a script for easy compilation.

## Project Structure

- **Dockerfile**: Defines the Docker image with all necessary LaTeX packages.
- **latexmkrc**: Configuration file for `latexmk`.
- **main.tex**: Sample LaTeX file.
- **tex_to_pdf.sh**: Bash script for compiling LaTeX files into PDFs.

## Getting Started

### Prerequisites

- Docker installed on your machine.

### Building the Docker Image

Build the Docker image by running:

```bash
docker build -t latex-env .

