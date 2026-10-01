# Myポートフォリオ〈中高生版〉

- 作成日: 2026-09-26
- 更新日: 2026-10-01

**ChatGPTに話しかけて、経験・問い・作品・考えの変化を、自分のポートフォリオとして残します。** 「やってみた」「うまくいかなかった」「気になった」を一言から。ChatGPTが用紙や文章を整理し、本人が内容を確かめて、自分用の **Private（非公開）GitHubリポジトリ** に保存します。毎日書く必要も、すべての欄を埋める必要もありません。

**初めての人は [最初の10分](docs/first-10-minutes.md) へ。** 登録や接続の前に、ChatGPTだけで一言メモを一件作ってみます。**接続後はメモを送るだけで一言メモの案になります。活動日を書かなければ、話しかけた日の出来事として記録されます**（「昨日」と書けば前日）。何と話しかければよいか迷ったら、[ChatGPTへのプロンプト例とできあがった記録](examples/prompts/README.md)を見てください。

## はじめに

このポートフォリオの第一の目的は、大学入試の総合型選抜・推薦入試への備えです。記録は入試で終わらず、面接、大学生活、就職活動、社会人になってからのAI利用へ引き継げます。大学版 `my-portfolio-univ` は仮の要件定義段階です。[移行準備](docs/migration-to-univ.md)と[共通仕様](docs/portfolio-format.md)を用意し、配布準備が整った後に新しい自分用Privateへ移せるようにします。同じ保存先で続ける方法も選べます。

- **日々の記録と考えを残す。** 部活・読書・行事・趣味・疑問を、一言から残します。志望校が未定でも始められます。
- **一つの主テーマを6段階で探究する。** 高1頃から大学の学び・募集要項と自分の関心を照らし合わせ、問いを立て、検証・発信・協働まで継続します。入試対策に取り組む場合の中心となる活動で、取り組むかどうか、いつ始めるかは本人が選びます。
- **自分を知り、伝える材料にする。** 得意・苦手・好き・嫌いと性格の傾向を本人の言葉と記録から整理し、大学・学部選び、志望理由書・活動報告、[面接](docs/interview-guide.md)、[就職活動のガクチカ](docs/after-high-school.md)、[AIへ渡す自己紹介](docs/portability.md)に使います。

中学生・高校生が共通の用紙を使うテンプレート集（0.5.2）です。本人が記録と利用範囲を選び、保護者は希望に応じて支援します。

### 今の学年・状況から選ぶ

| 状況 | まずすること |
| --- | --- |
| 中1〜中3。まず残したい | [最初の10分](docs/first-10-minutes.md) → [はじめ方](docs/getting-started.md) → [日常の記録](docs/recording-guide.md) |
| 高1頃。入試を意識し始めた | [探究テーマの選び方](docs/choosing-inquiry-theme.md) → [6段階の探究ガイド](docs/inquiry-project-guide.md) → [出願準備](docs/admissions-guide.md) |
| 高2〜高3。出願・面接が近い | [出願準備と出力](docs/admissions-guide.md) → [提出条件確認](templates/submission-check.md) → [面接の準備](docs/interview-guide.md) |
| 大学生・社会人。続けたい | [大学版への移行準備](docs/migration-to-univ.md) → [高校卒業後も続ける](docs/after-high-school.md) → [AIへ持ち運ぶ](docs/portability.md) |
| 小学生版を使っていた | [引き継ぎガイド](docs/migration.md) |

### 高1で募集要項を読んだら、6段階の探究を始める

まず[探究学習のテーマの選び方](docs/choosing-inquiry-theme.md)へ。「志望大学・学部に合わせて選ぶ方法」と「好きなテーマ・日々の記録から選び、大学・学部を探す方法」を紹介しています。大学未定でも、好きな問いから探究を始められます。

**テーマが思い浮かばないときは、[学部・学科の関心別に読む、架空の探究テーマ18例](examples/inquiry-themes/README.md)へ。** 文学・法・経済・教育・心理・情報・工学・農学・看護・芸術などの例で、身近な疑問から高1〜高3の継続的な探究へ育てる方法を読めます。[文部科学省・JST・大学の公式資料の探し方](docs/inquiry-theme-sources.md)も紹介しています。

[IBDPのExtended Essayを参考にするガイド](docs/extended-essay-guide.md)と、[研究論文につながる架空例15件](examples/extended-essay/README.md)もあります。問いの絞り方、資料の分析、根拠・反論・限界のまとめ方を読めます。

志望先がある場合は、**募集要項の確認 → 主テーマを一つ選ぶ → [6段階の探究ガイド](docs/inquiry-project-guide.md)で計画・実践 → 出願用に整理する**、という流れで進めます。好きなテーマから始める場合は、探究と並行して大学・学部と募集要項を調べます。

