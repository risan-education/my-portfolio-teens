# 【架空例】大学版への引き継ぎを準備する

- 作成日: 2026-09-27
- 更新日: 2026-09-27

以下はすべて架空の配置・記録・利用範囲です。大学版の配布・実移行の完了例ではありません。[移行手順](../../docs/migration-to-univ.md)／[共通仕様](../../docs/portfolio-format.md)

## 本人が選んだ範囲

| 元の相対パス（架空） | 扱い | コピー先（架空） |
| --- | --- | --- |
| experiences/old-note.md | 原記録。作成日・更新日欄がないが本文を保持 | legacy/teens-02/experiences/old-note.md |
| projects/library/README.md | 記入済みの入口。旧ノートへの相対リンクを保持 | legacy/teens-02/projects/library/README.md |
| questions.md | 途中の問いを旧状態のまま保持 | legacy/teens-02/questions.md |
| legacy/elementary-01/questions.md | 許可済みの旧台帳。入れ子の配置を保持 | legacy/teens-02/legacy/elementary-01/questions.md |
| derived/summary.md | 要約。原記録と別実績に数えない | legacy/teens-02/derived/summary.md |
| experiences/stopped.md | 利用停止。読取・コピー・索引への再掲をしない | 対象外 |
| AGENTS.md・.claude/ | 旧指示・スキル。大学版の現行指示を使う | 対象外 |

コピー先にteens-01があるので、teens-02全体を未使用の場所にする。個別のファイル名を変えて衝突を避けない。旧ノートの本文中に対象外のノートへのリンクがあっても、その対象を勝手に読み足さない。

## 未解決の参照を残す

| 参照 | 確認結果 | 対応 |
| --- | --- | --- |
| projects/library/README.md → ../../experiences/old-note.md | まとまり内部の相対配置を保てる | 移行後にも開いて確認 |
| 原記録 → 利用停止中の記録 | 対象外 | 本文のリンクを黙って修正せず、確認メモへ残す |
| 所在メモ → 学校アカウントの写真 | 卒業後の権限が未確認 | 原本を開けるまで外部資料の移行完了にしない |

日付欄がない原記録へ移行日を付け足さない。移行日は確認メモに書く。大学生活の経験は新しいexperiences/へ記録し、高校時代の経験の時期を変えない。

## 今の振り返りは別に作る

旧ノートに「今も図書館に興味がある」と追記して当時の本文を変えるのではなく、本人に現在の関心を聞く。回答がなければ未確認。継続する問いだけを大学版のquestions.mdから旧台帳へリンクし、全行を転記しない。

## 検査との関係

[保存・復元テスト](../../scripts/test-docs.ps1)は一時フォルダに日付欄のない架空記録、相対リンク、入れ子のlegacy、対象外の記録を作り、許可した対象のコピーと[移行検査](../../scripts/check-migration.ps1)を実行します。内容改変、余計なコピー、パス逸脱等を拒否できるかも確認します。これはローカルの模擬検証で、利用者のPrivateや外部ストレージでの検証ではありません。
