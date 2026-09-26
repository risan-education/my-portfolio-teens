#requires -Version 7.0
param(
    [Parameter(Mandatory)][string]$Source,
    [Parameter(Mandatory)][string]$Destination,
    [Parameter(Mandatory)][string]$Manifest
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Read-only verifier. Read source contents only for the explicitly listed files.
function Resolve-Directory([string]$Path) {
    $item = Get-Item -LiteralPath $Path -Force
    if (-not $item.PSIsContainer -or ($item.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
        throw "Expected a real directory: $Path"
    }
    return $item.FullName.TrimEnd([IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar)
}

function Resolve-ListedFile([string]$Base, [string]$Relative) {
    $current = $Base
    foreach ($part in ($Relative -split '/')) {
        $current = Join-Path $current $part
        $item = Get-Item -LiteralPath $current -Force
        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            throw "Reparse point is not allowed: $Relative"
        }
    }
    if ($item.PSIsContainer) { throw "Expected a file: $Relative" }
    return $item.FullName
}

$sourceRoot = Resolve-Directory $Source
$destinationRoot = Resolve-Directory $Destination
$separator = [IO.Path]::DirectorySeparatorChar
$comparison = [StringComparison]::OrdinalIgnoreCase
if ($sourceRoot.Equals($destinationRoot, $comparison) -or
    $sourceRoot.StartsWith($destinationRoot + $separator, $comparison) -or
    $destinationRoot.StartsWith($sourceRoot + $separator, $comparison)) {
    throw 'Source and destination must be separate, non-overlapping directories.'
}
$manifestItem = Get-Item -LiteralPath $Manifest -Force
if ($manifestItem.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw 'Manifest cannot be a reparse point.' }
$data = Get-Content -LiteralPath $Manifest -Raw -Encoding utf8 | ConvertFrom-Json
if ($data.version -ne 1 -or [string]::IsNullOrWhiteSpace($data.source_repository) -or
    [string]::IsNullOrWhiteSpace($data.source_revision) -or $data.files -isnot [array] -or $data.files.Count -eq 0) {
    throw 'Invalid manifest: version, source_repository, source_revision and nonempty files are required.'
}

$allowed = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$listed = [Collections.Generic.List[string]]::new()
# Validate the entire list before reading any source file contents.
foreach ($entry in $data.files) {
    $relative = [string]$entry.path
    if ([string]::IsNullOrWhiteSpace($relative) -or $relative -ne $relative.Trim() -or
        $relative -match '[:\\]' -or $relative.StartsWith('/') -or
        ($relative -split '/') -contains '..' -or ($relative -split '/') -contains '.' -or
        ($relative -split '/') -contains '') {
        throw "Unsafe relative path: $relative"
    }
    foreach ($part in ($relative -split '/')) {
        if ($part -in @('AGENTS.md', 'CLAUDE.md', '.git', '.github', '.claude', '.agents', '.codex')) {
            throw "Old instruction or configuration is not allowed: $relative"
        }
    }
    if ($entry.kind -notin @('record', 'derived', 'reference')) { throw "Invalid kind: $relative" }
    if (-not $allowed.Add($relative)) { throw "Duplicate path: $relative" }
    $listed.Add($relative)
}

function Check-DestinationInventory([string]$Directory) {
    foreach ($item in Get-ChildItem -LiteralPath $Directory -Force) {
        $relative = [IO.Path]::GetRelativePath($destinationRoot, $item.FullName).Replace('\', '/')
        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw "Reparse point is not allowed: $relative" }
        if ($item.PSIsContainer) {
            Check-DestinationInventory $item.FullName
        } elseif (-not $allowed.Contains($relative)) {
            throw "Unexpected destination file: $relative"
        }
    }
}
Check-DestinationInventory $destinationRoot

foreach ($relative in $listed) {
    $sourceFile = Resolve-ListedFile $sourceRoot $relative
    $destinationFile = Resolve-ListedFile $destinationRoot $relative
    $sourceHash = (Get-FileHash -LiteralPath $sourceFile -Algorithm SHA256).Hash
    $destinationHash = (Get-FileHash -LiteralPath $destinationFile -Algorithm SHA256).Hash
    if ($sourceHash -ne $destinationHash) { throw "Content mismatch: $relative" }
}
Write-Output "PASS: $($listed.Count) permitted files match source bytes; no extra destination files."
Write-Output 'Source revision, consent, record classification, links and external permissions need separate confirmation.'
