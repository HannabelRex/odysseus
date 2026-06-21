param(
    [string]$Model = "llama3.2:3b",
    [string]$Prompt = "Say hello in one short sentence.",
    [string]$OllamaBaseUrl = "http://127.0.0.1:11434",
    [int]$TimeoutSec = 300,
    [int]$NumPredict = 32,
    [switch]$ShowRaw
)

$ErrorActionPreference = "Stop"

function Format-NanoSeconds {
    param([object]$Value)

    if ($null -eq $Value) {
        return "n/a"
    }

    try {
        $seconds = [double]$Value / 1000000000
        return ("{0:N2}s" -f $seconds)
    } catch {
        return "n/a"
    }
}

Write-Host "Jarvis Ollama test" -ForegroundColor Cyan
Write-Host "Model: $Model"
Write-Host "Base URL: $OllamaBaseUrl"
Write-Host "Timeout: $TimeoutSec seconds"
Write-Host "Max generated tokens: $NumPredict"

$ollamaCommand = Get-Command ollama -ErrorAction SilentlyContinue
if (-not $ollamaCommand) {
    throw "Ollama command not found. Install Ollama, reopen PowerShell, then retry."
}

Write-Host "Ollama CLI detected: $($ollamaCommand.Source)" -ForegroundColor Green

try {
    $tags = Invoke-RestMethod -Method Get -Uri "$OllamaBaseUrl/api/tags" -TimeoutSec 20
} catch {
    Write-Host "Could not reach Ollama at $OllamaBaseUrl." -ForegroundColor Red
    Write-Host "Try these checks:" -ForegroundColor Yellow
    Write-Host "1. Start Ollama from the Windows Start Menu."
    Write-Host "2. Run: ollama list"
    Write-Host "3. Run: Invoke-RestMethod http://127.0.0.1:11434/api/tags"
    throw "Ollama API is not reachable. Details: $($_.Exception.Message)"
}

$modelNames = @()
if ($tags.models) {
    $modelNames = $tags.models | ForEach-Object { $_.name }
}

Write-Host "Available models:" -ForegroundColor Cyan
if ($modelNames.Count -eq 0) {
    Write-Host "No models found. Run scripts\jarvis\pull-local-models.ps1 first." -ForegroundColor Yellow
} else {
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
    options = @{
        num_predict = $NumPredict
        temperature = 0.1
    }
} | ConvertTo-Json -Depth 5

Write-Host "" 
Write-Host "Sending test prompt..." -ForegroundColor Cyan
Write-Host "Prompt: $Prompt"

try {
    $response = Invoke-RestMethod `
        -Method Post `
        -Uri "$OllamaBaseUrl/api/generate" `
        -ContentType "application/json" `
        -Body $body `
        -TimeoutSec $TimeoutSec
} catch {
    Write-Host "" 
    Write-Host "Ollama generation request failed." -ForegroundColor Red
    Write-Host "This usually means the model is still loading, the model is too large for the machine, or the timeout is too short." -ForegroundColor Yellow
    Write-Host "Beginner-friendly recovery steps:" -ForegroundColor Cyan
    Write-Host "1. Test the smallest model first:"
    Write-Host "   powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\test-ollama.ps1 -Model 'llama3.2:3b' -TimeoutSec 300"
    Write-Host "2. If testing llama3.1:8b or qwen2.5-coder:7b, allow more time:"
    Write-Host "   powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\test-ollama.ps1 -Model '$Model' -TimeoutSec 600 -NumPredict 24"
    Write-Host "3. Check loaded models:"
    Write-Host "   ollama ps"
    Write-Host "4. Restart Ollama if you see repeated 500 errors."
    throw "Ollama generation request failed. Details: $($_.Exception.Message)"
}

Write-Host "" 
Write-Host "Model response:" -ForegroundColor Green
Write-Host $response.response

Write-Host "" 
Write-Host "Runtime details:" -ForegroundColor Cyan
Write-Host "Total duration: $(Format-NanoSeconds $response.total_duration)"
Write-Host "Load duration:  $(Format-NanoSeconds $response.load_duration)"
Write-Host "Prompt tokens:  $($response.prompt_eval_count)"
Write-Host "Output tokens:  $($response.eval_count)"

if ($ShowRaw) {
    Write-Host "" 
    Write-Host "Raw response:" -ForegroundColor Cyan
    $response | ConvertTo-Json -Depth 10
}

Write-Host "" 
Write-Host "Ollama local model test passed." -ForegroundColor Green
Write-Host "Recommended first Odysseus model: llama3.2:3b" -ForegroundColor Cyan
Write-Host "Use this Docker-to-host endpoint in Odysseus settings if Odysseus runs in Docker:" -ForegroundColor Cyan
Write-Host "http://host.docker.internal:11434/v1"
