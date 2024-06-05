$file = 'cyclists.csv'

$csv = Import-Csv $file

function Get-CyclistsByTeamNat($csv, $team, $nat) {
    $csv | Where-Object { $_.Nationality -like $nat -and $_.Team -like $team} | Format-Table -Property Name, Age, Team


}

function FindCountNat($csv, $nat) {
    $groupByNat = $csv | Group-Object -Property Nationality


    $count =  ($groupByNat | Where-Object {$_.Name -eq $nat} | Select-Object -Property Count).Count

    Write-Host "There are $count riders with Nationality $nat"
}

function Get-Teams($csv) {
    return $csv | Select-Object -Property Team -Unique

}

function Sum-Points() {
    Param(
        $cvs,
        [string]$team
    
    )
    $sum=0
    $csv | ForEach-Object {if ($_.Team -like $team) {$sum+= [int]$_.Points}}
    return $sum

}

function Get-BestTeams($csv) {
    $teams = Get-Teams $csv

    [array]$BestTeams = $null

    foreach($team in $teams) {
        $teamObject = [pscustomobject]@{
            Team=$team.Team;
            Score=Sum-Points $csv $team.Team
        }
        $BestTeams+=$teamObject
    }

    Write-Host ($BestTeams | Where-Object {$_.Score -ge 10000}).Count

    $BestTeams | Sort-Object -Property Score -Descending | Select-Object -First 5 
}

#FindCountNat $csv $args[1]
#Get-CyclistsByTeamNat $csv $args[0] $args[1]
Sum-Points $csv -team $args[0]
#Get-Teams $csv

#Get-BestTeams $csv