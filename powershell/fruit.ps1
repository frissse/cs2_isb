$csvfile = "fruit.csv"

$fruit = Import-Csv $csvfile -Delimiter ","

$fruitEdited = $fruit | ForEach-Object {[pscustomobject]@{Fruit=$_.Fruit;Aantal=[int]$_.Aantal}}

$fruitEdited | Sort-Object -Property Aantal