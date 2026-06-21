param(
    [string]$RepoRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 05C commit helper" -ForegroundColor Cyan
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

    Write-Host "Running verification first..." -ForegroundColor Cyan
    powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\verify-phase-05c.ps1 -RepoRoot $RepoRoot

    Write-Host "Checking for risky files..." -ForegroundColor Cyan
    $status = git status --short
    $riskyPatterns = @(".env", "data/", "data\\", "*.db", "*.sqlite", "*.sqlite3", "node_modules/", ".venv/", "__pycache__")
    foreach ($line in $status) {
        foreach ($pattern in $riskyPatterns) {
            if ($line -like "*$pattern*") {
                throw "Risky file appears in git status: $line"
            }
        }
    }

    Write-Host "Adding Phase 05C files..." -ForegroundColor Cyan
    git add `
        docs/jarvis/phase-05c-premium-design-token-system.md `
        docs/jarvis/premium-design-token-guide.md `
        docs/jarvis/jarvis-premium-visual-direction.md `
        static/jarvis/jarvis-design-tokens.css `
        static/jarvis/jarvis-premium-foundation.css `
        static/index.html `
        scripts/jarvis/verify-phase-05c.ps1 `
        scripts/jarvis/commit-phase-05c.ps1

    $staged = git diff --cached --name-only
    if (-not $staged) {
        Write-Host "No staged changes found. Phase 05C may already be committed." -ForegroundColor Yellow
        return
    }

    git commit -m "style: add premium Jarvis design token system"

    Write-Host "Pushing branch..." -ForegroundColor Cyan
    git push

    Write-Host "Phase 05C commit helper finished." -ForegroundColor Green
}
finally {
    Pop-Location
}
