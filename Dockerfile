# ベースイメージの指定
FROM debian:stable-slim

# TexLiveとその依存パッケージのインストール
RUN apt update && \
    apt install -y --no-install-recommends \
    texlive-lang-japanese \
    texlive-latex-base \
    texlive-latex-recommended \
		texlive-latex-extra \
    texlive-fonts-recommended \
		texlive-fonts-extra \
		texlive-plain-generic \
    latexmk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    kanji-config-updmap-sys auto

# latexmkrcファイルをコピー
COPY latexmkrc /root/.latexmkrc

# コンテナ内で作業するディレクトリの設定
WORKDIR /workspace
