$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
Write-Host "Jarvis Phase 05E verification" -ForegroundColor Cyan
Write-Host "Repo root: $RepoRoot" -ForegroundColor Gray

Push-Location $RepoRoot
try {
    $branch = git branch --show-current
    Write-Host "Current branch: $branch" -ForegroundColor Gray
    if ($branch -ne "jarvis/base-integration") {
        throw "Expected branch jarvis/base-integration but found $branch"
    }

    $requiredFiles = @(
        "docs\jarvis\phase-05e-chat-mission-console-redesign.md",
        "docs\jarvis\chat-mission-console-design.md",
        "docs\jarvis\chat-console-test-checklist.md",
        "static\jarvis\jarvis-chat-console.css",
        "static\jarvis\jarvis-chat-console.js",
        "scripts\jarvis\verify-phase-05e.ps1",
        "scripts\jarvis\commit-phase-05e.ps1"
    )

    foreach ($file in $requiredFiles) {
        if (-not (Test-Path $file)) {
            throw "Missing required file: $file"
        }
        Write-Host "OK: $file" -ForegroundColor Green
    }

    $index = Get-Content "static\index.html" -Raw
    if ($index -notmatch "jarvis-chat-console\.css") {
        throw "static/index.html does not include jarvis-chat-console.css"
    }
    Write-Host "OK: static/index.html includes jarvis-chat-console.css" -ForegroundColor Green

    if ($index -notmatch "jarvis-chat-console\.js") {
        throw "static/index.html does not include jarvis-chat-console.js"
    }
    Write-Host "OK: static/index.html includes jarvis-chat-console.js" -ForegroundColor Green

    $css = Get-Content "static\jarvis\jarvis-chat-console.css" -Raw
    if ($css -notmatch "jarvis-chat-console-v1") {
        throw "Jarvis chat console CSS does not include the phase body class"
    }
    Write-Host "OK: chat console CSS contains phase body class" -ForegroundColor Green

    if ($css -notmatch "jarvis-mission-context-rail") {
        throw "Jarvis chat console CSS does not style mission context rail"
    }
    Write-Host "OK: chat console CSS styles mission context rail" -ForegroundColor Green

    $js = Get-Content "static\jarvis\jarvis-chat-console.js" -Raw
    if ($js -notmatch "jarvis-chat-console-v1") {
        throw "Jarvis chat console JS does not include the phase body class"
    }
    Write-Host "OK: chat console JS includes phase body class" -ForegroundColor Green

    if ($js -notmatch "Mission Context") {
        throw "Jarvis chat console JS does not create mission context rail"
    }
    Write-Host "OK: chat console JS creates mission context rail" -ForegroundColor Green

    Write-Host "" 
    Write-Host "Git status:" -ForegroundColor Cyan
    git status --short

    Write-Host "" 
    Write-Host "Phase 05E verification passed." -ForegroundColor Green
}
finally {
    Pop-Location
}
