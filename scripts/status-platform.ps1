$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $ProjectRoot
try {
    docker compose ps
    $envPath = Join-Path $ProjectRoot '.env'
    $port = 8088
    if (Test-Path -LiteralPath $envPath) {
        $match = Get-Content -LiteralPath $envPath | Where-Object { $_ -match '^PLATFORM_HTTP_PORT=' } | Select-Object -First 1
        if ($match) { $port = [int]($match.Split('=', 2)[1]) }
    }
    Invoke-RestMethod -Uri "http://localhost:$port/healthz" | Format-List
} finally { Pop-Location }
