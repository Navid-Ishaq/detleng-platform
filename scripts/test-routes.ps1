[CmdletBinding()]
param([string]$BaseUrl = 'http://localhost:8088')

$ErrorActionPreference = 'Stop'
$results = @()

function Test-Route {
    param([string]$Name, [string]$Path, [int[]]$ExpectedStatus)
    try {
        $response = Invoke-WebRequest -Uri "$BaseUrl$Path" -MaximumRedirection 0 -SkipHttpErrorCheck -TimeoutSec 10
        $status = [int]$response.StatusCode
        $results += [pscustomobject]@{ Name = $Name; Status = $status; Pass = $status -in $ExpectedStatus; Location = [string]$response.Headers.Location }
    } catch {
        $results += [pscustomobject]@{ Name = $Name; Status = 'ERROR'; Pass = $false; Location = $_.Exception.Message }
    }
    Set-Variable -Name results -Value $results -Scope 1
}

Test-Route -Name 'Gateway' -Path '/healthz' -ExpectedStatus 200
Test-Route -Name 'Airflow' -Path '/airflow/' -ExpectedStatus @(200, 302, 307)
Test-Route -Name 'PostgreSQL/pgAdmin' -Path '/postgresql/' -ExpectedStatus @(200, 302)
Test-Route -Name 'dbt docs' -Path '/dbt/' -ExpectedStatus 200

$results | Format-Table -AutoSize
if ($results.Pass -contains $false) { throw 'One or more platform routes failed.' }
