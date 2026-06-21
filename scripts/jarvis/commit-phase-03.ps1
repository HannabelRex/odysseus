param(
    [string]$RepoRoot = (Resolve-Path ".").Path
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 03 commit helper" -ForegroundColor Cyan
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

    Write-Host "Running verification first..." -ForegroundColor Cyan
    powershell -ExecutionPolicy Bypass -File ".\scripts\jarvis\verify-phase-03.ps1" -RepoRoot $RepoRoot

    Write-Host "Checking for known accidental typo file..." -ForegroundColor Cyan
    $accidental = "hell -ExecutionPolicy Bypass -File .scriptsjarviscommit-phase-02.ps1"
    if (Test-Path $accidental) {
        Remove-Item ".\$accidental" -Force
        Write-Host "Removed known accidental typo file: $accidental" -ForegroundColor Yellow
    }

    Write-Host "Checking for risky files..." -ForegroundColor Cyan
    $status = git status --short
    $riskyPatterns = @(".env", "data/", "logs/", "uploads/", ".db", ".sqlite", ".sqlite3", "node_modules/", ".venv/")
    foreach ($line in $status) {
        foreach ($pattern in $riskyPatterns) {
            if ($line -like "*$pattern*") {
                throw "Risky file detected in git status: $line"
            }
        }
    }

    Write-Host "Adding Phase 03 files..." -ForegroundColor Cyan
    git add `
        docs/jarvis/phase-03-universal-jarvis-identity-and-presets.md `
        docs/jarvis/jarvis-identity.md `
        docs/jarvis/jarvis-operating-rules.md `
        docs/jarvis/jarvis-assistant-presets.md `
        docs/jarvis/jarvis-system-prompts.md `
        docs/jarvis/jarvis-task-modes.md `
        docs/jarvis/jarvis-model-routing-notes.md `
        static/jarvis/jarvis-presets.js `
        scripts/jarvis/verify-phase-03.ps1 `
        scripts/jarvis/commit-phase-03.ps1 `
        static/index.html

    $staged = git diff --cached --name-only
    if (-not $staged) {
        Write-Host "No staged changes for Phase 03. Nothing to commit." -ForegroundColor Yellow
        return
    }

    git commit -m "feat: add universal Jarvis identity and presets"

    Write-Host "Pushing branch..." -ForegroundColor Cyan
    git push

    Write-Host "Phase 03 commit helper finished." -ForegroundColor Green
}
finally {
    Pop-Location
}