> 募集要項と私の関心をもとに、一つの主テーマで探究を始めたいです。6段階の探究ガイドに従い、私とテーマを選んで、6段階全体の見通し、最初の問いと行動予定、振り返りの予定を作ってください。

### 総合型選抜・推薦入試用に出力する

[出願準備と出力の手順](docs/admissions-guide.md)で、高校1年生頃からの情報収集、探究計画、実践、振り返り、出願年度の確認を案内しています。ChatGPTには、次のように伝えます。

> ［入学年度・大学・学部・学科・選抜方式］の総合型選抜・推薦入試に向けて、このポートフォリオを整理したいです。公式の募集要項とAI利用条件を先に確認し、許可された範囲で、私が選んだ記録から活動報告や志望理由書、面接準備の材料を出力してください。根拠の記録と不足情報を示し、提出用本文は別にしてください。条件が未確認・禁止なら本文は作らないでください。

大学・学部を選ぶ段階なら、[自己理解の手順](docs/self-understanding.md)に沿って「得意・苦手・好き・嫌いと性格の傾向を、私への確認と根拠付きでまとめ、学部選びの参考にしてください」と頼めます。面接が近づいたら[面接準備シート](templates/interview-prep.md)を使います。

## ChatGPTで始める

**小学生版を使っていた人は、先に[引き継ぎガイド](docs/migration.md)へ進んでください。** おすすめは、中高生版から新しいPrivateリポジトリを作り、小学生用リポジトリの内容をコピーする方法です。

1. **[はじめ方](docs/getting-started.md)** を開き、年齢・同意条件を確認してChatGPTのアカウントを用意する。
2. **GitHubのアカウントと自分用Privateを用意**する。配布元の「Use this template」から作れます。
3. **ChatGPTにGitHubを接続**し、自分用Privateを対象にする。書込対応の接続では作成・追記・保存を頼めます。[確認済み・未確認の環境](docs/connection-environments.md)を読み、自分の接続でできることを確かめます。
4. **AGENTS.mdを読んでもらい、[架空の記録で保存を確認](docs/connection-check.md)**する。
5. **体験を伝え、案を確認して保存する。**

用紙やファイル名はChatGPTに選んでもらえます。初めからGitやMarkdownを覚える必要はありません。有料プランやアプリは必須ではありません。保存機能が使えない環境では、[自分で貼り付ける方法](docs/manual-editing.md)で続けられます。

## 次からは、このように頼めます

自分用の保存先で初期設定を終えたら、普段の言葉で伝えます。

> 今日のメモから、記録の案を作ってください。

案を読み、元メモと日付、本人の言葉や考えが保たれていることを確認します。

> この内容で保存してください。

保存できる環境ではChatGPTが自分用Privateへ保存し、保存先を報告します。標準はmainですが、別ブランチ・PRが必要な場合は先に方法を確認し、mainへの反映と区別します。GitHubでファイルを開き直して完了です。[日常の使い方](docs/recording-guide.md)／[依頼例](docs/ai-guide.md)

## 今の目的から選ぶ

| 目的 | ChatGPTへの頼み方 | 用紙 |
| --- | --- | --- |
| 残す | このメモを残したい | [一言メモ](templates/quick-note.md)・[活動記録](templates/experience.md)・[作品カード](templates/work.md) |
| 深める | この問いを調べたい。次の一歩を相談したい | [探究ノート](templates/inquiry.md)・[問いの一覧](questions.md)・[6段階の探究](templates/inquiry-project.md) |
| 振り返る | 選んだ記録から、考えの変化を振り返りたい | [振り返り](templates/reflection.md)・[年間振り返り](templates/annual-review.md) |
| 自分を知る | 得意・苦手・好き・嫌いを、根拠付きで整理したい | [自己理解](templates/self-understanding.md)・[進路探索](templates/career-exploration.md) |
| 探究をまとめる | 問い・方法・結果・考察を根拠付きでつなぎたい | [探究レポート](templates/inquiry-report.md)・[まとめ方](docs/inquiry-report-guide.md) |
| 記録を探す | 今回使う原記録を選ぶ一覧を作りたい | [索引](templates/record-index.md)・[探し方](docs/record-index.md) |
| 出願に備える | 募集要項を確認して、計画と提出物を整えたい | [準備計画](templates/admissions-plan.md)・[提出条件確認](templates/submission-check.md)・[出願用出力](templates/admissions-output.md) |
| 面接に備える | 書いたことを、記録に戻って話せるようにしたい | [面接準備シート](templates/interview-prep.md) |
| 活用する | 根拠を付けて、発表・就活・AIへの説明の材料を整理したい | [根拠付き要約](templates/evidence-summary.md)・[AI向け自己紹介](templates/ai-context.md)・[自己紹介の現在版](templates/ai-profile.md) |
| 利用範囲を決める | 誰に・どのAIに、どこまで見せるか決めたい | [利用範囲の見直し](templates/record-use-review.md) |

