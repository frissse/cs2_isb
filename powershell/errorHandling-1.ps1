try {
    $c = Get-Content -Path C:\nonexistingfile.txt -ErrorAction stop
}
catch {
    Write-Host "File does not exist" -ForegroundColor Red
    exit 1 # geeft exit code 1 -> $? is $false
}