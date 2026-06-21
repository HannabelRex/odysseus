param(
    [string[]]$Models = @(
        "llama3.1:8b",
        "qwen2.5-coder:7b",
        "mistral",
        "nomic-embed-text"
    )
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis local model pull helper" -ForegroundColor Cyan

$ollamaCommand = Get-Command ollama -ErrorAction SilentlyContinue
if (-not $ollamaCommand) {
    throw "Ollama command not found. Install Ollama, reopen PowerShell, then retry."
}

Write-Host "Ollama detected: $($ollamaCommand.Source)"
Write-Host "Models to pull:" -ForegroundColor Cyan
$Models | ForEach-Object { Write-Host "- $_" }

foreach ($model in $Models) {
    Write-Host ""
    Write-Host "Pulling $model ..." -ForegroundColor Cyan
    ollama pull $model
}

Write-Host ""
Write-Host "Installed models:" -ForegroundColor Green
ollama list

Write-Host ""
Write-Host "Local model pull complete." -ForegroundColor Green
