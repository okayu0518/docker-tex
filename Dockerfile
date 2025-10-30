# ベースイメージの指定
FROM debian:bullseye-slim

# TexLiveとその依存パッケージのインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    texlive-lang-japanese \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    latexmk && \
    kanji-config-updmap-sys auto && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# latexmkrcファイルをコピー
COPY latexmkrc /root/.latexmkrc

# コンテナ内で作業するディレクトリの設定
WORKDIR /workspace
