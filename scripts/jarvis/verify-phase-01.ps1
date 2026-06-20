param(
    [string]$RepoRoot = "P:\Projects\odysseus"
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 01 verification" -ForegroundColor Cyan
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
    Write-Warning "Expected branch jarvis/base-integration. Current branch is $currentBranch."
}

$requiredFiles = @(
    "docs\jarvis\phase-01-project-tracking-and-safety-baseline.md",
    "docs\jarvis\jarvis-roadmap.md",
    "docs\jarvis\phase-plan.md",
    "docs\jarvis\free-first-stack.md",
    "docs\jarvis\safety-policy.md",
    "docs\jarvis\local-setup-notes.md",
    "scripts\jarvis\verify-phase-01.ps1",
    "scripts\jarvis\commit-phase-01.ps1"
)

$missing = @()
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "OK: $file" -ForegroundColor Green
    } else {
        Write-Host "MISSING: $file" -ForegroundColor Red
        $missing += $file
    }
}

if ($missing.Count -gt 0) {
    throw "Phase 01 verification failed. Missing $($missing.Count) file(s)."
}

Write-Host ""
Write-Host "Git status:" -ForegroundColor Cyan
git status --short

Write-Host ""
Write-Host "Phase 01 verification passed." -ForegroundColor Green
