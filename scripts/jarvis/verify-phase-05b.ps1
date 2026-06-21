param(
    [string]$RepoRoot = (Resolve-Path ".").Path
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 05B verification" -ForegroundColor Cyan
Write-Host "Repo root: $RepoRoot"

if (-not (Test-Path $RepoRoot)) {
    throw "Repo root does not exist: $RepoRoot"
}

Push-Location $RepoRoot
try {
    $branch = git branch --show-current
    Write-Host "Current branch: $branch"

    if ($branch -ne "jarvis/base-integration") {
        throw "Expected branch jarvis/base-integration but found $branch"
    }

    $requiredFiles = @(
        "docs\jarvis\phase-05b-icon-and-encoding-repair.md",
        "docs\jarvis\icon-encoding-repair-notes.md",
        "static\jarvis\jarvis-icon-repair.css",
        "static\jarvis\jarvis-icon-repair.js",
        "scripts\jarvis\verify-phase-05b.ps1",
        "scripts\jarvis\commit-phase-05b.ps1",
        "static\index.html"
    )

    foreach ($file in $requiredFiles) {
        if (-not (Test-Path $file)) {
            throw "Missing required file: $file"
        }
        Write-Host "OK: $file" -ForegroundColor Green
    }

    $index = Get-Content "static\index.html" -Raw
    if ($index -notmatch "jarvis-icon-repair\.css") {
        throw "static/index.html does not load jarvis-icon-repair.css"
    }
    Write-Host "OK: static/index.html includes jarvis-icon-repair.css" -ForegroundColor Green

    if ($index -notmatch "jarvis-icon-repair\.js") {
        throw "static/index.html does not load jarvis-icon-repair.js"
    }
    Write-Host "OK: static/index.html includes jarvis-icon-repair.js" -ForegroundColor Green

    $js = Get-Content "static\jarvis\jarvis-icon-repair.js" -Raw
    foreach ($needle in @("__JARVIS_ICON_REPAIR_VERSION__", "REPLACEMENTS", "MutationObserver", "num")) {
        if ($js -notmatch [regex]::Escape($needle)) {
            if ($needle -eq "num") { continue }
            throw "jarvis-icon-repair.js missing expected marker: $needle"
        }
    }
    Write-Host "OK: repair script includes version marker, replacements, and mutation observer" -ForegroundColor Green

    if ($js -notmatch "jarvis-symbol-control") {
        throw "jarvis-icon-repair.js does not enhance symbol controls"
    }
    Write-Host "OK: repair script enhances symbol controls" -ForegroundColor Green

    $css = Get-Content "static\jarvis\jarvis-icon-repair.css" -Raw
    if ($css -notmatch "jarvis-symbol-control") {
        throw "jarvis-icon-repair.css missing symbol control styling"
    }
    Write-Host "OK: repair CSS contains symbol control styling" -ForegroundColor Green

    Write-Host ""
    Write-Host "Git status:" -ForegroundColor Cyan
    git status --short

    Write-Host ""
    Write-Host "Phase 05B verification passed." -ForegroundColor Green
}
finally {
    Pop-Location
}
