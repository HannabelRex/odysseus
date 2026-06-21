param(
    [string]$RepoRoot = (Resolve-Path ".").Path
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 03 verification" -ForegroundColor Cyan
Write-Host "Repo root: $RepoRoot"

if (-not (Test-Path $RepoRoot)) {
    throw "Repo root not found: $RepoRoot"
}

Push-Location $RepoRoot
try {
    $branch = (git branch --show-current).Trim()
    Write-Host "Current branch: $branch"
    if ($branch -ne "jarvis/base-integration") {
        throw "Expected branch jarvis/base-integration but found $branch"
    }

    $requiredFiles = @(
        "docs\jarvis\phase-03-universal-jarvis-identity-and-presets.md",
        "docs\jarvis\jarvis-identity.md",
        "docs\jarvis\jarvis-operating-rules.md",
        "docs\jarvis\jarvis-assistant-presets.md",
        "docs\jarvis\jarvis-system-prompts.md",
        "docs\jarvis\jarvis-task-modes.md",
        "docs\jarvis\jarvis-model-routing-notes.md",
        "static\jarvis\jarvis-presets.js",
        "scripts\jarvis\verify-phase-03.ps1",
        "scripts\jarvis\commit-phase-03.ps1",
        "static\index.html"
    )

    foreach ($file in $requiredFiles) {
        if (-not (Test-Path $file)) {
            throw "Missing required file: $file"
        }
        Write-Host "OK: $file" -ForegroundColor Green
    }

    $index = Get-Content -Raw "static\index.html"
    if ($index -notmatch "jarvis-presets\.js") {
        throw "static/index.html does not include jarvis-presets.js"
    }
    Write-Host "OK: static/index.html includes jarvis-presets.js" -ForegroundColor Green

    if ($index -notmatch "jarvis-theme\.css") {
        throw "static/index.html does not include jarvis-theme.css from Phase 02"
    }
    Write-Host "OK: static/index.html still includes jarvis-theme.css" -ForegroundColor Green

    if ($index -notmatch "jarvis-ux\.js") {
        throw "static/index.html does not include jarvis-ux.js from Phase 02"
    }
    Write-Host "OK: static/index.html still includes jarvis-ux.js" -ForegroundColor Green

    $presets = Get-Content -Raw "static\jarvis\jarvis-presets.js"
    if ($presets -notmatch "JARVIS_UNIVERSAL_PRESETS") {
        throw "jarvis-presets.js does not expose JARVIS_UNIVERSAL_PRESETS"
    }
    Write-Host "OK: jarvis-presets.js exposes JARVIS_UNIVERSAL_PRESETS" -ForegroundColor Green

    if ($presets -notmatch "universal-personal-assistant") {
        throw "jarvis-presets.js does not declare universal assistant scope"
    }
    Write-Host "OK: jarvis-presets.js declares universal assistant scope" -ForegroundColor Green

    $identity = Get-Content -Raw "docs\jarvis\jarvis-identity.md"
    if ($identity -notmatch "not limited to SAP ABAP or HR portal") {
        throw "jarvis-identity.md must clearly say Jarvis is not limited to SAP ABAP or HR portal work"
    }
    Write-Host "OK: identity confirms universal scope" -ForegroundColor Green

    $accidental = "hell -ExecutionPolicy Bypass -File .scriptsjarviscommit-phase-02.ps1"
    if (Test-Path $accidental) {
        Write-Host "WARNING: Accidental command typo file exists: $accidental" -ForegroundColor Yellow
        Write-Host "Remove it with: Remove-Item `".\$accidental`" -Force" -ForegroundColor Yellow
    }

    Write-Host ""
    Write-Host "Git status:" -ForegroundColor Cyan
    git status --short

    Write-Host ""
    Write-Host "Phase 03 verification passed." -ForegroundColor Green
}
finally {
    Pop-Location
}
