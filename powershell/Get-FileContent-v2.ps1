$file = Get-Content filelist.txt

function Show-Content($file) {
    foreach($line in $file) {
        Get-Content $line
        
    }

}

function Show-Content-For($file) {
    $lineCount = ($file | Measure-Object -Line).Count
    
    for($i=0;$i -le $lineCount;$i++){
        Get-Content $file[$i]
    }

}

Show-Content-For $file