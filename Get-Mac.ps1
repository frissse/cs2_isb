$filename = "C:\Users\alex\Documents\scripts\MacTable.csv"

function DeleteLine-Csv($property, $value, $filename) {
    Import-Csv $filename | Where-Object {$_.$property -ne $value } | Export-CSV ($filename + ".new") -force
    Move-Item ($filename + ".new") $filename -Force
}

function Write-Mac() {
    $adapters = Get-NetAdapter | Where-Object { $_.InterfaceDescription -like "*Ethernet*" }
    foreach ($adapter in $adapters) {
        $date = (Get-Date).ToString()
        DeleteLine-Csv mac $adapter.MacAddress $filename
        Add-Content $filename ($date + "," + $adapter.InterfaceDescription + "," + $adapter.MacAddress)
    }
}

function Get-Mac($computername) {
    Write-Host $filename
    Import-Csv $filename | ? { $_.computername -like $computername } 
}

function Clean-Mac($maxtimespan) {
    Import-Csv $filename | Where-Object { (Get-Date) - (Get-Date $_.$date) -le $maxtimespan } | Export-CSV ($filename + ".new")
}

if ($args.count -eq 0) { Write-Mac }
if ($args[0] -eq "-show" -and $args.count -eq 2) {Get-Mac $args[1]}
if ($args[0] -eq "-clean" -and $args.count -eq 2) {Clean-Mac $args[1]}