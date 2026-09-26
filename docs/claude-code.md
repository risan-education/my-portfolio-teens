# 補足 — Claude Codeでも使う場合

- 作成日: 2026-09-26
- 更新日: 2026-09-27

標準の案内は[ChatGPTでのはじめ方](getting-started.md)です。Claude Codeをすでに使える保護者や18歳以上の本人向けに、同じ用紙・記録ルールを使う入口を用意しています。追加契約はChatGPTでの利用に不要です。

Claudeの個人アカウントは18歳以上が条件です。18歳未満の本人の利用先にはしません。[公式の年齢条件](https://support.claude.com/en/articles/13117299-minimum-age-requirement-access-restriction)（確認日: 2026-09-26）

## 利用する場合

1. 導入と契約は[Claude Code公式の開始手順](https://code.claude.com/docs/en/quickstart)で確認する。
2. 自分用Privateのリポジトリを端末へcloneし、そのフォルダを開く。配布元で実記録を作らない。
3. [CLAUDE.md](../CLAUDE.md)の @AGENTS.md から共通指示を読み込み、「AGENTS.mdを読んで、記録を始める準備をしてください」と頼む。
4. [架空の接続練習](connection-check.md)と同様に、案・保存・追記・mainの再確認を行う。

指示書の参照構文は[公式のメモリー説明](https://code.claude.com/docs/en/memory)を参照（確認日: 2026-09-26）。指示の読み込みはアクセス権や動作を保証するものではありません。

ローカル実行では、保存を依頼した範囲だけをコミット・pushし、GitHubのmainで確認します。クラウド等で別ブランチやPRが必要な場合は、作業前に制約と反映方法を確認し、main反映と区別します。

ChatGPTと併用する際は同じ記録を同時に編集せず、最新内容を読み直してから作業します。記録を他のAIへ渡す方法は[AIへ持ち運ぶ](portability.md)を参照してください。利用範囲は[共有のガイド](privacy.md)に従います。実アカウントでのClaude Code保存操作は未検証です。
