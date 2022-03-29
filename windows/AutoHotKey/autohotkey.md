# AutoHotKey

[https://snowsystem.net/other/windows/windows-capslock-ctrl-f13-key/](https://snowsystem.net/other/windows/windows-capslock-ctrl-f13-key/)

## AutoHotkey でやりたいこと

無変換キーをベースにしたショートカットキー

- カーソルキーを無変換 HJKL で操作する
- Home, End を無変換 + AE で操作する
- Backspace，Delete を無変換 + NM で操作する
- Enter を無変換 + ;(セミコロン)や:(コロン)で操作する
- 単語単位のカーソル移動を無変換 + UI で操作する
- カーソル位置から行末までの切り取りを無変換 + O で操作する

変換キーをベースにしたショートカットキー

- PageUp, PageDwon を変換 + JK で操作する
- Home, End を変換 + HL で操作する
- Alt + ←，Alt + → を変換 + UI で操作する

## AutoHotKey のインストール

1. 公式 HP からダウンロード
2. ダウンロードしたファイルを実行しインストールする

## AutoHotKey を自動起動するようにする

作成した.ahk ファイルを自動起動するためスタートアップに登録する

Windowns キー + R で「ファイル名を指定して実行」画面を表示し「shell:startup」と入力し Enter キーでスタートアップのフォルダを表示する

スタートアップのフォルダに.ahk のショートカットファイルを配置しておくと起動時に実行される

### 他参考サイト

[https://gist.github.com/toriwasa/64fc9e1a8cce620b8ff92f0ae38075f7](https://gist.github.com/toriwasa/64fc9e1a8cce620b8ff92f0ae38075f7)

[https://qiita.com/chesscommands/items/bfef1fae2b21553bd5f6](https://qiita.com/chesscommands/items/bfef1fae2b21553bd5f6)
