$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
Write-Host "Jarvis Phase 05E commit helper" -ForegroundColor Cyan
Write-Host "Repo root: $RepoRoot" -ForegroundColor Gray

Push-Location $RepoRoot
try {
    $branch = git branch --show-current
    Write-Host "Current branch: $branch" -ForegroundColor Gray
    if ($branch -ne "jarvis/base-integration") {
        throw "Expected branch jarvis/base-integration but found $branch"
    }

    Write-Host "Running verification first..." -ForegroundColor Cyan
    powershell -ExecutionPolicy Bypass -File ".\scripts\jarvis\verify-phase-05e.ps1"

    Write-Host "Checking for risky files..." -ForegroundColor Cyan
    $status = git status --short
    $riskyPatterns = @(
        "^.M?\s+\.env$",
        "^\?\?\s+\.env$",
        "data/",
        "\.sqlite$",
        "\.sqlite3$",
        "\.db$",
        "uploads/",
        "logs/",
        "node_modules/",
        "\.venv/"
    )

    foreach ($line in $status) {
        foreach ($pattern in $riskyPatterns) {
            if ($line -match $pattern) {
                throw "Risky file detected in git status: $line"
            }
        }
    }

    Write-Host "Adding Phase 05E files..." -ForegroundColor Cyan
    git add `
        docs/jarvis/phase-05e-chat-mission-console-redesign.md `
        docs/jarvis/chat-mission-console-design.md `
        docs/jarvis/chat-console-test-checklist.md `
        static/jarvis/jarvis-chat-console.css `
        static/jarvis/jarvis-chat-console.js `
        scripts/jarvis/verify-phase-05e.ps1 `
        scripts/jarvis/commit-phase-05e.ps1 `
        static/index.html

    $staged = git diff --cached --name-only
    if (-not $staged) {
        Write-Host "No staged changes found. Nothing to commit." -ForegroundColor Yellow
        return
    }

    git commit -m "feat: redesign Jarvis chat mission console"

    Write-Host "Pushing branch..." -ForegroundColor Cyan
    git push

    Write-Host "Phase 05E commit helper finished." -ForegroundColor Green
}
finally {
    Pop-Location
}
