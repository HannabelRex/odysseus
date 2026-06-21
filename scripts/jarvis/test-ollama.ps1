param(
    [string]$Model = "llama3.1:8b",
    [string]$Prompt = "Reply in one short sentence: Jarvis local model test successful.",
    [string]$OllamaBaseUrl = "http://127.0.0.1:11434"
)

$ErrorActionPreference = "Stop"

Write-Host "Jarvis Ollama test" -ForegroundColor Cyan
Write-Host "Model: $Model"
Write-Host "Base URL: $OllamaBaseUrl"

$ollamaCommand = Get-Command ollama -ErrorAction SilentlyContinue
if (-not $ollamaCommand) {
    throw "Ollama command not found. Install Ollama, reopen PowerShell, then retry."
}

Write-Host "Ollama CLI detected: $($ollamaCommand.Source)" -ForegroundColor Green

try {
    $tags = Invoke-RestMethod -Method Get -Uri "$OllamaBaseUrl/api/tags" -TimeoutSec 10
}
catch {
    throw "Could not reach Ollama at $OllamaBaseUrl. Start Ollama and retry. Details: $($_.Exception.Message)"
}

$modelNames = @()
if ($tags.models) {
    $modelNames = $tags.models | ForEach-Object { $_.name }
}

Write-Host "Available models:" -ForegroundColor Cyan
if ($modelNames.Count -eq 0) {
    Write-Host "No models found. Run scripts\jarvis\pull-local-models.ps1 first." -ForegroundColor Yellow
}
else {
    $modelNames | ForEach-Object { Write-Host "- $_" }
}

if ($modelNames -notcontains $Model) {
    Write-Host ""
    Write-Host "Requested model '$Model' was not found locally." -ForegroundColor Yellow
    Write-Host "Pull it with: ollama pull $Model" -ForegroundColor Yellow
    throw "Model not available: $Model"
}

$body = @{
    model = $Model
    prompt = $Prompt
    stream = $false
} | ConvertTo-Json

Write-Host ""
Write-Host "Sending test prompt..." -ForegroundColor Cyan

try {
    $response = Invoke-RestMethod -Method Post -Uri "$OllamaBaseUrl/api/generate" -ContentType "application/json" -Body $body -TimeoutSec 120
}
catch {
    throw "Ollama generation request failed. Details: $($_.Exception.Message)"
}

Write-Host ""
Write-Host "Model response:" -ForegroundColor Green
Write-Host $response.response

Write-Host ""
Write-Host "Ollama local model test passed." -ForegroundColor Green
Write-Host "Use this Docker-to-host endpoint in Odysseus settings if Odysseus runs in Docker:" -ForegroundColor Cyan
Write-Host "http://host.docker.internal:11434/v1"
