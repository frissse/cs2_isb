# Name: Get-Cycling.ps1
# Author: Nemo Van den Eynde
# Date: 20/06/2023

Param(
  [string]$file=".\UCICyclists.csv"
  )
  
try {
$cyclelist = Import-Csv -path $file -ErrorAction stop
}
catch {
    Write-Host "Exception:" -ForegroundColor Red
    $_.Exeption.GetType().FullName
    $_.Exeption.Message
}



function Get-CyclistsByTeamNat($cyclelist, $team, $nationality) {
  [Array]$cyclelistBTN = $null
  #$cyclelist.Contains($team) #| Select-Object -Property "team","Nationality"
  foreach($cyclist in $cyclelist){
    if($cyclist.team -like $team){
        if($cyclist.nationality -like $nationality){
        $cyclelistBTN+=$cyclist
        }
    }
  }

  return $cyclelistBTN | Select-Object -Property name,points
  }
  #come back to
function Count-CyclistsByTeamNat($cyclelist, $team, $nationality) {
  $toCount = Get-CyclistsByTeamNat($cyclelist, $team, $nationality)
  $count = 0
  foreach ($item in $toCount){
    $count++
  }
  return $count
  }

function Get-Teams($cyclelist) {
  $teams =  $cyclelist | Select-Object -Property team -Unique
  return $teams
  }

function Clean-Teams($cyclelist) {
    for($i = 0;$i -lt $cyclelist.Length; $i++){
        if($cyclelist[$i].team.Trim() -like ""){
            $cyclelist[$i].team = $cyclelist[$i-1].team
        }
    }
    return $cyclelist
  }

function Count-CyclistsByNat($cyclelist, $nationality) {
  $team = "voorbeeldteam"
  $previousTeam
  $count = 0
  foreach($cyclist in $cyclelist){
    if($cyclist.nationality -like $nationality){
        if($cyclist.team -like $team){
            $count++;
            $previousTeam = $cyclist.team
        } else {
            Write-Host("{0,30}:{1,3}"-f $previousTeam,$count)
            $count=1
            $team=$cyclist.team 
            }
        }
    }
  }

function Sum-Score($cyclelist, $team) {
  Write-Host($team)
  [double]$score = 0.0
  foreach($cyclist in $cyclelist){
    if($cyclist.team -like $team){
        $score+=$cyclist.points
        }
    }
    return $score
  }

function Score-Teams($cyclelist) {
  $teams = Get-teams($cyclelist)
  [Array]$topteams = $null
  foreach($team in $teams){
    Write-Host $team.team
    #teamnaam wordt blanco doorgegeven hoe????
    $score = Sum-Score($cyclelist, $team.team)
    Write-Host($score)
    $teamscore = [pscustomobject]@{team=[String]$team.team; score=[double]$score}
    $topteams+=$teamscore
  } 
  return $topteams | Sort-Object -Property score -Descending
  }

# Hoofdprogramma: hier niks wijzigen
# Verwijder enkel de # voor alle werkende functies
# Voor functies die niet werken, laat je de # staan
# Zo lever je een werkend script af

$nationality = "BE"
$team = "Soudal*"



Get-CyclistsByTeamNat $cyclelist $team $nationality | Out-GridView
Count-CyclistsByTeamNat $cyclelist $team $nationality
Get-Teams $cyclelist | Out-GridView
Get-Teams (Clean-Teams $cyclelist) | Out-GridView
$cyclelist = Clean-Teams $cyclelist
Count-CyclistsByNat $cyclelist $nationality
Sum-Score $cyclelist $team
Score-Teams $cyclelist | Out-GridView

