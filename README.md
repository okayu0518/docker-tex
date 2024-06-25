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
