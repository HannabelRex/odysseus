param(
    [string]$RepoRoot = "P:\Projects\odysseus"
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Phase 04 verification" -ForegroundColor Cyan
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

    $requiredFiles = @(
        "docs\jarvis\phase-04-free-local-model-configuration.md",
        "docs\jarvis\local-model-setup.md",
        "docs\jarvis\ollama-model-guide.md",
        "docs\jarvis\model-provider-routing.md",
        "docs\jarvis\local-model-troubleshooting.md",
        "scripts\jarvis\verify-phase-04.ps1",
        "scripts\jarvis\commit-phase-04.ps1",
        "scripts\jarvis\pull-local-models.ps1",
        "scripts\jarvis\test-ollama.ps1"
    )

    foreach ($file in $requiredFiles) {
        if (-not (Test-Path $file)) {
            throw "Missing required file: $file"
        }
        Write-Host "OK: $file" -ForegroundColor Green
    }

    $setup = Get-Content "docs\jarvis\local-model-setup.md" -Raw
    if ($setup -notmatch "host\.docker\.internal:11434/v1") {
        throw "local-model-setup.md must document Docker-to-Ollama endpoint"
    }
    Write-Host "OK: local-model-setup documents Docker-to-Ollama endpoint" -ForegroundColor Green

    $guide = Get-Content "docs\jarvis\ollama-model-guide.md" -Raw
    foreach ($model in @("llama3.1:8b", "qwen2.5-coder:7b", "mistral", "nomic-embed-text")) {
        if ($guide -notmatch [regex]::Escape($model)) {
            throw "ollama-model-guide.md must mention $model"
        }
    }
    Write-Host "OK: model guide contains recommended starter models" -ForegroundColor Green

    $pullScript = Get-Content "scripts\jarvis\pull-local-models.ps1" -Raw
    if ($pullScript -notmatch "ollama pull") {
        throw "pull-local-models.ps1 must call ollama pull"
    }
    Write-Host "OK: pull-local-models.ps1 calls ollama pull" -ForegroundColor Green

    $testScript = Get-Content "scripts\jarvis\test-ollama.ps1" -Raw
    if ($testScript -notmatch "api/generate") {
        throw "test-ollama.ps1 must test Ollama generation API"
    }
    Write-Host "OK: test-ollama.ps1 checks Ollama generation API" -ForegroundColor Green

    Write-Host ""
    Write-Host "Git status:" -ForegroundColor Cyan
    git status --short

    Write-Host ""
    Write-Host "Phase 04 verification passed." -ForegroundColor Green
}
finally {
    Pop-Location
}
