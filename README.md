# 概要 
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
- ~~bootstrap試しに導入してみる(Railsチュートリアルで入れてるし)~~ 試した結果、導入見送り
- 一括タグ付け関係
  - 一括タグ付けの画像選択時、タップしっぱなしで画像をなぞることにより一気に画像選択したい
  - ~~支障はないが、jsでtextareのidを取得すると勝手に変換されるのはなぜ？例:post[10]→post_10~~ 仕様でした
  - ~~保存時、どう考えても全ポストを一個一個find_byするのはおかしい~~ 完了
  - ~~nextElementSiblingを使ってimgの次のinputを指定するの、どう考えても愚か（そうするがためにlabel省いてるのも含め）~~ 完了
  - タグがふくらんだ分だけテキストエリアを拡張(かえってウザいか。)
  - ~~クリアボタンいる。タグ・画像・すべて の3つかな。~~ 完了
  - ~~リセットもいる~~ 完了
- ~~画像1個のshowページにおいて、左右のスワイプで前後ページへ移動~~ ~~半分完了(許可ユーザー写真は未完)~~ 完了
- ~~削除が機能してない~~ 完了
- ~~メニューバーをもうちょい大きくすべきかと~~ 完了
- ~~ul,olの左詰めすぎ~~ 完了
- ~~写真ページのタグ一覧は、使われてるタグのみにすべきでは~~ 完了
- ~~タグに登録はしてないけど写真アップ時やタグ編集時に作ったタグは、自動でタグ登録すべきでは~~ 完了
- ~~タグ編集のflashやめる（turbo stream使うほどではないと思うが練習のために使うべきかもしれない。とりあえずは判断保留。）~~ 完了
- ~~遺言見せるユーザーは、許可ユーザの中から見せる見せんを選択できるようにしようか。~~ 完了
- ~~写真一覧での複数タグ選択機能。タグを押した時点でandできるタグが出てくる。オア検索もできるようにしたい。多分、Postのタグをバラして保存するテーブルがいりそう(今のままだと制約が多すぎる)。~~ 一旦下記に整理。
- 詳細検索関係
  - ~~AND検索(単純な実装)~~ ~~yourphotoのみ完了~~ 完了
  - ~~タグを押した時点でandできるタグが出てくる~~ ~~一旦完了(トグルできないのを修正する)~~ ~~yourphotoのみ完了~~ 完了
  - ~~OR検索~~ ~~yourphotoのみ完了~~ 完了
  - ~~ANDとORの複合検索~~ ~~yourphotoのみ完了~~ 完了
  - 「よく使う検索」を登録できるようにする 
- ~~コンテナ化、ec2，route53は最低限。~~ 完了
- ~~トップページを作る。ログイン前と後で内容を変えるべきかも考える。~~ 完了
- ~~一部noticeをsuccessへ置き換え~~ 完了
- ~~写真の単一ページ、サイズがでかすぎる。~~ 完了
- AWSクラウドフロントを理解した上で導入検討する
- ~~許可ユーザページにもタグ一覧付けないと。~~ 完了
- メール認証
- タグのcsv取り込み
- タグのプリセット
- 写真のコレクションの概念付けるべきか考える
- ~~グループなし、の文字が幅を食う~~ 完了
- ~~写真へのタグ付けは、カンマでおわるようにしたほうがいいかも。もしくはJavaScriptでなんとかするか。~~ 完了
- ~~resourcesを直す、不要なCやVを消す~~ 完了
- ~~「戻る」の挙動を正しくする必要がある。backとrefererではなく、なるべくsessionを使わないと解決できないのか？もしくはparamsでもなんか行けそう。色々試してみる。~~ 完了
- ~~タイトル付ける~~ 完了
- ~~空の項目をはじくバリデーション、ほとんど設定してない~~ 完了
- エラーメッセージを全然テストしていない。
- ボタンのクラス名や挙動をもう少し統一する
- ~~秘密メモを許可ユーザーに表示されるようにする~~ 完了
- ~~サインアップが英語名のまま~~ 完了
- ~~退会機能~~ 完了
- ~~投稿時、正方形でトリミング可能(俺得)~~ 完了
- ~~post.tagにバリデーションが必要~~ 完了
- ~~読点「、」を半角カンマの代わりに使えるようにする~~ 完了
- 配色のカスタマイズ
- タグ・タググループ編集でransack部分をどうしてもturbo化できない
- 許可ユーザーに編集権限を与えるかどうかの設定(家族で共通のコレクションがある時とか？)
- 投稿日はあった方がいいかも
- 画像をまとめて選択し、一気に削除する機能
