# 何これ
プライベートな画像保管庫です。自分のアップロードした画像を他の人が見る場合は、当該のユーザー名を許可リストに追加する必要があります。

# 大まかな機能および状況
- 実装済み
  - 新規登録、ログイン
  - 基本はプライベートで使う
  - 複数画像をまとめて投稿
  - タグ付け
  - タグ編集
  - 閲覧できるユーザーを登録
  - 秘密メモ(遺言的なやつ)機能
- 未実装

# 細かい課題(思いついた順)
- ~~bootstrap試しに導入してみる(Railsチュートリアルで入れてるし)~~ なんか使えば使うほどCSSの理念に反しまくってる気がしてきてやめたわ。少しいじってなんとなく分かったので、今後は必要が出た際に覚えることにするわ。
- 一括タグ付け関係
  - 一括タグ付けの画像選択時、タップしっぱなしでトトトトっと一気に画像選択したい
  - ~~支障はないのだけど、jsでtextareのidを取得すると勝手に変換されるのはなぜだ。例:post[10]→post_10~~ 解決した。仕様なのね。
  - ~~保存時、どう考えても全ポストを一個一個find_byするのおかしい~~ 修正済
  - ~~nextElementSiblingを使ってimgの次のinputを指定するの、どう考えてもアホ（そうするがためにlabel省いちゃってるし）~~ 修正済
  - タグがふくらんだ分だけテキストエリアを拡張(かえってウザい？)
  - ~~クリアボタンいる。タグ・画像・すべて の3つかな。~~ 追加済
- 画像1個のshowページにおいて、左右のスワイプで前後ページへ移動
- ~~削除が機能してない~~ 修正済
- ~~メニューバーをもうちょい大きくすべきかと~~ 修正済
- ~~ul,olの左詰めすぎ~~ 修正済
- ~~写真ページのタグ一覧は、使われてるタグのみにすべきでは~~ 修正済
- タグに登録はしてないけど写真アップ時やタグ編集時に作ったタグは、自動でタグ登録すべきでは
- ~~タグ編集のflashやめる（turbo stream使うほどではないと思うが練習のために使うべきかもしれない。とりあえずは判断保留。）~~ 修正済
- 遺言見せるユーザーは、許可ユーザの中から見せる見せんを選択できるようにしようか。
- 写真一覧での複数タグ選択機能。タグを押した時点でandできるタグが出てくる。あ〜 オア検索もできるようにしてーわ。多分、Postのタグをバラして保存するテーブルがいりそうだわ。なんか色々限界があるようなので。あーめんど。
- コンテナ化、ec2，route53は最低限。
- うわ、トップも作らないと…。ログイン前と後で変えるべきなんだろうか…。
- 一部noticeをsuccessへ置き換え
- ~~写真の単一ページ、サイズでかすぎるって。~~ 修正済
- 結局s3のポリシーはあんなガバガバでいいのか？誰かが言ってたようにクラウドフロント使ってちゃんとすべきか
- ~~許可ユーザページにもタグ一覧付けないと。~~ 修正済
- あ、メール認証もしなきゃ。でも昔のTumblrみたいにソッコー使えるのも楽しいと思うんだよなあ。
- タグのcsv取り込み
- タグのプリセット
- 写真のコレクションの概念付けるべきか。一旦はいいか。いや、簡単にできる気もする。でもかえって分かりにくくなるか。そんな何個もコレクションの趣味がある奴、いるか？切手と硬貨とテレカとか？（例えが古い）
- ~~グループなし、の文字が幅を食う。無くすか。~~ 修正済
- 写真へのタグ付けは、カンマでおわるようにしたほうがいいかも。もしくはJavaScriptでなんとかするか。
- resourcesを直す、不要なCやVを消す
- 「戻る」の挙動を正しくする必要がある。backとrefererではなく、なるべくsessionを使わないと解決できないのか？もしくはparamsでもなんか行けそう。色々試してみる。
- タイトル付ける
- 空の項目をはじくバリデーション、ほとんど設定してない
- エラーメッセージを全然テストしていない。
- ボタンのクラス名や挙動をもう少し統一する
- 秘密メモを許可ユーザーに表示されるようにする






