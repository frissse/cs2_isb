$file = Get-Content .\filelist.txt

foreach($line in $file) {
    Write-Host `r`n $line 
    Get-Content $line
    
}