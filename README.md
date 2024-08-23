# docker-tex

- ローカルを汚さないように，dockerコンテナでlatexをコンパイルする．
# 使い方
- `chmod +x tex_to_pdf.sh`で実行権限付与しておく．
- Dockerfileがある場所に移動して，`docker build . -t tex-container`を実行すると，イメージがビルドされる．
- `docker run --rm -v $(pwd):/data tex-container ./tex_to_pdf.sh main`で以下の処理を実行
  - ビルドしたイメージ(tex-container)からコンテナを作成
  - カレントディレクトリをコンテナの/dataにマウント
  - `tex_to_pdf.sh`が`main.tex`からpdf作成
  - 中間ファイル削除
  - 処理が終わったコンテナの削除

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

