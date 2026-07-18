[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$EnvPath = Join-Path $ProjectRoot '.env'

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

if (-not (Test-Path -LiteralPath $EnvPath)) { throw 'Create .env from .env.example first.' }
Import-DotEnv -Path $EnvPath

$dbtName = if ($env:DBT_COMMAND) { $env:DBT_COMMAND } else { 'dbt' }
$dbt = Get-Command $dbtName -ErrorAction SilentlyContinue
if (-not $dbt) { throw "The existing dbt executable '$dbtName' could not be found. Set DBT_COMMAND in .env." }

$dbtProject = if ($env:DBT_PROJECT_DIR) { $env:DBT_PROJECT_DIR } else { Join-Path $ProjectRoot 'backend\dbt\project' }
$dbtProfiles = if ($env:DBT_PROFILES_DIR) { $env:DBT_PROFILES_DIR } else { Join-Path $ProjectRoot 'backend\dbt\project' }
if (-not (Test-Path -LiteralPath (Join-Path $dbtProject 'dbt_project.yml'))) { throw "No dbt_project.yml found in $dbtProject" }

if ($env:DBT_POSTGRES_HOST) { $env:POSTGRES_HOST = $env:DBT_POSTGRES_HOST }
& $dbt.Source docs generate --project-dir $dbtProject --profiles-dir $dbtProfiles
if ($LASTEXITCODE -ne 0) { throw 'dbt docs generation failed.' }

$target = Join-Path $dbtProject 'target'
if (-not (Test-Path -LiteralPath (Join-Path $target 'index.html'))) { throw 'dbt did not generate target/index.html.' }

$site = Join-Path $ProjectRoot 'backend\dbt\site'
$staging = Join-Path $ProjectRoot 'runtime\dbt-site-staging'
if (Test-Path -LiteralPath $staging) { Remove-Item -LiteralPath $staging -Recurse -Force }
New-Item -ItemType Directory -Force -Path $staging | Out-Null
Copy-Item -Path (Join-Path $target '*') -Destination $staging -Recurse -Force
Get-ChildItem -LiteralPath $site -Force | Where-Object Name -ne '.gitkeep' | Remove-Item -Recurse -Force
Copy-Item -Path (Join-Path $staging '*') -Destination $site -Recurse -Force
Remove-Item -LiteralPath $staging -Recurse -Force
Write-Host "dbt documentation generated at $site"
