# 記録の保存先・呼び出し方・一覧の場所

- 作成日: 2026-10-01
- 更新日: 2026-10-01

ChatGPTに話しかけて作った記録が、自分用Privateのどこに保存され、あとでどう呼び出し、どこに一覧があるかをまとめます。保存先とファイル名はChatGPTが提案するので、覚えておく必要はありません。探すときは、このページの言い方で頼めます。

## 記録の種類ごとの保存先と一覧

| 記録の種類 | 用紙 | 保存先とファイル名の例 | 一覧（リスト）の場所 |
| --- | --- | --- | --- |
| 一言メモ | [一言メモ](../templates/quick-note.md) | [`experiences/`](../experiences/)`260511-deep-sea-book.md`（年ごとに分けるなら [`experiences/`](../experiences/)`2026/`） | [`experiences/`](../experiences/) フォルダ自体。GitHubで開くと日付順に並ぶ |
| 活動記録 | [活動記録](../templates/experience.md) | [`experiences/`](../experiences/)`260919-school-festival.md` | 同上 |
| 探究ノート | [探究ノート](../templates/inquiry.md) | [`projects/`](../projects/)`bicycle-crossing/270602-inquiry-start.md` | [`projects/`](../projects/)`<テーマ>/README.md`（テーマの入口。状態と各記録へのリンク） |
| 作品カード | [作品カード](../templates/work.md) | [`projects/`](../projects/)`timetable-app/280520-work-card.md` | 同上 |
| 主テーマの6段階 | [探究プロジェクト](../templates/inquiry-project.md) | [`projects/`](../projects/)`<テーマ>/README.md` | このファイル自体が入口・一覧 |
| 振り返り | [振り返り](../templates/reflection.md) | [`reflections/`](../reflections/)`271220-term-end.md` | [`reflections/`](../reflections/) フォルダ |
| 年間振り返り | [年間振り返り](../templates/annual-review.md) | [`annual-review/`](../annual-review/)`270331-annual-review.md` | [`annual-review/`](../annual-review/) フォルダ |
| 問い | （1行ずつ追記） | [`questions.md`](../questions.md) | このファイル自体が一覧。日付・問い・状態・元記録へのリンク |
| 今の自分・AI向け自己紹介 | [AI向け自己紹介](../templates/ai-profile.md)ほか | [`profile/`](../profile/) | [`profile/`](../profile/) フォルダ |
| 要約・提出用材料・面接準備 | [根拠付き要約](../templates/evidence-summary.md)ほか | [`derived/`](../derived/)`271101-summary.md` | [`derived/`](../derived/) フォルダ。各項目に元記録へのリンク |
| 写真・資料の所在メモ | （所在メモ） | [`assets/`](../assets/) | [`assets/`](../assets/) フォルダ |
| 練習（架空） | 任意 | [`practice/`](../practice/) | [`practice/`](../practice/) フォルダ。実績に含めない |
| 記録の索引 | [索引](../templates/record-index.md) | [`profile/`](../profile/)`271220-record-index.md` | 記録が増えたときの手作りの一覧 |

ファイル名は `YYMMDD-theme.md`（活動日の下2桁年・月・日と短い英語）です。活動日不明なら [`experiences/`](../experiences/)`unknown/date-unknown-theme.md`、同名があれば `-02` を付けます。[日付のルール](file-dates.md)

## 一覧の見方

- **フォルダがそのまま一覧です。** 上の表のフォルダ名を押すと、GitHubのフォルダ画面（ファイルの一覧）が開きます。配布元ではまだ README.md しかありませんが、自分用Privateに記録を保存すると、ここに日付順で並びます。フォルダの README.md は一覧の下に説明として表示されます。 目次ファイルを別に作る必要はありません。
- **問いの一覧は [questions.md](../questions.md)。** 記録から生まれた問いを1行ずつためます。状態（これから・途中・ひと区切り・保留・お休み）と元記録へのリンクが付きます。
- **探究はテーマの入口から。** [`projects/`](../projects/)`<テーマ>/README.md` に、その探究の状態・更新日・各記録へのリンクを置きます。
- **記録が増えたら索引。** フォルダと [questions.md](../questions.md) で探しにくくなったら、[索引用紙](../templates/record-index.md)で [`profile/`](../profile/) に入口を作ります。作り方は[記録の索引](record-index.md)にあります。

## 呼び出し方（ChatGPTへの言い方）

ファイル名が分かるとき:

> experiences/260511-deep-sea-book.md を読み直して、「次にしたいこと」を追記する案を見せてください。

ファイル名が分からないとき（フォルダ・期間・テーマで探す）:

> experiences/ の2026年5月の記録を、日付と題名の一覧にしてください。

> projects/ の中で、状態が「途中」の探究ノートを一覧にしてください。

> 自分の実記録から、深海に関係するものを探してください。examples/、templates/、practice/、案内文と利用停止中の記録は除外してください。

問いから探す:

> questions.md で状態が「これから」の問いと、その元記録へのリンクを一覧にしてください。

振り返りや要約に使う記録を指定する:

> 読む記録は experiences/260919-school-festival.md と projects/bicycle-crossing/270602-inquiry-start.md の2件だけにしてください。

ChatGPTは読んだ範囲と読めなかった範囲を伝えます。読めなかったファイルを「記録なし」とは扱いません。架空例（examples/）・用紙（templates/）・練習（practice/）・案内文は、実記録の一覧や集計に含めません。

## 自分で開くとき

GitHubで自分用Privateを開き、フォルダをたどればChatGPTなしでも読めます。ChatGPTが保存を報告したら、そのファイルのURLを開いて本文と日付を自分の目で確かめます。[日常の記録](recording-guide.md)／[プロンプト例](../examples/prompts/README.md)
