param(
    [string]$RepoRoot = "P:\Projects\odysseus"
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 05D commit helper" -ForegroundColor Cyan
Write-Host "Repo root: $RepoRoot"

if (!(Test-Path $RepoRoot)) {
    throw "Repo root not found: $RepoRoot"
}

Push-Location $RepoRoot
try {
    $branch = git branch --show-current
    Write-Host "Current branch: $branch"

    if ($branch -ne "jarvis/base-integration") {
        throw "Expected branch jarvis/base-integration but found $branch"
    }

    Write-Host "Running verification first..." -ForegroundColor Cyan
    powershell -ExecutionPolicy Bypass -File ".\scripts\jarvis\verify-phase-05d.ps1" -RepoRoot $RepoRoot

    Write-Host "Checking for risky files..." -ForegroundColor Cyan
    $status = git status --short
    $riskyPatterns = @(".env", "data/", "data\\", "node_modules/", "node_modules\\", "__pycache__", ".venv", "*.db", "*.sqlite")
    foreach ($line in $status) {
        foreach ($pattern in $riskyPatterns) {
            if ($line -like "*$pattern*") {
                throw "Risky file appears in git status: $line"
            }
        }
    }

    Write-Host "Adding Phase 05D files..." -ForegroundColor Cyan
    git add `
        docs/jarvis/phase-05d-sidebar-and-top-command-bar-redesign.md `
        docs/jarvis/sidebar-command-bar-design.md `
        docs/jarvis/navigation-shell-test-checklist.md `
        static/jarvis/jarvis-navigation-shell.css `
        static/jarvis/jarvis-navigation-shell.js `
        scripts/jarvis/verify-phase-05d.ps1 `
        scripts/jarvis/commit-phase-05d.ps1 `
        static/index.html

    $pending = git diff --cached --name-only
    if (-not $pending) {
        Write-Host "No staged changes found. Nothing to commit." -ForegroundColor Yellow
        exit 0
    }

    git commit -m "feat: redesign Jarvis sidebar and command bar shell"

    Write-Host "Pushing branch..." -ForegroundColor Cyan
    git push

    Write-Host "Phase 05D commit helper finished." -ForegroundColor Green
}
finally {
    Pop-Location
}
