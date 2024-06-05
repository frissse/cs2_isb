$file = 'MacTable.csv'
$csv = Import-Csv $file -Delimiter ","


function Delete-LinesCSV($property,$value) {
    $csv = $csv | Where-Object {$_.$property -ne $value }
    $csv | Export-Csv -Path $'MacTable.csv' -Force -NoTypeInformation
}

function Write-Mac() {
    $addresses = Get-NetAdapter | Select-Object -Property InterfaceDescription,MacAddress
    $computername = (hostname).ToString()
    $date = (Get-Date -Format "f")
    foreach ($a in $addresses) {
        $adapter = $a.InterfaceDescription
        $address = $a.MacAddress
        $addrObject = [pscustomobject]@{
            date=$date;
            computername=$computername
            adaptername=$adapter;
            mac=$address
        }
        $addrObject | Export-Csv -Path 'MacTable.csv' -NoTypeInformation -Append
    }
}

function Get-Mac($csv, $argument) {
    return $csv | Where-Object {$_.computername -like $argument}
}

function Clear-Mac($csv, $maxdate) {
    $maxdata = [int]$maxdata
    $today = Get-Date

    
    $filtereddata = $csv | Where-Object {(New-TimeSpan -Start (Get-Date $_.date) -End $today).Days -le $maxdata}
    
    $filtereddata | Export-Csv -Path 'MacTable.csv' -Force -NoTypeInformation
}

Clear-Mac $csv $args[0]