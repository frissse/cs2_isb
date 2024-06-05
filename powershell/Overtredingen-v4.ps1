$file = 'a_overtredingen.csv'

try {
    $csv = import-csv $file -Delimiter ","
}
catch {

}

function More-Overtredingen($csv, $aantal) {
    $result = $csv | Where-Object {$_.aantal_overtredingen_roodlicht -ge $aantal}
    $result | Select-Object datum_vaststelling, opnameplaats_straat, aantal_passanten,aantal_overtredingen_roodlicht
    return $result
}

function Get-Streets($csv) {
    $streets = $csv | Select-Object -Property opnameplaats_straat -Unique
    return $streets
}

function Sum-Overtredingen($csv, $straat) {
    $count=0
    $csv | foreach-Object {if ($_.opnameplaats_straat -eq "$straat"){ $count+=[int]$_.aantal_overtredingen_roodlicht}}
    return $count
}

function All-Overtredingen($overtredingen) {
    $streets = Get-Streets $csv
    $overtredingenPerStreet = [System.Collections.ArrayList]::new()
    
    foreach ($street in $streets) {
        $sumOfStreet = Sum-Overtredingen $csv $street.opnameplaats_straat
        $streetObject = [pscustomobject]@{
            Street= $street.opnameplaats_straat;
            Sum= $sumOfStreet
        }
        $overtredingenPerStreet.Add($streetObject)
    }

    return $overtredingenPerStreet | Sort-Object -Property Sum -Descending

}

All-Overtredingen $csv