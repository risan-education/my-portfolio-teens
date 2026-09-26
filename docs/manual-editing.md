# 補足 — ChatGPTの案を自分で保存する

- 作成日: 2026-09-26
- 更新日: 2026-09-27

通常はChatGPTのGitHub接続で保存まで頼めます。この補足は、接続の権限が読み取りだけの環境、接続機能がない環境、AIを使わない日のための方法です。ChatGPTに「そのまま貼り付けられるファイル名とMarkdown本文を出してください」と頼み、自分でGitHubへ保存します。

## GitHubで新規保存する

1. 自分用Privateのトップを開き、ブランチがmainであることを確認する。
2. **Add file → Create new file** を選ぶ。
3. ChatGPTが提案したファイル名を入力する。同名の記録があれば上書きせず、-02などを付ける。
4. ChatGPTの本文を貼る。外側のコードブロックの印（バッククォート3個）は含めない。
5. **Preview** で元メモ・日付・事実・本人の考えを確認する。
6. **Commit changes** で保存する。mainへの直接保存を選べる場合はmainへ保存する。別ブランチしか選べない場合は、main反映は未完了として[接続確認](connection-check.md)へ戻る。
7. 保存したファイルをmainで開き直す。

練習は practice/YYMMDD-connection-practice.md、実記録は例えば experiences/2026/260926-reading.md とします。前者は架空の練習、後者は実際の活動日とテーマへ置き換えるファイル名の例です。

公式資料: [新規ファイルの作成](https://docs.github.com/en/repositories/working-with-files/managing-files/creating-new-files)（確認日: 2026-09-26）。mainが保護されている場合は、設定を解除せず保存方法を確認します。

## 追記する

GitHubで対象ファイルの最新の本文を開いてから編集します。ChatGPTにはその最新の本文に対する追記を頼みます。日付・理由を添えて追記し、元メモと作成日は残し、更新日を編集日にします。保存後にmainで再表示します。

## 接続なしでChatGPTへ頼む

[AGENTS.md](../AGENTS.md)と使いたい[用紙](../templates/README.md)の本文を添付または貼り付け、自分が利用を認めたメモだけを送ります。ChatGPTが参照していない記録を「読んだ」と扱わないようにします。[最初の10分](first-10-minutes.md)はこの方法で進めます。

## 端末内へ保存する

ChatGPTから受け取った本文をテキストエディタへ貼り、「名前を付けて保存」で .md ファイルにします。文字コードはUTF-8です。閉じて開き直し、本文が残っているか確認します。これは端末内保存で、GitHubへの反映ではありません。

GitHubへ移す場合は、自分用Privateで **Add file → Upload files** を選び、保存後の本文を確認します。[公式アップロード手順](https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository)（確認日: 2026-09-26）

テンプレートのボタンがない場合は、配布元の **Code → Download ZIP** で取得・展開し、新しいPrivateへ必要なファイルをアップロードする方法もあります。外側のZIPフォルダではなくREADME等を配置します。隠しファイルや .github/ の表示も確認します。

[はじめ方へ戻る](getting-started.md)／[日常の記録](recording-guide.md)
