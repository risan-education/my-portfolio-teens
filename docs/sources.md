# 参照・再利用の記録

- 作成日: 2026-09-26
- 更新日: 2026-09-27

## 小学生版

参照元: [risan-education/my-portfolio-elementary](https://github.com/risan-education/my-portfolio-elementary)、確認日: 2026-09-26、参照コミット: fe4388603266155ebf2e93d767f95f4d55fe7afc。

README、はじめ方、GitHubの基本、AIガイド、接続確認、Claude Codeの補足、活動記録・探究ノート、AI編集指示、移行ガイドを参照しました。ChatGPTへメモを伝えて案を確認し保存する流れを、中高生本人が操作する案内へ適用しています。本人の選択、共通用紙、原記録保持、YYMMDDのファイル名を維持しています。

小学生版の接続・保存に関する説明は、公式資料と配布元の実利用報告をもとに改訂しました。0.4.0では書込対応の案内を追加し、有料プランやアプリを必須としない構成へ改めました。0.5.0では配布元の報告と環境別の再現確認を区別し、接続名・プラン・保存経路を利用環境で確かめる説明に揃えています。以前の版の一律に読み取り専用とする説明は採用せず、契約だけで直接保存できるとも案内しません。料金の固定円換算や未検証の機能は引き継いでいません。

[小学生版のLICENSE](https://github.com/risan-education/my-portfolio-elementary/blob/fe4388603266155ebf2e93d767f95f4d55fe7afc/LICENSE)はMITです。再利用した部分の Copyright (c) 2026 risan-education と許諾・免責全文は [LICENSES/MIT-elementary.txt](../LICENSES/MIT-elementary.txt) に保持しています。中高生版のオリジナル部分は初版の公開時からCC BY 4.0とし、[LICENSE](../LICENSE)で範囲を分けます。原文のまま取り込んだshadow-note.mdはMITのままで、他の権利者の表示をadash333へ置き換えません。

[引き継いだ架空記録](../examples/migration/experiences/shadow-note.md)は、同コミットの [examples/shadow-note.md](https://github.com/risan-education/my-portfolio-elementary/blob/fe4388603266155ebf2e93d767f95f4d55fe7afc/examples/shadow-note.md)をファイル名・本文・日付を変えずに収録したものです。案内と現在の振り返りは別ファイルにしました。

引き継ぎの案内では、同コミットの [questions.md](https://github.com/risan-education/my-portfolio-elementary/blob/fe4388603266155ebf2e93d767f95f4d55fe7afc/questions.md)、[家庭の探究シート](https://github.com/risan-education/my-portfolio-elementary/blob/fe4388603266155ebf2e93d767f95f4d55fe7afc/templates/unit-of-inquiry.md)、[その架空例](https://github.com/risan-education/my-portfolio-elementary/blob/fe4388603266155ebf2e93d767f95f4d55fe7afc/examples/uoi-packaging.md)も参照しました。旧台帳の状態と保護者の計画を保持する方針に反映しています。[複数リンクの移行例](../examples/migration/linked-source/questions.md)は本教材で作成した架空例で、元ファイルの転載ではありません。

## ファイル名の形式の追加確認

2026-09-26、小学生版の命名規則の更新（コミット [433589c4698630bf0803c54e2ebac6d41b73125c](https://github.com/risan-education/my-portfolio-elementary/commit/433589c4698630bf0803c54e2ebac6d41b73125c)）と[日付のガイド](https://github.com/risan-education/my-portfolio-elementary/blob/433589c4698630bf0803c54e2ebac6d41b73125c/docs/file-dates.md)を確認しました。ファイル名はYYMMDD-xxx.md、本文の日付はYYYY-MM-DDという共通ルールを、移行ガイド・架空の移行例・参照リンクに反映しています。上記の原文を再利用した際の参照コミットは、来歴として保持しています。

## 探究の構成

[Myポートフォリオの参考記事](https://risan.jpn.org/?p=14459)と[要件定義](requirements.md)をもとに6段階を設けています。状態管理、根拠リンク、本人の選択、AI案の区別は本教材の独自仕様です。段階と大学群を対応させた評価は実装していません。

## 入試準備・自己理解の資料

2026-09-26、文部科学省の[大学入試情報](https://www.mext.go.jp/nyushi/)と[学校推薦型選抜の推薦書の説明](https://www.mext.go.jp/a_menu/koutou/koudai/detail/1406125.htm)、[探究のプロセス](https://www.mext.go.jp/content/1421972_2.pdf)、[摂南大学2027年度総合型選抜募集要項](https://www.setsunan.ac.jp/admission/faculty/requirements/files/comprehensive/2027sougou_youkou.pdf)を参照しました。[出願ガイド](admissions-guide.md)に出典を付けています。学科別の評価方法と生成AIの禁止例を確認し、全大学共通の条件としては扱っていません。高1頃からの準備計画は本教材の提案です。

[BFI-2開発者の説明](https://www.ocf.berkeley.edu/~johnlab/bfi.html)と[日本語版の検証研究](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2022.924351/full)を同日に確認しました。[自己理解ガイド](self-understanding.md)の会話用の問いは本教材の独自作成で、質問紙の転載や心理検査の実装ではありません。

## 探究テーマの資料

IBの公式概要、2027年初回評価の更新案内・概要PDF・ガイドの関連箇所、公開題名例、研究課題の絞り方、AIに関する説明を参照しました。[EE参考ガイド](extended-essay-guide.md)に出典・版・確認範囲を記載しています。[15の架空の研究計画](../examples/extended-essay/README.md)と[テーマ選びの二つの方法](choosing-inquiry-theme.md)、[記録から選ぶ会話例](../examples/theme-selection.md)は独自に作成した教材で、IBの提出物や採点例の転載ではありません。

探究テーマの教材には、[文部科学省・JST・大学の公式資料の調査メモ](inquiry-theme-sources.md)を追加しました。確認した実践事例・入試ページと、本教材が独自に作成した[架空の探究テーマ18例](../examples/inquiry-themes/README.md)を区別し、資料の確認範囲と各例へ反映した観点を記しています。

## サービス情報

ChatGPTの契約・年齢条件・公式アプリ導入・接続は[はじめ方](getting-started.md)、能力の違いは[接続確認](connection-check.md)、ファイル編集は[デスクトップ補足](chatgpt-desktop.md)、GitHub登録は[基本ガイド](github-basics.md)に公式出典と確認日を記載しています。権限と移譲は[移行ガイド](migration.md)、履歴バックアップは[復元ガイド](backup-and-restore.md)、Claude Codeは[補足ガイド](claude-code.md)を参照してください。

公式文書の確認と実アカウントでの操作確認は異なります。[受入確認](acceptance-review.md)に確認範囲を記録します。

## 0.5.0の追加確認

2026-09-27、[ChatGPTの利用環境](https://learn.chatgpt.com/docs/use-chatgpt)と[Codex cloud](https://learn.chatgpt.com/docs/cloud)を確認し、環境ごとの機能差とPRを使う流れを[接続の確認記録](connection-environments.md)へ反映しました。これは読者のアカウントでの書込検証ではありません。

同日、[摂南大学2027年度募集要項](https://www.setsunan.ac.jp/admission/faculty/requirements/files/comprehensive/2027sougou_youkou.pdf)の生成AI利用に関する注意（PDFの3ページ目）を再確認しました。これを全提出先の条件へ拡張せず、[提出条件確認](../templates/submission-check.md)で今回の作業ごとの可否を確かめます。[法政大学の応募書類の説明](https://www.hosei.ac.jp/application/files/4016/0445/5727/ESPR_.pdf)の経験の過程を伝える観点と、ガクチカ・自己PR・志望動機の違いを[卒業後のガイド](after-high-school.md)へ反映しました。

大学版が仮の要件定義段階であることは配布元の説明に基づきます。[共通仕様](portfolio-format.md)と[大学版への移行手順](migration-to-univ.md)は、この中高生版で新たに作成した設計案です。大学版の実装を参照・検証したものではありません。[探究レポート](../examples/inquiry-report.md)と[面接会話](../examples/interview-session.md)は、既存の架空原記録に基づく教材として作成しました。
