param(
    [string]$RepoRoot = (Resolve-Path ".").Path
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 05B commit helper" -ForegroundColor Cyan
Write-Host "Repo root: $RepoRoot"

Push-Location $RepoRoot
try {
    $branch = git branch --show-current
    Write-Host "Current branch: $branch"

    if ($branch -ne "jarvis/base-integration") {
        throw "Expected branch jarvis/base-integration but found $branch"
    }

    Write-Host "Running verification first..." -ForegroundColor Cyan
    powershell -ExecutionPolicy Bypass -File ".\scripts\jarvis\verify-phase-05b.ps1" -RepoRoot $RepoRoot

    Write-Host "Checking for risky files..." -ForegroundColor Cyan
    $status = git status --short
    $riskyPatterns = @(
        "^\?\? \.env$",
        "^\?\? data/",
        "^\?\? uploads/",
        "^\?\? logs/",
        "^\?\? .*\.db$",
        "^\?\? .*\.sqlite$",
        "^\?\? .*\.sqlite3$"
    )

    foreach ($line in $status) {
        foreach ($pattern in $riskyPatterns) {
            if ($line -match $pattern) {
                throw "Risky untracked file detected. Review before committing: $line"
            }
        }
    }

    Write-Host "Adding Phase 05B files..." -ForegroundColor Cyan
    git add `
        docs/jarvis/phase-05b-icon-and-encoding-repair.md `
        docs/jarvis/icon-encoding-repair-notes.md `
        static/jarvis/jarvis-icon-repair.css `
        static/jarvis/jarvis-icon-repair.js `
        static/index.html `
        scripts/jarvis/verify-phase-05b.ps1 `
        scripts/jarvis/commit-phase-05b.ps1

    git commit -m "fix: repair Jarvis UI icon encoding artifacts"

    Write-Host "Pushing branch..." -ForegroundColor Cyan
    git push

    Write-Host "Phase 05B commit helper finished." -ForegroundColor Green
}
finally {
    Pop-Location
}
