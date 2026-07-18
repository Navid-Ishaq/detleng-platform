[CmdletBinding()]
param([switch]$RemoveData)

$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $ProjectRoot
try {
    if ($RemoveData) {
        docker compose down --volumes --remove-orphans
    } else {
        docker compose down --remove-orphans
    }
} finally {
    Pop-Location
}
