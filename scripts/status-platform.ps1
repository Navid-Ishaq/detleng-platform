$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $ProjectRoot
try {
    docker compose ps
    & (Join-Path $PSScriptRoot 'test-routes.ps1')
} finally {
    Pop-Location
}
