$program = $args[0]
do {     
        $running = (Get-Process | Where-Object {$_.ProcessName -eq $program}).ProcessName
        $count = (Get-Process | Where-Object {$_.ProcessName -eq "notepad"} | Measure-Object).Count

        Write-Host $count

        if ($running -eq $program -and $count -eq 1) {
            Write-Host "Program is Running"
        } elseif ($count -lt 1) {
            Write-Host "Starting process: $program"
            &$program
        } elseif ($count -gt 1) {
            Write-Host "Killing processes"
            Get-Process $program | ForEach-Object {$_.kill()}
        
        }

        Start-Sleep -Seconds 10

} while ($true)