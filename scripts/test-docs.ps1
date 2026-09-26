#requires -Version 7.0
param([string]$Root = (Split-Path -Parent $PSScriptRoot))

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$rootPath = (Resolve-Path -LiteralPath $Root).Path
$checker = Join-Path $rootPath 'scripts/check-docs.ps1'
$pwsh = (Get-Process -Id $PID).Path
$testBase = Join-Path $rootPath '.scratch'
$testPath = Join-Path $testBase ('docs-test-' + [guid]::NewGuid().ToString('N'))
$fixture = Join-Path $testPath 'repository'
New-Item -ItemType Directory -Path $fixture -Force | Out-Null

function Assert([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Check-Fixture([bool]$ShouldPass, [string]$ExpectedText) {
    $output = (& $pwsh -NoProfile -File $checker -Root $fixture 2>&1 | Out-String)
    $passed = $LASTEXITCODE -eq 0
    Assert ($passed -eq $ShouldPass) "Unexpected checker result: $output"
    Assert ($output.Contains($ExpectedText)) "Expected '$ExpectedText' in checker result: $output"
}

function Check-Migration([bool]$ShouldPass, [string]$ExpectedText) {
    $output = (& $pwsh -NoProfile -File (Join-Path $rootPath 'scripts/check-migration.ps1') -Source $teenSource -Destination $teenDestination -Manifest $teenManifest 2>&1 | Out-String)
    Assert (($LASTEXITCODE -eq 0) -eq $ShouldPass) "Unexpected migration result: $output"
    Assert ($output.Contains($ExpectedText)) "Expected '$ExpectedText' in migration output: $output"
}

try {
    foreach ($item in Get-ChildItem -LiteralPath $rootPath -Force) {
        if ($item.Name -notin @('.git', '.scratch', 'backups', 'node_modules')) {
            Copy-Item -LiteralPath $item.FullName -Destination $fixture -Recurse -Force
        }
    }
    Check-Fixture $true 'PASS:'

    # Corrupt only disposable copies; verify each failure is actually detected.
    $fixtureReadme = Join-Path $fixture 'README.md'
    $readme = Get-Content -LiteralPath $fixtureReadme -Raw -Encoding utf8
    Set-Content -LiteralPath $fixtureReadme -Value ($readme + "`n[broken](missing-document.md)`n") -Encoding utf8
    Check-Fixture $false 'missing link'
    Set-Content -LiteralPath $fixtureReadme -Value ($readme + "`n[bad anchor](README.md#absent-heading)`n") -Encoding utf8
    Check-Fixture $false 'missing anchor'
    Set-Content -LiteralPath $fixtureReadme -Value $readme -Encoding utf8

    $templatePath = Join-Path $fixture 'templates/quick-note.md'
    $template = Get-Content -LiteralPath $templatePath -Raw -Encoding utf8
    Set-Content -LiteralPath $templatePath -Value ($template.Replace('- 作成日:', '- 作成日: 2026-09-26')) -Encoding utf8
    Check-Fixture $false 'must be blank'
    Set-Content -LiteralPath $templatePath -Value $template -Encoding utf8

    $examplePath = Join-Path $fixture 'examples/middle-experience.md'
    $example = Get-Content -LiteralPath $examplePath -Raw -Encoding utf8
    Set-Content -LiteralPath $examplePath -Value ($example.Replace('架空', 'サンプル')) -Encoding utf8
    Check-Fixture $false 'fictional example must be labelled'
    Set-Content -LiteralPath $examplePath -Value $example -Encoding utf8
    Check-Fixture $true 'PASS:'
    Write-Output 'PASS: checker accepts repository and rejects broken links, anchors, filled dates, and unlabelled examples.'

    # A-01/A-03/A-08: only one sentence is needed; all optional fields stay empty.
    $practicePath = Join-Path $fixture 'experiences/practice.md'
    $practice = $template.Replace('- 作成日:', '- 作成日: 2026-09-26').Replace('- 更新日:', '- 更新日: 2026-09-26')
    $practice = $practice.Replace('## 元のメモ', "## 元のメモ`nこれは架空の保存練習です。本の表紙の色が気になった。")
    [System.IO.File]::WriteAllText($practicePath, $practice)
    Assert (([System.IO.File]::ReadAllText($practicePath)) -ceq $practice) 'Practice record did not survive save/reopen.'
    Check-Fixture $true 'PASS:'
    Write-Output 'PASS: one-sentence record saved and reread with optional fields blank.'

    # A-07: git blob ID is content-derived, pinned to the upstream fictional source.
    $original = Join-Path $fixture 'examples/migration/experiences/shadow-note.md'
    $blob = & git hash-object -- $original
    Assert ($LASTEXITCODE -eq 0 -and $blob -eq '272396266f431a70919ccbc33f995179a9d04567') 'Migrated source differs from pinned upstream.'
    Write-Output 'PASS: migrated example matches upstream Git blob 272396266f431a70919ccbc33f995179a9d04567.'

    # A-07: exercise the documented grouped copy, including an occupied destination.
    # This is a disposable fixture, not a migration tool for personal repositories.
    $linkedSource = Join-Path $fixture 'examples/migration/linked-source'
    $occupied = Join-Path $fixture 'legacy/elementary-01'
    New-Item -ItemType Directory -Path $occupied -Force | Out-Null
    $existingRecord = Join-Path $occupied 'questions.md'
    [System.IO.File]::WriteAllText($existingRecord, "# 架空の既存記録`n`n- 作成日: 2026-09-01`n- 更新日: 2026-09-01`n`nこの内容は変えない。`n")
    $existingHash = (Get-FileHash -LiteralPath $existingRecord).Hash
    $sourceHashes = @{}
    foreach ($file in Get-ChildItem -LiteralPath $linkedSource -Recurse -File) {
        $relative = [System.IO.Path]::GetRelativePath($linkedSource, $file.FullName)
        $sourceHashes[$relative] = (Get-FileHash -LiteralPath $file.FullName).Hash
    }
    $copiedGroup = Join-Path $fixture 'legacy/elementary-02'
    Assert (-not (Test-Path -LiteralPath $copiedGroup)) 'Grouped destination must be unused.'
    Copy-Item -LiteralPath $linkedSource -Destination $copiedGroup -Recurse
    foreach ($relative in $sourceHashes.Keys) {
        $sourceFile = Join-Path $linkedSource $relative
        $copiedFile = Join-Path $copiedGroup $relative
        Assert (Test-Path -LiteralPath $copiedFile) "Missing copied record: $relative"
        Assert ((Get-FileHash -LiteralPath $copiedFile).Hash -eq $sourceHashes[$relative]) "Copied record changed: $relative"
        Assert ((Get-FileHash -LiteralPath $sourceFile).Hash -eq $sourceHashes[$relative]) "Source record changed: $relative"
        foreach ($link in [regex]::Matches([System.IO.File]::ReadAllText($copiedFile), '\]\(([^)]+\.md)\)')) {
            $resolvedLink = [System.IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $copiedFile) $link.Groups[1].Value))
            $groupBoundary = $copiedGroup + [System.IO.Path]::DirectorySeparatorChar
            Assert ($resolvedLink.StartsWith($groupBoundary, [System.StringComparison]::OrdinalIgnoreCase)) 'Copied link escaped its group.'
            Assert (Test-Path -LiteralPath $resolvedLink -PathType Leaf) "Copied link is broken: $resolvedLink"
        }
    }
    Assert ((Get-FileHash -LiteralPath $existingRecord).Hash -eq $existingHash) 'Existing destination record was overwritten.'
    Check-Fixture $true 'PASS:'
    Write-Output 'PASS: grouped migration preserves source, destination content, dates and local links without overwriting an occupied group.'

    # University handover: absent date fields, old blank templates, nested legacy,
    # links to omitted records, and a source allowlist that never copies the omitted file.
    $teenSource = Join-Path $testPath 'teen-source'
    $teenDestination = Join-Path $fixture 'legacy/teens-02'
    $teenManifest = Join-Path $testPath 'permitted.json'
    $teenOccupied = Join-Path $fixture 'legacy/teens-01'
    New-Item -ItemType Directory -Path $teenOccupied -Force | Out-Null
    $teenExisting = Join-Path $teenOccupied 'questions.md'
    [IO.File]::WriteAllText($teenExisting, '# 架空の既存台帳。日付欄を足さず保持する。')
    $teenExistingHash = (Get-FileHash -LiteralPath $teenExisting).Hash
    $records = [ordered]@{
        'experiences/old-note.md' = "# 架空の旧記録`n紙の案内を作った。`n[対象外](stopped.md)`n[旧ルート](/old.md)`n"
        'projects/library/README.md' = "# 架空の記入済み入口`n[原記録](../../experiences/old-note.md)`n"
        'legacy/elementary-01/questions.md' = "# 架空の旧台帳`n状態: 未着手`n"
        'templates/old.md' = "# 架空の参照用紙`n- 作成日:`n- 更新日:`n"
    }
    $entries = @()
    Assert (-not (Test-Path -LiteralPath $teenDestination)) 'University destination must be unused.'
    foreach ($relative in $records.Keys) {
        $sourceFile = Join-Path $teenSource $relative
        $destinationFile = Join-Path $teenDestination $relative
        New-Item -ItemType Directory -Path (Split-Path $sourceFile -Parent), (Split-Path $destinationFile -Parent) -Force | Out-Null
        [IO.File]::WriteAllText($sourceFile, $records[$relative])
        Copy-Item -LiteralPath $sourceFile -Destination $destinationFile
        $kind = if ($relative.StartsWith('templates/')) { 'reference' } else { 'record' }
        $entries += @{ path = $relative; kind = $kind }
    }
    $omittedSource = Join-Path $teenSource 'experiences/stopped.md'
    [IO.File]::WriteAllText($omittedSource, '# 架空の対象外記録。移行しない。')
    $manifestData = @{ version = 1; source_repository = 'fictional-teen-repository'; source_revision = 'fictional-snapshot'; files = $entries }
    $manifestData | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $teenManifest -Encoding utf8
    $originalManifest = Get-Content -LiteralPath $teenManifest -Raw -Encoding utf8
    Check-Migration $true 'permitted files match'
    Check-Fixture $true 'REVIEW legacy/teens-02/experiences/old-note.md: missing link'
    Assert (-not (Test-Path -LiteralPath (Join-Path $teenDestination 'experiences/stopped.md'))) 'Omitted record was copied.'

    $changedFile = Join-Path $teenDestination 'experiences/old-note.md'
    [IO.File]::AppendAllText($changedFile, "`n- 作成日: 2026-09-27")
    Check-Migration $false 'Content mismatch'
    Copy-Item -LiteralPath (Join-Path $teenSource 'experiences/old-note.md') -Destination $changedFile -Force
    $extraFile = Join-Path $teenDestination 'extra.txt'
    [IO.File]::WriteAllText($extraFile, 'fictional extra copy')
    Check-Migration $false 'Unexpected destination file'
    Remove-Item -LiteralPath $extraFile

    foreach ($badEntry in @(
        @{ path = '../outside.md'; kind = 'record' },
        @{ path = '/absolute.md'; kind = 'record' },
        @{ path = 'AGENTS.md'; kind = 'reference' },
        @{ path = '.claude/skills/test.md'; kind = 'reference' },
        @{ path = 'experiences/old-note.md'; kind = 'record' }
    )) {
        $manifestData.files = $entries + @($badEntry)
        $manifestData | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $teenManifest -Encoding utf8
        $expected = if ($badEntry.path -in @('AGENTS.md', '.claude/skills/test.md')) { 'Old instruction' }
            elseif ($badEntry.path -eq 'experiences/old-note.md') { 'Duplicate path' } else { 'Unsafe relative path' }
        Check-Migration $false $expected
    }
    [IO.File]::WriteAllText($teenManifest, $originalManifest)
    Check-Migration $true 'permitted files match'
    Assert ((Get-FileHash -LiteralPath $teenExisting).Hash -eq $teenExistingHash) 'Existing teens-01 was changed.'
    foreach ($relative in $records.Keys) {
        Assert (([IO.File]::ReadAllText((Join-Path $teenSource $relative))) -ceq $records[$relative]) 'Source text was changed.'
    }
    Write-Output 'PASS: university handover preserves undated records, nested legacy and old templates; reports omitted links; rejects changed bytes, extra files, unsafe paths, old instructions and duplicates.'

    # A-09: restore body and links; external storage is deliberately a separate fixture.
    $payload = Join-Path $testPath 'backup-source'
    New-Item -ItemType Directory -Path $payload | Out-Null
    Copy-Item -LiteralPath (Join-Path $fixture 'examples') -Destination $payload -Recurse
    $mockExternal = Join-Path $testPath 'mock-external'
    $externalBackup = Join-Path $testPath 'external-backup'
    New-Item -ItemType Directory -Path $mockExternal, $externalBackup | Out-Null
    $externalName = 'observation.txt'
    Set-Content -LiteralPath (Join-Path $mockExternal $externalName) -Value '架空の原本。人数観察のテスト。' -Encoding utf8
    Copy-Item -LiteralPath (Join-Path $mockExternal $externalName) -Destination $externalBackup
    $manifest = @{ original = (Join-Path $mockExternal $externalName); backup = (Join-Path $externalBackup $externalName) }
    $manifest | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $payload 'external-location.json') -Encoding utf8
    $archive = Join-Path $testPath 'records.zip'
    Compress-Archive -Path (Join-Path $payload '*') -DestinationPath $archive
    $restored = Join-Path $testPath 'restored'
    Expand-Archive -LiteralPath $archive -DestinationPath $restored
    foreach ($file in Get-ChildItem -LiteralPath $payload -Recurse -File) {
        $relative = [System.IO.Path]::GetRelativePath($payload, $file.FullName)
        $restoredFile = Join-Path $restored $relative
        Assert (Test-Path -LiteralPath $restoredFile) "Missing restored file: $relative"
        Assert ((Get-FileHash -LiteralPath $file.FullName).Hash -eq (Get-FileHash -LiteralPath $restoredFile).Hash) "Restored content mismatch: $relative"
    }
    $restoredManifest = Get-Content -LiteralPath (Join-Path $restored 'external-location.json') -Raw -Encoding utf8 | ConvertFrom-Json
    Assert ((Get-FileHash -LiteralPath $restoredManifest.original).Hash -eq (Get-FileHash -LiteralPath $restoredManifest.backup).Hash) 'Mock external original and backup differ.'
    $restoredText = Get-Content -LiteralPath $restoredManifest.backup -Raw -Encoding utf8
    Assert ($restoredText.Contains('架空の原本')) 'Mock external backup could not be read.'
    Write-Output 'PASS: ZIP restoration preserves all example files; separate mock external original and backup can be located and opened.'
} finally {
    # Only delete the unique test directory after checking the resolved boundary.
    $resolvedBase = [System.IO.Path]::GetFullPath($testBase) + [System.IO.Path]::DirectorySeparatorChar
    $resolvedTest = (Resolve-Path -LiteralPath $testPath).Path
    if (-not $resolvedTest.StartsWith($resolvedBase, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw 'Refusing cleanup outside the test workspace.'
    }
    Remove-Item -LiteralPath $resolvedTest -Recurse -Force
}
