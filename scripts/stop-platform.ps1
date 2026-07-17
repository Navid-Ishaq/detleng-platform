$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $ProjectRoot
try { docker compose down } finally { Pop-Location }
