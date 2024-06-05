$file = "menu.csv"
$csv = Import-Csv $file -Delimiter "," -Header "Nbr","Name"

function Toon-Menu ($csv) {
    
    foreach ($row in $csv) {
        Write-Host $row.Nbr ":" $row.Name
    }
    
    $nr = Read-Host "Kies een nummer: "

    $variable = "Value1"

    switch ($nr) {
        "1" { & "calc" }
        "2" { & "notepad" }
        "3" { & "MSPaint" }
        "4" { Write-Host "quiting.."; exit }
        default { Write-Output "No match found" }
    }

}

Toon-Menu $csv