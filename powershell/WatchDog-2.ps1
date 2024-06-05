#########################
# file: WatchDog-2
# author: Alexander Waumans
# version: 1.0
#########################

<#
.SYNOPSIS
MCheck if program is running
.DESCRIPTION
Check if a program is running, if not it is started
.EXAMPLE
PS>Wathc-dog Notepad
"Notepad is running"
#>

$prog = $args[0]


while ($true) {
    $process = Get-Process $prog -ErrorAction SilentlyContinue
    if ($process) {
        Write-Host "$prog is running"
    } else {
        Write-Host "starting $prog"   
        & $prog
    }

    Start-Sleep -Seconds 10
}