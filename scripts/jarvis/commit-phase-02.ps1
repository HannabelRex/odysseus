$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
Write-Host "Jarvis Phase 02 commit helper"
Write-Host "Repo root: $RepoRoot"

Push-Location $RepoRoot
try {
  $branch = git branch --show-current
  Write-Host "Current branch: $branch"

  if ($branch -ne "jarvis/base-integration") {
    throw "Expected branch jarvis/base-integration but found $branch"
  }

  Write-Host "Running verification first..."
  powershell -ExecutionPolicy Bypass -File ".\scripts\jarvis\verify-phase-02.ps1"

  Write-Host "Checking for risky files..."
  $status = git status --short
  $riskyPatterns = @(".env", "data/", "data\\", "*.db", "*.sqlite", "*.sqlite3", "uploads/", "uploads\\", "logs/", "logs\\", "node_modules/", "node_modules\\", ".venv/", ".venv\\")
  foreach ($line in $status) {
    foreach ($pattern in $riskyPatterns) {
      $normalizedPattern = $pattern.Replace("*", "")
      if ($line -like "*$normalizedPattern*") {
        throw "Risky file detected in git status: $line"
      }
    }
  }

  Write-Host "Adding Phase 02 files..."
  git add `
    docs/jarvis/phase-02-universal-jarvis-ui-shell.md `
    docs/jarvis/universal-assistant-scope.md `
    docs/jarvis/jarvis-ui-design-system.md `
    static/jarvis/jarvis-theme.css `
    static/jarvis/jarvis-ux.js `
    static/index.html `
    scripts/jarvis/verify-phase-02.ps1 `
    scripts/jarvis/commit-phase-02.ps1

  $pending = git diff --cached --name-only
  if (-not $pending) {
    Write-Host "No staged changes found. Nothing to commit."
    exit 0
  }

  git commit -m "feat: add universal Jarvis UI shell"

  Write-Host "Pushing branch..."
  git push

  Write-Host "Phase 02 commit helper finished."
}
finally {
  Pop-Location
}
