$file = Get-Content filelist.txt

function ShowContent($file) {
    foreach ($f in $file) {
        get-Content $f
    }
    
}

ShowContent $file