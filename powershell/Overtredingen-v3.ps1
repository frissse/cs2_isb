$file = 'a_overtredingen.csv'

try {
 $tempovertredingen = Import-Csv $file -Delimiter ","
 $overtredingen = @()
 $tempovertredingen | ForEach-Object {$overtredingen += [pscustomobject]@{
    datum_vaststelling=$_.datum_vaststelling;
    opnameplaats_straat=$_.opnameplaats_straat;
    aantal_passanten=[int]$_.aantal_passanten; 
    aantal_overtredingen_roodlicht=[int]$_.aantal_overtredingen_roodlicht }}

} catch {

    Write-Host "Something went wrong import the csv file"

}

function More-Overtredingen($overtredingen,$aantal) {
    $overtredingen | Where-Object {$_.aantal_overtredingen_roodlicht -ge $aantal} | Select-Object -Property datum_vaststelling, opnameplaats_straat, aantal_overtredingen_roodlicht
    
}

function Get-Streets($overtredingen) {
    $overtredingen | Select-Object opnameplaats_straat -Unique

}

function Sum-Overtredingen($overtredingen, $straat) {
    $tot_overtredingen = 0
    $overtredingen | Where-Object {$_.opnameplaats_straat -eq $straat} | ForEach-Object {$tot_overtredingen += $_.aantal_overtredingen_roodlicht }
    Write-Host "Totale overtredingen in $straat : $tot_overtredingen"
    
}

if ($args[0] -match '^-?\d+$') {
    More-Overtredingen $overtredingen $args[0]

} else {
    Sum-Overtredingen $overtredingen $args[0]

}