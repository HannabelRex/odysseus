param(
    [string]$RepoRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 05C verification" -ForegroundColor Cyan
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

    $requiredFiles = @(
        "docs\jarvis\phase-05c-premium-design-token-system.md",
        "docs\jarvis\premium-design-token-guide.md",
        "docs\jarvis\jarvis-premium-visual-direction.md",
        "static\jarvis\jarvis-design-tokens.css",
        "static\jarvis\jarvis-premium-foundation.css",
        "scripts\jarvis\verify-phase-05c.ps1",
        "scripts\jarvis\commit-phase-05c.ps1"
    )

    foreach ($file in $requiredFiles) {
        if (-not (Test-Path $file)) {
            throw "Missing required file: $file"
        }
        Write-Host "OK: $file" -ForegroundColor Green
    }

    $index = Get-Content "static\index.html" -Raw
    if ($index -notmatch "jarvis-design-tokens\.css") {
        throw "static/index.html does not include jarvis-design-tokens.css"
    }
    Write-Host "OK: static/index.html includes jarvis-design-tokens.css" -ForegroundColor Green

    if ($index -notmatch "jarvis-premium-foundation\.css") {
        throw "static/index.html does not include jarvis-premium-foundation.css"
    }
    Write-Host "OK: static/index.html includes jarvis-premium-foundation.css" -ForegroundColor Green

    $tokens = Get-Content "static\jarvis\jarvis-design-tokens.css" -Raw
    foreach ($token in @("--jarvis-space-void", "--jarvis-surface-glass", "--jarvis-cyan", "--jarvis-radius-xl", "--jarvis-shadow-glow")) {
        if ($tokens -notmatch [regex]::Escape($token)) {
            throw "Design token file missing token: $token"
        }
        Write-Host "OK: token present $token" -ForegroundColor Green
    }

    $foundation = Get-Content "static\jarvis\jarvis-premium-foundation.css" -Raw
    if ($foundation -notmatch "body\.jarvis-universal-ui") {
        throw "Premium foundation CSS does not target body.jarvis-universal-ui"
    }
    Write-Host "OK: premium foundation targets Jarvis universal UI" -ForegroundColor Green

    Write-Host "`nGit status:" -ForegroundColor Cyan
    git status --short

    Write-Host "`nPhase 05C verification passed." -ForegroundColor Green
}
finally {
    Pop-Location
}
