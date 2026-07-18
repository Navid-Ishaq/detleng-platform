[CmdletBinding()]
param(
    [switch]$NoBuild,
    [switch]$SkipRouteTests
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$EnvPath = Join-Path $ProjectRoot '.env'
$ExampleEnvPath = Join-Path $ProjectRoot '.env.example'

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw 'Docker Desktop with Docker Compose v2 is required and was not found in PATH.'
}

docker info *> $null
if ($LASTEXITCODE -ne 0) { throw 'Docker Desktop is installed but is not running.' }

if (-not (Test-Path -LiteralPath $EnvPath)) {
    Copy-Item -LiteralPath $ExampleEnvPath -Destination $EnvPath
    Write-Host 'Created .env with local-development defaults.'
}

Push-Location $ProjectRoot
try {
    if (-not $NoBuild) {
        docker compose build
        if ($LASTEXITCODE -ne 0) { throw 'Docker image build failed.' }
    }

    docker compose up -d
    if ($LASTEXITCODE -ne 0) { throw 'Docker Compose startup failed.' }

    Write-Host 'Waiting for all module routes to become ready...'
    if (-not $SkipRouteTests) {
        & (Join-Path $PSScriptRoot 'test-routes.ps1') -Retries 36 -DelaySeconds 5
    }
} finally {
    Pop-Location
}

Write-Host ''
Write-Host 'DeTLeng Platform is ready:'
Write-Host '  Platform:   http://localhost:8088/'
Write-Host '  Dashboard:  http://localhost:8088/dashboard.html'
Write-Host '  Airflow:    http://localhost:8088/airflow/'
Write-Host '  PostgreSQL: http://localhost:8088/postgresql/'
Write-Host '  dbt docs:   http://localhost:8088/dbt/'
Write-Host ''
Write-Host 'Trigger DAG detleng_dataset_to_analytics in Airflow to run the sample ETL workflow.'
Write-Host 'pgAdmin login defaults are stored in .env. PostgreSQL server password is POSTGRES_PASSWORD.'
