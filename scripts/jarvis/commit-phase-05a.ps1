param(
    [string]$RepoRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 05A commit helper" -ForegroundColor Cyan
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
    powershell -ExecutionPolicy Bypass -File ".\scripts\jarvis\verify-phase-05a.ps1" -RepoRoot $RepoRoot

    Write-Host "Checking for risky files..." -ForegroundColor Cyan
    $status = git status --short
    $risky = $status | Select-String -Pattern "(^|\s)(\.env|data/|data\\|.*\.db|.*\.sqlite|.*\.sqlite3|uploads/|uploads\\|node_modules/|node_modules\\|\.venv/|\.venv\\)"
    if ($risky) {
        Write-Host $risky -ForegroundColor Red
        throw "Risky files detected. Stop and review before committing."
    }

    Write-Host "Adding Phase 05A files..." -ForegroundColor Cyan
    git add `
        docs/jarvis/phase-05a-premium-ui-audit-and-restructure-blueprint.md `
        docs/jarvis/ui-audit-findings.md `
        docs/jarvis/premium-ui-restructure-plan.md `
        docs/jarvis/jarvis-interface-map.md `
        docs/jarvis/ui-implementation-phases.md `
        scripts/jarvis/verify-phase-05a.ps1 `
        scripts/jarvis/commit-phase-05a.ps1

    $pending = git diff --cached --name-only
    if (-not $pending) {
        Write-Host "No staged changes found. Phase 05A may already be committed." -ForegroundColor Yellow
        exit 0
    }

    git commit -m "docs: add premium Jarvis UI restructure blueprint"

    Write-Host "Pushing branch..." -ForegroundColor Cyan
    git push

    Write-Host "Phase 05A commit helper finished." -ForegroundColor Green
}
finally {
    Pop-Location
}
