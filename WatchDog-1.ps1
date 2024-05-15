param (
    [string]$programName
)

if ($args -contains "-Help"){
    Write-Host "help"
}


while ($true) {
    $process = Get-Process $programName -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq $programName }

    if ($process) {
        Write-Host "program is running"
    } else {
        Start-Process $programName
        Write-Host "Program started"
    }
    Start-Sleep -Seconds 2
}

