$file = 'menu.csv'
$csv = Import-Csv -Header "Nbr","Name" menu.csv

$choice = 0

foreach($line in $csv) {
    Write-Host $line.Nbr " :" $line.Name 
    
}
do{
    $choice = Read-Host "Maak een keuze"
    $executeProgram = $csv | Where-Object {$_.Nbr -eq $choice} | Select-Object -Property Name
    if ($executeProgram.Name -eq "Stoppen") {
        exit
    } else {
        &($executeProgram.Name)
    }
    
} while ($choice -ne 4)

