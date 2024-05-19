$file = Import-Csv .\klassen.csv -Delimiter "," -Header "folder","bestand", "aantal"
[bool] $remove=$false

if ($args -contains "-Remove") {
    $remove = $true
} else {
    $remove = $false
}

function Klas($klas) {
    Write-Host $remove
    if ($remove) {
        
        For ($i=0; $i -le $klas.aantal; $i++) {
            Remove-Item -Path "$($klas.folder)\student$i"
        }
        Remove-Item -Path $klas.folder
    } else {
        New-Item -Path $klas.folder -Type directory
        For ($i=0; $i -le $klas.aantal; $i++) {
            New-Item -Path "$($klas.folder)\student$i" -Type file
        }
    }
    
}


foreach ($line in $file) {
    Klas($line)
}

