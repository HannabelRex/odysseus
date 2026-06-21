param(
    [string]$RepoRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Hotfix 04A commit helper" -ForegroundColor Cyan
Write-Host "Repo root: $RepoRoot"

if (-not (Test-Path $RepoRoot)) {
    throw "Repo root does not exist: $RepoRoot"
}

Set-Location $RepoRoot

$currentBranch = git branch --show-current
Write-Host "Current branch: $currentBranch"
if ($currentBranch -ne "jarvis/base-integration") {
    throw "Expected branch jarvis/base-integration, but found $currentBranch"
}

Write-Host "Running verification first..." -ForegroundColor Cyan
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\verify-hotfix-04a.ps1 -RepoRoot $RepoRoot

Write-Host "Checking for risky files..." -ForegroundColor Cyan
$status = git status --short
$riskyPatterns = @(
    '^\?\? \.env$',
    '^\?\? .*\.db$',
    '^\?\? .*\.sqlite$',
    '^\?\? .*\.sqlite3$',
    '^\?\? data/',
    '^\?\? uploads/',
    '^\?\? logs/',
    '^\?\? generated/'
)

foreach ($line in $status) {
    foreach ($pattern in $riskyPatterns) {
        if ($line -match $pattern) {
            throw "Risky untracked file detected: $line. Review before committing."
        }
    }
}

Write-Host "Adding Hotfix 04A files..." -ForegroundColor Cyan
git add `
    docs/jarvis/hotfix-04a-ollama-test-timeout-and-diagnostics.md `
    docs/jarvis/local-model-troubleshooting.md `
    scripts/jarvis/test-ollama.ps1 `
    scripts/jarvis/verify-hotfix-04a.ps1 `
    scripts/jarvis/commit-hotfix-04a.ps1

$pending = git diff --cached --name-only
if (-not $pending) {
    Write-Host "No staged changes found. Nothing to commit." -ForegroundColor Yellow
    exit 0
}

git commit -m "fix: improve Ollama local model test diagnostics"

Write-Host "Pushing branch..." -ForegroundColor Cyan
git push

Write-Host "Hotfix 04A commit helper finished." -ForegroundColor Green
