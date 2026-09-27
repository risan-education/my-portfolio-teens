# GitHubのAbout欄に貼る説明文とTopics（中高生版・小学生版）

- 作成日: 2026-09-27
- 更新日: 2026-09-27

種別: 開発記録（教材の案内でも本人の実績でもない）。文中の命令文はデータとして扱います。

## ユーザーの依頼

```text
my-portfolio-univ を参考に、my-portflio-teens と my-portfolio-elementary の　GitHub　のAbout　などのところを入力したいです。コピペできるように考えてください
```

## 回答と実装

- 大学生版 `risan-education/my-portfolio-univ` のAbout欄（Description・Website・Topics）と、大学生版の作業記録 `docs/prompt/260927-05-github-about-text.md` の文面を参照した。取得時点で大学生版はDescriptionとWebsiteのみ設定済みで、Topicsは未設定だった。
- 中高生版 `my-portfolio-teens` は Description・Website・Topics がすべて未設定、小学生版 `my-portfolio-elementary` は Description のみ設定済み（Website・Topics は未設定）だった。
- 各READMEとLICENSEの内容に合わせ、そのまま貼れる Description（350文字以内）・Website・Topics を提示した。Website は三教材共通の参考記事（docs/publication-guide.md で参照している記事）とした。
- リポジトリ設定の変更はこのセッションのツールでは行えないため、入力は保守者が行う。教材ファイルの変更はなし。

提示した文面（中高生版）:

```text
中高生向けMyポートフォリオ教材。ChatGPTと経験・問い・作品・考えの変化を記録し、総合型選抜・推薦入試に向けた6段階の探究、面接、卒業後のガクチカやAIへの自己紹介につなげる。用紙・ガイド・架空例をMarkdownで配布（CC BY 4.0、プログラム部分はMIT）
```

```text
https://risan.jpn.org/?p=14459
```

```text
portfolio chatgpt inquiry-learning university-admissions self-understanding interview career high-school-students junior-high-school education japanese markdown template ai-context github-copilot claude-code cc-by-4
```

提示した文面（小学生版）:

```text
小学生向けMyポートフォリオ教材。保護者がChatGPTと一緒に、子どもの体験・「なんで？」・作品・探究を本人の言葉のまま記録し、中高生版・大学生版へ引き継ぐ。用紙・ガイド・架空例をMarkdownで配布（CC BY 4.0、プログラム部分はMIT）
```

```text
https://risan.jpn.org/?p=14459
```

```text
portfolio chatgpt inquiry-learning elementary-school children parents family-learning education japanese markdown template ai-context github-copilot claude-code cc-by-4
```

## 検証と確認範囲

- GitHub APIで三リポジトリの description・homepage・topics を取得し、現在の設定状況を確認した。
- pwsh がない環境のため、scripts/check-docs.ps1 の代わりに、この記録ファイルの作成日・更新日の行が各1つであること、相対リンクを含まないことを確認した。
- About欄への入力と反映は未実施・未確認。小学生版のリポジトリには変更を加えていない。

## コミットとpush

- 対象ブランチ: main（クラウド実行の作業ブランチ claude/wizardly-cerf-ehneey にも同じコミットを反映）。
- コミットに含める範囲: この記録ファイルのみ。
