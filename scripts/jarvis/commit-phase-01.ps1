param(
    [string]$RepoRoot = "P:\Projects\odysseus",
    [string]$Message = "docs: add Jarvis project tracking and safety baseline",
    [switch]$SkipPush
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 01 commit helper" -ForegroundColor Cyan
Write-Host "Repo root: $RepoRoot"

if (-not (Test-Path $RepoRoot)) {
    throw "Repo root not found: $RepoRoot"
}

Set-Location $RepoRoot

if (-not (Test-Path ".git")) {
    throw "This folder is not a Git repository: $RepoRoot"
}

$currentBranch = git branch --show-current
Write-Host "Current branch: $currentBranch"

if ($currentBranch -ne "jarvis/base-integration") {
    throw "Refusing to commit Phase 01 from branch $currentBranch. Switch to jarvis/base-integration first."
}

Write-Host "Running verification first..." -ForegroundColor Cyan
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\verify-phase-01.ps1 -RepoRoot $RepoRoot

Write-Host "Checking for risky files..." -ForegroundColor Cyan
$status = git status --short
$riskyPatterns = @(".env", "data/", "data\\", "logs/", "logs\\", "uploads/", "uploads\\", ".sqlite", ".sqlite3", ".db", ".venv", "node_modules")

foreach ($line in $status) {
    foreach ($pattern in $riskyPatterns) {
        if ($line -like "*$pattern*") {
            throw "Refusing to commit because risky file/path appears in git status: $line"
        }
    }
}

Write-Host "Adding Phase 01 files..." -ForegroundColor Cyan
git add docs\jarvis scripts\jarvis

$pending = git status --short
if (-not $pending) {
    Write-Host "No changes to commit." -ForegroundColor Yellow
} else {
    git commit -m $Message
}

if (-not $SkipPush) {
    Write-Host "Pushing branch..." -ForegroundColor Cyan
    git push
} else {
    Write-Host "SkipPush set. Not pushing." -ForegroundColor Yellow
}

Write-Host "Phase 01 commit helper finished." -ForegroundColor Green
