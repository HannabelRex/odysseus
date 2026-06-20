$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
Write-Host "Jarvis Phase 02 verification"
Write-Host "Repo root: $RepoRoot"

Push-Location $RepoRoot
try {
  $branch = git branch --show-current
  Write-Host "Current branch: $branch"

  if ($branch -ne "jarvis/base-integration") {
    throw "Expected branch jarvis/base-integration but found $branch"
  }

  $requiredFiles = @(
    "docs\jarvis\phase-02-universal-jarvis-ui-shell.md",
    "docs\jarvis\universal-assistant-scope.md",
    "docs\jarvis\jarvis-ui-design-system.md",
    "static\jarvis\jarvis-theme.css",
    "static\jarvis\jarvis-ux.js",
    "scripts\jarvis\verify-phase-02.ps1",
    "scripts\jarvis\commit-phase-02.ps1",
    "static\index.html"
  )

  foreach ($file in $requiredFiles) {
    if (!(Test-Path $file)) {
      throw "Missing required file: $file"
    }
    Write-Host "OK: $file"
  }

  $indexContent = Get-Content "static\index.html" -Raw
  if ($indexContent -notmatch "jarvis-theme\.css") {
    throw "static/index.html does not include jarvis-theme.css"
  }
  Write-Host "OK: static/index.html includes jarvis-theme.css"

  if ($indexContent -notmatch "jarvis-ux\.js") {
    throw "static/index.html does not include jarvis-ux.js"
  }
  Write-Host "OK: static/index.html includes jarvis-ux.js"

  $cssContent = Get-Content "static\jarvis\jarvis-theme.css" -Raw
  if ($cssContent -notmatch "jarvis-universal-ui") {
    throw "Jarvis CSS missing jarvis-universal-ui selector"
  }
  Write-Host "OK: Jarvis CSS contains universal UI selectors"

  $jsContent = Get-Content "static\jarvis\jarvis-ux.js" -Raw
  if ($jsContent -notmatch "Jarvis Universal Mode") {
    throw "Jarvis UX script missing Universal Mode status"
  }
  Write-Host "OK: Jarvis UX script contains universal mode status"

  Write-Host ""
  Write-Host "Git status:"
  git status --short

  Write-Host ""
  Write-Host "Phase 02 verification passed."
}
finally {
  Pop-Location
}
