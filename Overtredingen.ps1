param (
    [int]$aantal,
    [string]$straat
)

$overtredingen = Import-Csv .\a_overtredingen.csv
[array] $edited_overtredingen = $null
$overtredingen | ForEach-Object {$edited_overtredingen += [pscustomobject]@{aantal_overtredingen_roodlicht=[int]$_.aantal_overtredingen_roodlicht;aantal_passanten=[int]$_.aantal_passanten;datum_vaststelling=$_.datum_vaststelling;datum_vaststelling_jaar=[int]$_.datum_vaststelling_jaar;datum_vaststelling_maand=[int]$_.datum_vaststelling_maand;id=[int]$_.id;opnameplaats_straat=$_.opnameplaats_straat }}

function MeerDan-Overtredingen {

    param(
        [int]$aantal
    )

    foreach ($row in $edited_overtredingen) {
        $aantal_row = $row.aantal_overtredingen_roodlicht

        if ($aantal_row -gt $aantal) {
            $return_values = [PSCustomObject]@{
                datum_vaststelling = $row.datum_vaststelling;
                opnameplaats_straat = $row.opnameplaats_straat;
                aantal_passanten = $row.aantal_passanten;
                aantal_overtredingen_roodlicht = $row.aantal_overtredingen_roodlicht
            }
            Write-Output $return_values
        }
    }

}

function UniqueStreet {
    $edited_overtredingen | Select-Object -ExpandProperty opnameplaats_straat -Unique
}

function Sum-Overtredingen {
    param (
        [string]$straat
    )
    $sum=0
    foreach ($row in $edited_overtredingen) {
        if ($row.opnameplaats_straat -eq $straat) {
            $sum+=$row.aantal_overtredingen_roodlicht
        }
    }

    Write-Output "Aantal overtredingen in $straat : $sum"
}

function Alle-Overtredingen {
    $grouped_overtredingen = $edited_overtredingen | Group-Object -Property opnameplaats_straat 

    foreach ($group in $grouped_overtredingen) {
        $straat = $group.Name
        $sum = ($group.Group | Measure-Object -Property aantal_overtredingen_roodlicht -Sum).Sum
        Write-Output "Straat: $straat, Total Amount: $sum"
    }
}


# MeerDan-Overtredingen -aantal $aantal
# UniqueStreet
# Sum-Overtredingen -straat $straat
Alle-Overtredingen