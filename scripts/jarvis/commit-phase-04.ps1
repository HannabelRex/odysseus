param(
    [string]$RepoRoot = "P:\Projects\odysseus"
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 04 commit helper" -ForegroundColor Cyan
Write-Host "Repo root: $RepoRoot"

if (-not (Test-Path $RepoRoot)) {
    throw "Repo root not found: $RepoRoot"
}

Push-Location $RepoRoot
try {
    $branch = git branch --show-current
    Write-Host "Current branch: $branch"
    if ($branch -ne "jarvis/base-integration") {
        throw "Expected branch jarvis/base-integration but found $branch"
    }

    Write-Host "Running verification first..." -ForegroundColor Cyan
    & powershell -ExecutionPolicy Bypass -File ".\scripts\jarvis\verify-phase-04.ps1" -RepoRoot $RepoRoot

    Write-Host "Checking for risky files..." -ForegroundColor Cyan
    $status = git status --porcelain
    $riskyPatterns = @(
        "^.env$",
        "^data/",
        "^logs/",
        "^uploads/",
        "^generated/",
        "\.db$",
        "\.sqlite$",
        "\.sqlite3$"
    )

    foreach ($line in $status) {
        $path = $line.Substring(3).Replace("\", "/").Trim('"')
        foreach ($pattern in $riskyPatterns) {
            if ($path -match $pattern) {
                throw "Risky file detected in git status: $path. Stop and review before committing."
            }
        }
    }

    Write-Host "Adding Phase 04 files..." -ForegroundColor Cyan
    git add `
        docs/jarvis/phase-04-free-local-model-configuration.md `
        docs/jarvis/local-model-setup.md `
        docs/jarvis/ollama-model-guide.md `
        docs/jarvis/model-provider-routing.md `
        docs/jarvis/local-model-troubleshooting.md `
        scripts/jarvis/verify-phase-04.ps1 `
        scripts/jarvis/commit-phase-04.ps1 `
        scripts/jarvis/pull-local-models.ps1 `
        scripts/jarvis/test-ollama.ps1

    $staged = git diff --cached --name-only
    if (-not $staged) {
        Write-Host "No staged changes found. Nothing to commit." -ForegroundColor Yellow
        return
    }

    git commit -m "docs: add free local model configuration guide"

    Write-Host "Pushing branch..." -ForegroundColor Cyan
    git push

    Write-Host "Phase 04 commit helper finished." -ForegroundColor Green
}
finally {
    Pop-Location
}
