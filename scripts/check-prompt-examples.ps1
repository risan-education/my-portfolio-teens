#requires -Version 7.0
# SPDX-License-Identifier: MIT
# See ../LICENSES/MIT.txt for copyright and permission notices.
param([string]$Root = (Split-Path -Parent $PSScriptRoot))

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$rootPath = (Resolve-Path -LiteralPath $Root).Path
$examplePath = Join-Path $rootPath 'examples/prompts'
$checked = 0

# These checks apply only to the numbered fictional teaching conversations.
# They do not read or classify personal records elsewhere in a copied repository.
foreach ($file in Get-ChildItem -LiteralPath $examplePath -Filter '*.md' | Where-Object Name -Match '^\d{2}-') {
    $body = Get-Content -LiteralPath $file.FullName -Raw -Encoding utf8
    $target = [regex]::Match($body, '\[見出し・表・原文を含む完成記録を読む\]\((records/[^)]+)\)')
    if (-not $target.Success) { throw "Missing readable record link: $($file.Name)" }
    $recordPath = [IO.Path]::GetFullPath((Join-Path $examplePath $target.Groups[1].Value))
    $recordsBoundary = [IO.Path]::GetFullPath((Join-Path $examplePath 'records')) + [IO.Path]::DirectorySeparatorChar
    if (-not $recordPath.StartsWith($recordsBoundary, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Record link leaves fictional records: $($file.Name)"
    }
    $record = Get-Content -LiteralPath $recordPath -Raw -Encoding utf8
    $raw = [regex]::Match($record, '(?s)## 元のメモ\r?\n(.*?)</details>')
    if (-not $raw.Success) { throw "Missing original-input section: $($file.Name)" }
    $dialogue = [regex]::Match($body, '(?s)<details>.*?</details>').Value
    $messages = [regex]::Matches($dialogue, '(?m)^本人:\r?\n\r?\n((?:>[^\r\n]*(?:\r?\n|$))+)')
    if ($messages.Count -lt 2) { throw "Missing learner conversation: $($file.Name)" }
    foreach ($message in $messages) {
        $quote = ([regex]::Replace($message.Groups[1].Value, '(?m)^> ?', '')).Trim()
        if ($quote.StartsWith('この内容で保存してください。')) { continue }
        if (-not $raw.Groups[1].Value.Contains($quote)) {
            throw "Learner original missing from record: $($file.Name)"
        }
    }
    $checked++
}
if ($checked -eq 0) { throw 'No numbered fictional conversations checked.' }

$questionRows = Get-Content -LiteralPath (Join-Path $examplePath 'records/questions.md') -Encoding utf8 |
    Where-Object { $_.StartsWith('|') }
if (@($questionRows).Count -lt 3) { throw 'Missing fictional questions table.' }
foreach ($row in $questionRows) {
    if (($row.Trim().Trim('|') -split '\|').Count -ne 5) { throw 'Fictional questions table must have five columns.' }
}
Write-Output "PASS: $checked fictional conversations retain learner originals; questions table has five columns."
Write-Output 'Paraphrase accuracy, unsupported facts, consent and usability still require editorial review.'
