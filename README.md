## 概要
PC内の類似画像を検索するソフトです。

## 動作環境
- windows7以上だと思う（Windows10で開発中）

## ダウンロード
ちゃんとしたのができたら
今はソースをダウンロードしてお試しください。

## Tools
- wNim( https://github.com/khchen/wNim )
- nim-image-similar( https://github.com/nnahito/nim-image-similar )

## 開発用コマンド

### ビルド
```
nimble build
```

### ビルド＆実行
```
nimble build && nimble run
```

### リリースビルド
```
nimble build -d:release --opt:size --passL:-s --app:gui
```