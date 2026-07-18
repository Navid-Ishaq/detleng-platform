[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $ProjectRoot
try {
    docker compose build dbt-docs
    if ($LASTEXITCODE -ne 0) { throw 'dbt image build failed.' }
    docker compose run --rm dbt-docs generate-only
    if ($LASTEXITCODE -ne 0) { throw 'dbt documentation generation failed.' }
    if (-not (Test-Path -LiteralPath (Join-Path $ProjectRoot 'backend\dbt\site\index.html'))) {
        throw 'dbt completed without publishing backend/dbt/site/index.html.'
    }
} finally {
    Pop-Location
}

Write-Host 'dbt documentation regenerated and published at http://localhost:8088/dbt/'
