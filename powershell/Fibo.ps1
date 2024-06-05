param(
    [int]$n
)


try {
    if (-not $n) {
        Write-Host "please provide a value for $n;" -ErrorAction Stop
    }

    if ($n -lt 0) {
        Write-Host "n should be an integer, bigger than 0" -ErrorAction Stop
    } 

    $first = 0
    $second = 1;

    For ($i=0; $i -le $n; $i++) {
    $next = $first + $second;
    Write-Host $next -ErrorAction Stop
    $first = $second
    $second = $next
    }

} catch {
    Write-Host "An error occured" -ForegroundColor Red
    exit 1
}
