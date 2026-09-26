#requires -Version 7.0
param([string]$Root = (Split-Path -Parent $PSScriptRoot))

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$rootPath = (Resolve-Path -LiteralPath $Root).Path
$issues = [System.Collections.Generic.List[string]]::new()
$reviews = [System.Collections.Generic.List[string]]::new()
$files = [System.Collections.Generic.List[System.IO.FileInfo]]::new()

function Add-LinkIssue([string]$Relative, [string]$Message) {
    if ($Relative.StartsWith('legacy/')) {
        $reviews.Add("${Relative}: $Message (preserve source; record in migration checklist)")
    } else {
        $issues.Add("${Relative}: $Message")
    }
}

function Find-Markdown([string]$Directory) {
    foreach ($item in Get-ChildItem -LiteralPath $Directory -Force) {
        if ($item.PSIsContainer) {
            if ($item.Name -notin @('.git', '.scratch', 'backups', 'node_modules')) {
                Find-Markdown $item.FullName
            }
        } elseif ($item.Extension -eq '.md') {
            $files.Add($item)
        }
    }
}

function Remove-Code([string]$Text) {
    $withoutFences = [regex]::Replace($Text, '(?ms)^\s*(`{3,}|~{3,})[^\r\n]*\r?\n.*?^\s*\1\s*$', '')
    return [regex]::Replace($withoutFences, '`+[^`\r\n]*`+', '')
}

