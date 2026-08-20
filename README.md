# LaTeX Docker Template

日本語・英語の両方を1つの `.tex` ファイルで執筆できる、公式 TeX Live イメージを使用した Docker / Podman 向け LaTeX テンプレートです。

## 特徴

- **公式イメージ `texlive/texlive:latest` を使用**:
  - upLaTeX / pbibtex / dvipdfmx / mendex を標準搭載し、日本語・英語混在文書も同一エンジンでコンパイル可能
- **パーミッション安全**:
  - コンテナ実行時に `--user $(id -u):$(id -g)` を指定しているため、生成された PDF や中間ファイルが `root` 所有になりません
- **オンデマンドなカスタマイズビルド**:
  - 通常は公式イメージをそのまま使用。`Dockerfile` に `RUN` 命令などを追記した場合のみ、自動でローカルイメージをビルドして差分検知（`.image-hash`）
- **SyncTeX 対応**:
  - PDF 閲覧エディタとの相互ジャンプ用データ（`.synctex.gz`）を保持

## ディレクトリ構成

```text
.
├── Dockerfile        # パッケージ追加用の Dockerfile (通常は変更不要)
├── latexmkrc         # latexmk の設定ファイル (upLaTeX + dvipdfmx)
├── tex2pdf.sh        # コンパイル用スクリプト
├── main.tex          # LaTeX 本文のテンプレート
├── references.bib    # 参考文献 (BibTeX)
├── figs/             # 画像格納ディレクトリ (.gitkeep)
├── .dockerignore
└── .gitignore
```

## 使い方

### 1. テンプレートのコピー

```bash
# latex-documents 直下で実行
cp -r template/ <新しいプロジェクト名>/
cd <新しいプロジェクト名>/
```

### 2. コンパイル

```bash
# 通常コンパイル (PDF生成 + 中間ファイルの自動クリーンアップ)
./tex2pdf.sh main.tex

# watch モード (ファイルの保存を検知して自動再コンパイル、Ctrl+C で終了)
./tex2pdf.sh -pvc main.tex

# 中間ファイルを build/ ディレクトリに分離する場合
./tex2pdf.sh -outdir=build main.tex

# 中間ファイルのクリーンアップのみ実行
./tex2pdf.sh -c main.tex
```

生成される PDF は `main.pdf`（指定した `.tex` ファイルと同じベース名）です。

## カスタマイズ

### パッケージの追加
標準でほぼすべての主要パッケージが含まれていますが、追加が必要な場合は `Dockerfile` に追記してください。追記後は `./tex2pdf.sh` 実行時に自動でローカルイメージがビルドされます。

```dockerfile
FROM texlive/texlive:latest
RUN tlmgr update --self && tlmgr install <パッケージ名>
```

## 必要要件

- **Docker** または **Podman**
  - WSL2 環境の場合、Docker Desktop の Settings → Resources → WSL integration で対象ディストリビューションを有効にするか、ディストリビューション内に Docker Engine / Podman をインストールしてください。
