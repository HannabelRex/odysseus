param(
    [string]$RepoRoot = "P:\Projects\odysseus"
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 05D verification" -ForegroundColor Cyan
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

    $requiredFiles = @(
        "docs\jarvis\phase-05d-sidebar-and-top-command-bar-redesign.md",
        "docs\jarvis\sidebar-command-bar-design.md",
        "docs\jarvis\navigation-shell-test-checklist.md",
        "static\jarvis\jarvis-navigation-shell.css",
        "static\jarvis\jarvis-navigation-shell.js",
        "scripts\jarvis\verify-phase-05d.ps1",
        "scripts\jarvis\commit-phase-05d.ps1",
        "static\index.html"
    )

    foreach ($file in $requiredFiles) {
        if (!(Test-Path $file)) {
            throw "Missing required file: $file"
        }
        Write-Host "OK: $file" -ForegroundColor Green
    }

    $index = Get-Content "static\index.html" -Raw
    if ($index -notmatch "jarvis-navigation-shell\.css") {
        throw "static/index.html does not reference jarvis-navigation-shell.css"
    }
    Write-Host "OK: static/index.html includes jarvis-navigation-shell.css" -ForegroundColor Green

    if ($index -notmatch "jarvis-navigation-shell\.js") {
        throw "static/index.html does not reference jarvis-navigation-shell.js"
    }
    Write-Host "OK: static/index.html includes jarvis-navigation-shell.js" -ForegroundColor Green

    $css = Get-Content "static\jarvis\jarvis-navigation-shell.css" -Raw
    if ($css -notmatch "jarvis-sidebar-shell") {
        throw "Navigation CSS missing jarvis-sidebar-shell selector"
    }
    Write-Host "OK: navigation CSS contains sidebar shell selector" -ForegroundColor Green

    if ($css -notmatch "jarvis-command-bar") {
        throw "Navigation CSS missing command bar selector"
    }
    Write-Host "OK: navigation CSS contains command bar selector" -ForegroundColor Green

    $js = Get-Content "static\jarvis\jarvis-navigation-shell.js" -Raw
    if ($js -notmatch "jarvis-nav-shell-v1") {
        throw "Navigation JS missing jarvis-nav-shell-v1 class"
    }
    Write-Host "OK: navigation JS applies phase body class" -ForegroundColor Green

    if ($js -notmatch "jarvis-command-bar") {
        throw "Navigation JS missing command bar injection"
    }
    Write-Host "OK: navigation JS injects command bar" -ForegroundColor Green

    Write-Host "`nGit status:" -ForegroundColor Cyan
    git status --short

    Write-Host "`nPhase 05D verification passed." -ForegroundColor Green
}
finally {
    Pop-Location
}
