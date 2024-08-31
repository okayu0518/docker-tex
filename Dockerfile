# ベースイメージの指定
FROM debian:bullseye-slim

# TexLiveとその依存パッケージのインストール
RUN apt update &&\
	apt install -y \
	texlive-lang-japanese \
	texlive-latex-extra \
	latexmk \
#	texlive-lang-cjk \
#	texlive-fonts-recommended \
#	xdvik-ja \
	&& rm -rf /var/cache/apk/* 

# latexmkrcファイルをコピー
COPY latexmkrc /root/.latexmkrc

# コンテナ内で作業するディレクトリの設定
WORKDIR /data