function Test-Link([string]$Target, [System.IO.FileInfo]$File, [string]$Relative) {
    $targetText = $Target.Trim()
    if ($targetText -match '^(https?://|mailto:)') { return }
    if ($targetText -match '^[a-zA-Z][a-zA-Z0-9+.-]*:' -or $targetText.StartsWith('/')) {
        Add-LinkIssue $Relative "unsupported or absolute link: $targetText"
        return
    }
    $parts = $targetText -split '#', 2
    $pathPart = [Uri]::UnescapeDataString(($parts[0] -split '\?', 2)[0])
    $resolved = if ($pathPart) {
        [System.IO.Path]::GetFullPath((Join-Path $File.DirectoryName $pathPart))
    } else { $File.FullName }
    $relativeTarget = [System.IO.Path]::GetRelativePath($rootPath, $resolved)
    if ($relativeTarget -eq '..' -or $relativeTarget.StartsWith('../') -or $relativeTarget.StartsWith('..\')) {
        Add-LinkIssue $Relative "link leaves repository: $targetText"
        return
    }
    if (-not (Test-Path -LiteralPath $resolved)) {
        Add-LinkIssue $Relative "missing link: $targetText"
        return
    }
    # Validate Markdown heading anchors. Other file formats are existence-only.
    if ($parts.Count -gt 1 -and $parts[1] -and [System.IO.Path]::GetExtension($resolved) -eq '.md') {
        $anchors = [System.Collections.Generic.List[string]]::new()
        $counts = @{}
        $targetBody = Remove-Code (Get-Content -LiteralPath $resolved -Raw -Encoding utf8)
        foreach ($heading in [regex]::Matches($targetBody, '(?m)^#{1,6}\s+(.+?)\s*#*\s*$')) {
            $slug = $heading.Groups[1].Value.ToLowerInvariant()
            $slug = [regex]::Replace($slug, '[^\p{L}\p{M}\p{N}_\-\s]', '') -replace '\s', '-'
            if ($counts.ContainsKey($slug)) {
                $counts[$slug]++
                $anchors.Add("$slug-$($counts[$slug])")
            } else {
                $counts[$slug] = 0
                $anchors.Add($slug)
            }
        }
        foreach ($anchor in [regex]::Matches($targetBody, '<a\s+(?:id|name)="([^"]+)"')) {
            $anchors.Add($anchor.Groups[1].Value)
        }
        if (-not $anchors.Contains([Uri]::UnescapeDataString($parts[1]))) {
            Add-LinkIssue $Relative "missing anchor: $targetText"
        }
    }
}

Find-Markdown $rootPath
foreach ($file in $files) {
    $relative = [System.IO.Path]::GetRelativePath($rootPath, $file.FullName).Replace('\', '/')
    $body = Get-Content -LiteralPath $file.FullName -Raw -Encoding utf8
    if ($body -match '\uFFFD') { $issues.Add("${relative}: invalid UTF-8 replacement character") }
    if ($relative.StartsWith('legacy/')) {
        # Archives retain source dates (including absent fields and blank old templates).
        # This is not a content-equivalence check; run check-migration.ps1 separately.
    } elseif ($relative.StartsWith('templates/') -and $file.Name -ne 'README.md') {
        foreach ($label in @('作成日', '更新日')) {
            if ($body -notmatch "(?m)^- ${label}:[ \t]*`r?$" -or $body -match "(?m)^- ${label}:[ \t]*\S") {
                $issues.Add("${relative}: template $label must be blank")
            }
        }
        if ($body -match '\b20\d{2}-\d{2}-\d{2}\b') {
            $issues.Add("${relative}: template contains a fixed date")
        }
    } else {
        foreach ($label in @('作成日', '更新日')) {
            if ($body -notmatch "(?m)^- ${label}: (\d{4}-\d{2}-\d{2}|未確認)[ \t]*`r?$" ) {
                $issues.Add("${relative}: missing document $label")
            }
        }
    }
    if (($relative.StartsWith('examples/') -or $relative.StartsWith('practice/')) -and $body -notmatch '架空') {
        $issues.Add("${relative}: fictional example must be labelled")
    }
    $prose = Remove-Code $body
    # Inline links/images; angle-bracket targets and optional titles are supported.
    $linkPattern = '\]\(\s*(?:<([^>]+)>|([^\s)]+))(?:\s+"[^"]*")?\s*\)'
    foreach ($match in [regex]::Matches($prose, $linkPattern)) {
        $target = if ($match.Groups[1].Success) { $match.Groups[1].Value } else { $match.Groups[2].Value }
        Test-Link $target $file $relative
    }
    foreach ($match in [regex]::Matches($prose, '(?m)^\s*\[[^\]]+\]:\s*<?([^\s>]+)>?')) {
        Test-Link $match.Groups[1].Value $file $relative
    }
}

$required = @(
    'README.md', 'AGENTS.md', 'CLAUDE.md', 'LICENSE', 'VERSION', 'CHANGELOG.md', '.github/copilot-instructions.md',
    'profile/README.md', 'experiences/README.md', 'projects/README.md', 'reflections/README.md',
    'annual-review/README.md', 'derived/README.md', 'assets/README.md', 'practice/README.md', 'questions.md',
    'templates/quick-note.md', 'templates/experience.md', 'templates/inquiry.md', 'templates/inquiry-project.md',
    'templates/work.md', 'templates/reflection.md', 'templates/annual-review.md', 'templates/evidence-summary.md',
    'templates/ai-context.md', 'templates/career-exploration.md', 'templates/submission-check.md', 'templates/record-use-review.md',
    'templates/admissions-plan.md', 'templates/admissions-output.md', 'templates/self-understanding.md',
    'templates/interview-prep.md', 'templates/ai-profile.md',
    'templates/inquiry-report.md', 'templates/record-index.md',
    'docs/migration-to-univ.md', 'docs/portfolio-format.md', 'docs/migration-verification.md',
    'docs/record-index.md', 'docs/inquiry-report-guide.md', 'docs/connection-environments.md', 'docs/publication-guide.md',
    'examples/inquiry-report.md', 'examples/interview-session.md', 'examples/migration-to-univ/README.md',
    'scripts/check-migration.ps1',
    'docs/first-10-minutes.md', 'docs/interview-guide.md', 'docs/after-high-school.md', 'docs/portability.md',
    '.claude/skills/save-prompt/SKILL.md',
    'docs/admissions-guide.md', 'docs/self-understanding.md', 'examples/admissions-output.md', 'examples/self-understanding.md',
    'docs/inquiry-theme-sources.md', 'examples/inquiry-themes/README.md',
    'docs/extended-essay-guide.md', 'docs/choosing-inquiry-theme.md', 'examples/extended-essay/README.md', 'examples/theme-selection.md',
    'docs/requirements.md', 'docs/getting-started.md', 'docs/recording-guide.md', 'docs/inquiry-project-guide.md',
    'docs/ai-guide.md', 'docs/github-basics.md', 'docs/connection-check.md', 'docs/manual-editing.md',
    'docs/chatgpt-desktop.md', 'docs/claude-code.md', 'examples/chatgpt-session.md',
    'docs/supporter-guide.md', 'docs/privacy.md', 'docs/migration.md', 'docs/migration-checklist.md', 'docs/backup-and-restore.md',
    'docs/record-choices.md', 'docs/template-updates.md', 'docs/file-dates.md', 'docs/future-use.md',
    'docs/sources.md', 'docs/acceptance-review.md', 'examples/README.md', 'examples/inquiry-project/README.md',
    'examples/entry-from-stage4.md', 'examples/migration/README.md',
    'examples/migration/linked-source/questions.md', 'examples/migration/linked-source/experiences/260901-shadow.md',
    'examples/migration/linked-source/projects/shadow/README.md', 'examples/migration/linked-source/assets/shadow.md'
)
foreach ($path in $required) {
    if (-not (Test-Path -LiteralPath (Join-Path $rootPath $path) -PathType Leaf)) {
        $issues.Add("missing required file: $path")
    }
}
foreach ($review in $reviews) { Write-Output "REVIEW $review" }
if ($issues.Count) {
    foreach ($issue in $issues) { Write-Output "ERROR $issue" }
    throw "Documentation check failed: $($issues.Count) issue(s)."
}
Write-Output "PASS: $($files.Count) Markdown files; relative links, date fields, fictional labels, and required files."
Write-Output 'External URLs, access permissions, privacy, and factual accuracy require separate review.'
if (@($files | Where-Object { [IO.Path]::GetRelativePath($rootPath, $_.FullName).Replace('\', '/').StartsWith('legacy/') }).Count) {
    Write-Output 'Legacy dates are preserved, not normalized. Run check-migration.ps1 for permitted source/destination content comparison.'
}
