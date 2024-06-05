$file = 'klassen.csv'
$customHeaders = @('Path', 'Name', 'Amount')
$csv = Import-Csv -Path $file -Header $customHeaders -Delimiter ","

function Klas($klas) {
    for($i=0; $i -le $klas.Amount;$i++) {
      $fullPath = $klas.Path+"\"+ $klas.Name + $i
      New-Item -Path $fullPath -ItemType File -Force
    }

}

function Remove-Klas($klas) {
    for($i=0; $i -le $klas.Amount;$i++) {
      $fullPath = $klas.Path+"\"+ $klas.Name + $i
      Remove-Item -Path $fullPath -Force
    }
    
}

if ($args[0] -eq "-Remove") {
    foreach($line in $csv) {
        Remove-Klas($line)    
    }

} else {
    foreach($line in $csv) {
        Klas($line)    
    }

}



