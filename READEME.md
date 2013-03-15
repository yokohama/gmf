# Google SpredSheet => CSV => GMF

- [#https://github.com/yokohama/styleguide] の改編がかなり手間なので、スプレッドシートで章立てや内容を管理して、それをcsvで落として、それをGMFに変換するツール。

### (styleguide更新の作業の流れ) ###
1. スプレッドシート上で、修正や追加作業を表ベースでおこなう。
2. スプレッドシートのDownload Asから、csvで表をダウンロードする。
3. このスクリプトをつかって、csvからgmfにフォーマット変換する。
4. 作成されたgmfファイルを、README.mdとしてコミットする。

### (使い方) ###
```ruby
ruby scripts/csv2gmf.rb [csvファイルパス] > output.md
```

このような感じで、Googleスプレッドシートから、csvダウンロードしてきたファイルを引数に指定して、出力先を適当なファイルに向けてください。

## (TODO) ###
gdata spreadsheet APIをつかって、csvダウンロードをかえさずに、直接gmfにするようにするともっとらく。
