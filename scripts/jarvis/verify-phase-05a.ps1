param(
    [string]$RepoRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 05A verification" -ForegroundColor Cyan
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

    $required = @(
        "docs\jarvis\phase-05a-premium-ui-audit-and-restructure-blueprint.md",
        "docs\jarvis\ui-audit-findings.md",
        "docs\jarvis\premium-ui-restructure-plan.md",
        "docs\jarvis\jarvis-interface-map.md",
        "docs\jarvis\ui-implementation-phases.md",
        "scripts\jarvis\verify-phase-05a.ps1",
        "scripts\jarvis\commit-phase-05a.ps1"
    )

    foreach ($file in $required) {
        if (-not (Test-Path $file)) {
            throw "Missing required file: $file"
        }
        Write-Host "OK: $file" -ForegroundColor Green
    }

    $audit = Get-Content "docs\jarvis\ui-audit-findings.md" -Raw
    if ($audit -notmatch "Broken glyphs") {
        throw "Audit file does not mention broken glyphs."
    }
    Write-Host "OK: audit documents broken glyph problem" -ForegroundColor Green

    $plan = Get-Content "docs\jarvis\premium-ui-restructure-plan.md" -Raw
    if ($plan -notmatch "universal") {
        throw "Premium plan must keep Jarvis universal."
    }
    Write-Host "OK: premium plan keeps Jarvis universal" -ForegroundColor Green

    $phases = Get-Content "docs\jarvis\ui-implementation-phases.md" -Raw
    if ($phases -notmatch "Phase 05B - Icon and Encoding Repair") {
        throw "Implementation phases must include Phase 05B icon and encoding repair."
    }
    Write-Host "OK: implementation phases include Phase 05B" -ForegroundColor Green

    Write-Host "`nGit status:" -ForegroundColor Cyan
    git status --short

    Write-Host "`nPhase 05A verification passed." -ForegroundColor Green
}
finally {
    Pop-Location
}
