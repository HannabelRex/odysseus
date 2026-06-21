param(
    [string]$RepoRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Hotfix 04A verification" -ForegroundColor Cyan
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

$requiredFiles = @(
    "docs\jarvis\hotfix-04a-ollama-test-timeout-and-diagnostics.md",
    "docs\jarvis\local-model-troubleshooting.md",
    "scripts\jarvis\test-ollama.ps1",
    "scripts\jarvis\verify-hotfix-04a.ps1",
    "scripts\jarvis\commit-hotfix-04a.ps1"
)

foreach ($file in $requiredFiles) {
    if (-not (Test-Path $file)) {
        throw "Missing required file: $file"
    }
    Write-Host "OK: $file" -ForegroundColor Green
}

$testScript = Get-Content "scripts\jarvis\test-ollama.ps1" -Raw
if ($testScript -notmatch 'llama3\.2:3b') {
    throw "test-ollama.ps1 should default to or mention llama3.2:3b"
}
Write-Host "OK: test script includes llama3.2:3b starter model" -ForegroundColor Green

if ($testScript -notmatch 'TimeoutSec') {
    throw "test-ollama.ps1 should expose TimeoutSec"
}
Write-Host "OK: test script exposes TimeoutSec" -ForegroundColor Green

if ($testScript -notmatch 'num_predict') {
    throw "test-ollama.ps1 should send num_predict option"
}
Write-Host "OK: test script sends num_predict" -ForegroundColor Green

if ($testScript -notmatch 'Beginner-friendly recovery steps') {
    throw "test-ollama.ps1 should include beginner-friendly recovery steps"
}
Write-Host "OK: test script includes beginner-friendly recovery steps" -ForegroundColor Green

$troubleshooting = Get-Content "docs\jarvis\local-model-troubleshooting.md" -Raw
if ($troubleshooting -notmatch 'Hotfix 04A') {
    throw "local-model-troubleshooting.md should mention Hotfix 04A"
}
Write-Host "OK: troubleshooting doc documents Hotfix 04A" -ForegroundColor Green

Write-Host "" 
Write-Host "Git status:" -ForegroundColor Cyan
git status --short

Write-Host "" 
Write-Host "Hotfix 04A verification passed." -ForegroundColor Green