入試対策の主テーマは、[6段階の探究ガイド](docs/inquiry-project-guide.md)に沿って進めます。日々の記録には、その日に必要な用紙を使います。[架空の継続例](examples/inquiry-project/README.md)で、調査から発信・協働への流れを確認できます。

## 記録を置く場所

| 場所 | 内容 |
| --- | --- |
| [profile/](profile/README.md) | 今の興味・希望、AI向け自己紹介の現在版（任意） |
| [experiences/](experiences/README.md) | 年ごとの日々の記録 |
| [projects/](projects/README.md) | テーマごとの探究・作品 |
| [reflections/](reflections/README.md)・[annual-review/](annual-review/README.md) | 元記録をたどれる振り返り |
| [derived/](derived/README.md) | 要約・用途別の材料 |
| [assets/](assets/README.md) | 外部に保存した写真・動画・PDF等の所在 |
| [practice/](practice/README.md) | 接続や保存の確認に使う、本人の練習ファイル（架空） |
| [templates/](templates/README.md) | ChatGPTが記録の作成に使う空欄の用紙 |
| [examples/](examples/README.md) | すべて架空の記入例。本人の実績には含めない |

## 続けるためのガイド

- [最初の10分](docs/first-10-minutes.md)／[ChatGPTの登録からGitHub接続まで](docs/getting-started.md)／[GitHubの登録](docs/github-basics.md)
- [接続・保存の確認と困ったとき](docs/connection-check.md)／[ChatGPTとの架空のやりとり](examples/chatgpt-session.md)
- [総合型選抜・推薦入試の準備と出力](docs/admissions-guide.md)／[自己理解と大学・学部選び](docs/self-understanding.md)／[面接・口頭試問の準備](docs/interview-guide.md)
- [入試対策の中心となる6段階の探究ガイド](docs/inquiry-project-guide.md)
- [大学版への移行準備](docs/migration-to-univ.md)／[共通仕様](docs/portfolio-format.md)／[移行検査](docs/migration-verification.md)
- [探究レポートのまとめ方](docs/inquiry-report-guide.md)／[記録の索引](docs/record-index.md)
- [高校卒業後も続ける（大学・ガクチカ）](docs/after-high-school.md)／[AIへ持ち運ぶ](docs/portability.md)／[発表・進路・面接への活用](docs/future-use.md)
- [日付のルール](docs/file-dates.md)／[保護者などの支援者へ](docs/supporter-guide.md)
- [共有と個人情報](docs/privacy.md)／[利用停止・削除](docs/record-choices.md)
- [小学生版からの引き継ぎ](docs/migration.md)／[バックアップと復元](docs/backup-and-restore.md)／[テンプレートの更新](docs/template-updates.md)
- 補足: [自分で貼り付けて保存する](docs/manual-editing.md)／[ChatGPTデスクトップで端末のフォルダを編集する](docs/chatgpt-desktop.md)／[Claude Code](docs/claude-code.md)

この公開リポジトリは配布用です。**実際の記録を配布元のファイル・Issue・PRへ送らないでください。** ChatGPTを使えない日も手入力で続けられます。教材は無料、AIサービスの費用は別です。

## 著作権とライセンス

Copyright © 2026 adash333

本リポジトリのオリジナルの文章・テンプレート・架空の記入例は、初版の公開時から[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.ja)で提供します。adash333が権利を保有する部分の著作権は保持し、放棄するものではありません。

条件に従い、著作者表示、ライセンスへのリンク、改変した場合の変更表示などを行うことで、商用利用・改変・再配布ができます。[正式本文](LICENSE)／[表示例](docs/license-guide.md)

プログラム部分は[MIT](LICENSES/MIT.txt)です。適用範囲と第三者素材の扱いは[NOTICE.md](NOTICE.md)を参照してください。[小学生版](https://github.com/risan-education/my-portfolio-elementary)由来のMIT部分は、[従来の表示と許諾](LICENSES/MIT-elementary.txt)を保持します。[再利用の記録](docs/sources.md)

利用者が新しく記入・追加した文章・写真・作品の権利はそれぞれの権利者に帰属し、本教材のライセンスを自動適用しません。個人の記録を公開する必要もありません。第三者の著作物には各権利者の表示と利用条件が適用されます。

配布元: risan-education。

管理者向け: [要件定義](docs/requirements.md)／[受入確認](docs/acceptance-review.md)／[変更履歴](CHANGELOG.md)／[記事での紹介](docs/publication-guide.md)
