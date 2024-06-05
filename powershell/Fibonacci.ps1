#########################
# file: Fibonacci.ps1
# author: Alexander Waumans
# version: 1.0
#########################
<#
.SYNOPSIS
toon n eerste fibonacci nummers
.DESCRIPTION
n komt van het inlezen van de input van de gebruiker
script toont vervolgens de n eerste fibonacci cijfers
.EXAMPLE
PS>Maak-Som 3 4
3 + 4 = 7
#>

$n = Read-Host "Geef een nummer"


if ($n -eq 0) {
    Write-Host "invalid input"
}

if ($n -eq 1) {
    Write-Host $n
}

$a = 0
$b = 1

for ($i = 2l; $i -le $n;$i++) {
    $temp = $a + $b
    $a = $b
    $b = $temp
    Write-Host $b
}