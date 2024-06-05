$file = "klassen.csv"
$csv = Import-Csv $file -Delimiter "," -Header "Path","Name","Amount"

function Klas($klas) {
    New-Item -ItemType directory $klas.Path
    foreach ($i in 1..$klas.Amount) {
        $filename = $klas.path + "/" + $klas.name + $i
        New-Item -ItemType file -Path $filename
    }
}


function Delete-Files($csv) { 
    foreach ($row in $csv) {
        Remove-Item $row.Path -recurse
    }
}



if ($args[0] -eq "-Remove" -and $args.count -eq 1) {
    Delete-Files $csv
} else {
    foreach ($row in $csv) {
    Klas($row)
    }
}