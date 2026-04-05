$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillsSource = Join-Path $repoRoot 'skills'
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
$skillsDest = Join-Path $codexHome 'skills'

if (-not (Test-Path $skillsSource)) {
    throw "Skills source folder not found: $skillsSource"
}

if (-not (Test-Path $skillsDest)) {
    New-Item -ItemType Directory -Path $skillsDest | Out-Null
}

Get-ChildItem $skillsSource -Directory | ForEach-Object {
    $destination = Join-Path $skillsDest $_.Name

    if (Test-Path $destination) {
        Remove-Item -LiteralPath $destination -Recurse -Force
    }

    Copy-Item -Path $_.FullName -Destination $destination -Recurse
    Write-Host "Synced $($_.Name) -> $destination"
}

Write-Host "Done. Restart Codex to load updated skills."
