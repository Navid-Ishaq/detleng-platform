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
if (-not $SkipAirflow -and -not (Test-TcpPort -HostName '127.0.0.1' -Port $airflowPort)) {
    $airflowName = if ($env:AIRFLOW_COMMAND) { $env:AIRFLOW_COMMAND } else { 'airflow' }
    $airflow = Get-Command $airflowName -ErrorAction SilentlyContinue
    if (-not $airflow) {
        throw "Airflow is not listening on port $airflowPort and '$airflowName' could not be found. Set AIRFLOW_COMMAND or start the existing Airflow webserver, then rerun."
    }
    $env:AIRFLOW__WEBSERVER__BASE_URL = "http://localhost:$($env:PLATFORM_HTTP_PORT)/airflow"
    $env:AIRFLOW__WEBSERVER__ENABLE_PROXY_FIX = 'True'
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
    $dbtName = if ($env:DBT_COMMAND) { $env:DBT_COMMAND } else { 'dbt' }
    $dbt = Get-Command $dbtName -ErrorAction SilentlyContinue
    if (-not $dbt) { throw "The existing dbt executable '$dbtName' could not be found. Set DBT_COMMAND in .env." }
    $dbtProject = if ($env:DBT_PROJECT_DIR) { $env:DBT_PROJECT_DIR } else { Join-Path $ProjectRoot 'backend\dbt\project' }
    $dbtProfiles = if ($env:DBT_PROFILES_DIR) { $env:DBT_PROFILES_DIR } else { Join-Path $ProjectRoot 'backend\dbt\project' }
    if (-not (Test-Path -LiteralPath (Join-Path $dbtProject 'dbt_project.yml'))) { throw "No dbt_project.yml found in $dbtProject" }
    & $dbt.Source docs generate --project-dir $dbtProject --profiles-dir $dbtProfiles
    if ($LASTEXITCODE -ne 0) { throw 'dbt docs generation failed.' }
    $site = Join-Path $ProjectRoot 'backend\dbt\site'
    Get-ChildItem -LiteralPath $site -Force | Where-Object Name -ne '.gitkeep' | Remove-Item -Recurse -Force
    Copy-Item -Path (Join-Path $dbtProject 'target\*') -Destination $site -Recurse -Force
    if (-not (Test-Path -LiteralPath (Join-Path $site 'index.html'))) { throw 'dbt did not generate target/index.html.' }
}

Push-Location $ProjectRoot
try {
    docker compose up -d
    if ($LASTEXITCODE -ne 0) { throw 'Docker Compose startup failed.' }
} finally { Pop-Location }

$platformPort = if ($env:PLATFORM_HTTP_PORT) { $env:PLATFORM_HTTP_PORT } else { '8088' }
Write-Host "DeTLeng Platform: http://localhost:$platformPort"
Write-Host "Airflow:          http://localhost:$platformPort/airflow/"
Write-Host "PostgreSQL:       http://localhost:$platformPort/postgresql/"
Write-Host "dbt:              http://localhost:$platformPort/dbt/"
