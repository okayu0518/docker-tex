## docker-tex

シンプルな `latexmk` 開発環境を Docker / Podman で包み、ローカル環境を汚さずに PDF を生成します。

## 前提

- Docker もしくは Podman
- bash

## 使い方

1. リポジトリ直下で実行権限を付与  
   `chmod +x tex_to_pdf.sh`
2. 対象の TeX ファイルを指定して実行  
   `./tex_to_pdf.sh main.tex`

スクリプトは以下を自動で行います。

- Docker (優先) もしくは Podman を検出
- `tex-env` イメージが無ければビルド
- カレントディレクトリを `/workspace` にマウントして `latexmk` を実行
- 成功時に中間ファイルをクリーンアップ

出力された PDF (`main.pdf` など) はホスト側の同ディレクトリに生成されます。

## プロジェクト構成

- `Dockerfile`: LaTeX 環境の定義
- `latexmkrc`: `latexmk` 設定
- `main.tex`: サンプル原稿
- `tex_to_pdf.sh`: ビルドスクリプト (Docker / Podman 両対応)
