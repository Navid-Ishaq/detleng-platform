[CmdletBinding()]
param(
    [string]$BaseUrl = 'http://localhost:8088',
    [int]$Retries = 1,
    [int]$DelaySeconds = 2
)

$ErrorActionPreference = 'Stop'
$routes = @(
    @{ Name = 'Gateway'; Path = '/healthz'; Status = @(200) },
    @{ Name = 'Airflow'; Path = '/airflow/'; Status = @(200, 302, 307) },
    @{ Name = 'PostgreSQL/pgAdmin'; Path = '/postgresql/'; Status = @(200, 302) },
    @{ Name = 'dbt docs'; Path = '/dbt/'; Status = @(200) }
)

for ($attempt = 1; $attempt -le $Retries; $attempt++) {
    $results = foreach ($route in $routes) {
        try {
            $response = Invoke-WebRequest -Uri "$BaseUrl$($route.Path)" -MaximumRedirection 0 -SkipHttpErrorCheck -TimeoutSec 10
            $status = [int]$response.StatusCode
            [pscustomobject]@{
                Module = $route.Name
                Status = $status
                Pass = $status -in $route.Status
                Location = [string]$response.Headers.Location
            }
        } catch {
            [pscustomobject]@{ Module = $route.Name; Status = 'ERROR'; Pass = $false; Location = $_.Exception.Message }
        }
    }

    if ($results.Pass -notcontains $false) {
        $results | Format-Table -AutoSize
        Write-Host 'All platform routes are operational.'
        exit 0
    }

    if ($attempt -lt $Retries) { Start-Sleep -Seconds $DelaySeconds }
}

$results | Format-Table -AutoSize
throw 'One or more platform routes failed. Run docker compose ps and docker compose logs for details.'
