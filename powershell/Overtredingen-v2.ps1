try {
    $tempovertredingen = Import-Csv .\a_overtredingen.csv
    [array] $overtredingen = $null
    $tempovertredingen | ForEach-Object {$overtredingen += [pscustomobject]@{aantal_overtredingen_roodlicht=[int]$_.aantal_overtredingen_roodlicht;aantal_passanten=[int]$_.aantal_passanten;datum_vaststelling=$_.datum_vaststelling;datum_vaststelling_jaar=[int]$_.datum_vaststelling_jaar;datum_vaststelling_maand=[int]$_.datum_vaststelling_maand;id=[int]$_.id;opnameplaats_straat=$_.opnameplaats_straat }}
}
catch {
    Write-Output "Something went wrong when import the CSV file"
}

function More-Overtredingen($overtredingen, $aantal) {
    $selected_overtredingen = $overtredingen | Where-Object { [int] $_.aantal_overtredingen_roodlicht -ge $aantal }
    return $selected_overtredingen | Select-Object datum_vaststelling, opnameplaats_straat, aantal_passanten, aantal_overtredingen_roodlicht
}

function Get-Streets($overtredingen) {
    return $overtredingen | Select-Object -Property opnameplaats_straat -Unique | % {$_.opnameplaats_straat}
}

function Sum-Overtredingen($overtredingen, $street) {
    $tot_overtredingen=0
    $overtredingen | Where-Object {$_.opnameplaats_straat -eq $street} | % {$tot_overtredingen += $_.aantal_overtredingen_roodlicht}
    return $tot_overtredingen
}

function Alle-Overtredingen($overtredingen) {
    $streets = Get-Streets $overtredingen
    [array] $overzicht = $null
    foreach($street in $streets) {
        $tot = Sum-Overtredingen $overtredingen $street
        $overzicht += [PSCustomObject]@{
            street = $street;
            tot = $tot
        }
        
    }
    return $overzicht | Sort-Object -Property tot -Descending

}

# More-Overtredingen $overtredingen 30 | Out-GridView
# Get-Streets $overtredingen | Out-GridView
# Sum-Overtredingen $overtredingen "PLANTIN_EN_MORETUSLEI"
Alle-Overtredingen $overtredingen