[CmdletBinding()]
param(
    [switch]$SkipAirflow,
    [switch]$SkipDbt
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$EnvPath = Join-Path $ProjectRoot '.env'
$ExampleEnvPath = Join-Path $ProjectRoot '.env.example'

function Import-DotEnv {
    param([string]$Path)
    foreach ($line in Get-Content -LiteralPath $Path) {
        $trimmed = $line.Trim()
        if (-not $trimmed -or $trimmed.StartsWith('#')) { continue }
        $parts = $trimmed.Split('=', 2)
        if ($parts.Count -eq 2) {
            [Environment]::SetEnvironmentVariable($parts[0].Trim(), $parts[1].Trim(), 'Process')
        }
    }
}

function Test-TcpPort {
    param([string]$HostName, [int]$Port)
    $client = [System.Net.Sockets.TcpClient]::new()
    try {
        $connect = $client.ConnectAsync($HostName, $Port)
        return $connect.Wait(800) -and $client.Connected
    } catch { return $false } finally { $client.Dispose() }
}

if (-not (Test-Path -LiteralPath $EnvPath)) {
    Copy-Item -LiteralPath $ExampleEnvPath -Destination $EnvPath
    throw "Created .env from .env.example. Set both CHANGE_ME passwords, then run this script again."
}

Import-DotEnv -Path $EnvPath
if ($env:POSTGRES_PASSWORD -match '^CHANGE_ME' -or $env:PGADMIN_DEFAULT_PASSWORD -match '^CHANGE_ME') {
    throw 'Replace the placeholder PostgreSQL and pgAdmin passwords in .env before startup.'
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw 'Docker was not found in PATH. Start Docker Desktop and reopen the terminal.'
}
docker info *> $null
if ($LASTEXITCODE -ne 0) { throw 'Docker Desktop is installed but is not running.' }

$airflowPort = if ($env:AIRFLOW_PORT) { [int]$env:AIRFLOW_PORT } else { 8080 }
$platformPort = if ($env:PLATFORM_HTTP_PORT) { $env:PLATFORM_HTTP_PORT } else { '8088' }
$platformAddress = if ($env:PLATFORM_ADDRESS -and $env:PLATFORM_ADDRESS -ne ':80') {
    "https://$($env:PLATFORM_ADDRESS)"
} else {
    "http://localhost:$platformPort"
}
$airflowBaseUrl = "$platformAddress/airflow"
$env:AIRFLOW__API__BASE_URL = $airflowBaseUrl
$env:AIRFLOW__CORE__EXECUTION_API_SERVER_URL = "$airflowBaseUrl/execution/"
$env:AIRFLOW__WEBSERVER__BASE_URL = $airflowBaseUrl
$env:AIRFLOW__WEBSERVER__ENABLE_PROXY_FIX = 'True'
$env:FORWARDED_ALLOW_IPS = '*'
if (-not $SkipAirflow -and -not (Test-TcpPort -HostName '127.0.0.1' -Port $airflowPort)) {
    $airflowName = if ($env:AIRFLOW_COMMAND) { $env:AIRFLOW_COMMAND } else { 'airflow' }
    $airflow = Get-Command $airflowName -ErrorAction SilentlyContinue
    if (-not $airflow) {
        throw "Airflow is not listening on port $airflowPort and '$airflowName' could not be found. Set AIRFLOW_COMMAND or start the existing Airflow webserver, then rerun."
    }
    $runtime = Join-Path $ProjectRoot 'runtime'
    New-Item -ItemType Directory -Force -Path $runtime | Out-Null
    Start-Process -FilePath $airflow.Source -ArgumentList 'standalone' -WindowStyle Hidden -RedirectStandardOutput (Join-Path $runtime 'airflow.out.log') -RedirectStandardError (Join-Path $runtime 'airflow.err.log')
    $ready = $false
    foreach ($attempt in 1..45) {
        Start-Sleep -Seconds 1
        if (Test-TcpPort -HostName '127.0.0.1' -Port $airflowPort) { $ready = $true; break }
    }
    if (-not $ready) { throw "Airflow did not become ready. Check runtime/airflow.err.log." }
}

if (-not $SkipDbt) {
    & (Join-Path $PSScriptRoot 'generate-dbt-docs.ps1')
}

Push-Location $ProjectRoot
try {
    docker compose up -d
    if ($LASTEXITCODE -ne 0) { throw 'Docker Compose startup failed.' }
} finally { Pop-Location }

Write-Host "DeTLeng Platform: http://localhost:$platformPort"
Write-Host "Airflow:          http://localhost:$platformPort/airflow/"
Write-Host "PostgreSQL:       http://localhost:$platformPort/postgresql/"
Write-Host "dbt:              http://localhost:$platformPort/dbt/"
