$file = 'cyclists.csv'

try {
    $cyclelist = Import-Csv $file

} catch {
    Write-Host "Something went wrong when import the file "

}

function Get-CyclistsByTeamNat($csv, $team, $nat) {
    [array]$CyclistsByTeamAndNAt= $null

    foreach($c in $csv) {
        if ($c.Team -like $team) {
            if ($c.Nationality -eq $nat) {
                $CyclistsByTeamAndNAt+=$c
            }
        }
    }
    return $CyclistsByTeamAndNAt | Select-Object -Property Name, Team, Nationality
}

function Count-CyclistsByTeamNat($csv, $team, $nat) {
    $result = (Get-CyclistsByTeamNat $csv $team $nat | Measure-Object).Count
    return $result
}

function Get-Teams($csv) {
    return $csv | Select-Object -Property Team -unique

}

function Clean-Teams($csv) {
    return $csv | Where-Object {$_.Team -ne ""}

}

function Count-CyclistsByNat($csv, $nat) {
    return ($csv | Where-Object {$_.Nationality -eq $nat} | Measure-Object).Count

}

function Sum-Score($csv, $team) {
    $sum=0
    $csv | ForEach-Object {if ($_.Team -like $team) {$sum+= [int]$_.Points}}
    return $sum

}

function Score-Teams($csv) {
    $teams = Get-Teams $csv

    [array]$BestTeams = $null

    foreach($team in $teams) {
        $teamObject = [pscustomobject]@{
            Team=$team.Team;
            Score=Sum-Score $csv $team.Team
        }
        $BestTeams+=$teamObject
    }

    # Write-Host ($BestTeams | Where-Object {$_.Score -ge 10000}).Count

    $BestTeams | Sort-Object -Property Score -Descending | Select-Object -First 5 
}

$nationality = "BE"
$team = "Soudal*"

# Get-CyclistsByTeamNat $cyclelist $team $nationality | Out-GridView
# Count-CyclistsByTeamNat $cyclelist $team $nationality
# Get-Teams $cyclelist | Out-GridView
#Get-Teams (Clean-Teams $cyclelist) | Out-GridView
# $cyclelist = Clean-Teams $cyclelist
# Count-CyclistsByNat $cyclelist $nationality
# Sum-Score $cyclelist $team
Score-Teams $cyclelist | Out-GridView