$file = "C:\Users\alex\Documents\scripts\MacTable.csv"

try {
    $csv = Import-Csv $file -Delimiter ","

} catch {
    Write-Host "Something went wrong"

}

function Delete-LinesCsv($csv, $property, $value) {
    $newcsv = $csv | Where-Object {$_.$property -ne $value}
    $newcsv | Export-Csv -Path "MacTable.csv" -Force -NoTypeInformation

}

function Write-Mac($csv) {
    $mac = Get-NetAdapter | Select-Object InterfaceDescription,MacAddress
    $computername = (hostname).ToString()
    $date = (Get-Date).ToShortDateString()

    $addressObject = [pscustomobject]@{
        date = $date
        computername = $computername
        adaptername = ($mac | Select-Object InterfaceDescription).InterfaceDescription
        mac = ($mac | Select-Object MacAddress).MacAddress
    }

    Delete-LinesCsv $csv mac $addressObject.mac

    $addressObject | Export-Csv -Path $file -NoTypeInformation -Append

}

function Get-Mac($csv, $argument) {

    $csv | Where-Object {$_.computername -like $argument}

}

function Clean-Mac($csv, $maxdate) {
    $today = Get-Date

    $csv | Foreach-Object {Write-Host Get-Date $_.date $maxdate}
    
    #$filtereddata = $csv | Where-Object {(New-TimeSpan -Start (Get-Date $_.date) -End $today).Days -le $maxdate} 

    #$filtereddata | Export-Csv -Path "MacTable.csv" -Force -NoTypeInformation 
}

if ($args.Count -eq 0) {
    Write-Mac $csv

}
if ($args[0] -eq "-show") {
    Get-Mac $csv $args[1]
}
if ($args[0] -eq "-clean") {
    Clean-Mac $csv $args[1]

}

