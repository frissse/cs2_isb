# Computer Systemen 2 - ISB
## Powershell

### Cookbook stuff

`Get-History | Foreach-Object { $_.CommandLine } > c:\temp\script.ps1`

*Writes the history of commands to the file*

`Get-Help <Command> -Examples`

*shows cmdlet examples of a command*


### Inleiding

1. Powershell, cmdlets, help

`Get-Process`

*fetches a list of processes and their associated properties such as process ID (PID), name, CPU usage, memory usage, and other details.*

`Get-Service`

*fetches a list of services and their associated properties such as service name, display name, status (running, stopped, etc.), service start mode (automatic, manual, disabled), and other details.*

`Get-Location`

*returns information about the current working directory*

`Get-ChildItem`

*shows the child items in a directory, when used without parameters it shows the child items of the current directory*

*the order in which the parameters are given is important*

examples:

`Get-ChildItem "C:\Windows" *.exe`

`Get-ChildItem -Path "C:\Windows" -Filter *.exe`

`Get-ChildItem -Filter *.exe -Path "C:\Windows" -Recurse`

`Set-Location`

*used to change the current working directory within a PowerShell session*

`Get-Command <cmdlet>`

*used to retrieve information about cmdlets, functions, workflows, aliases, and executable files*

examples:

`Get-Command Get*`

*Toon alle cmdlets die eindigen op “-object”*

`Get-Command *-object`

*Geef gedetailleerde help voor Get-Service*

`Get-Command Get-Service -Detailed `

*Zoek Cmdlets die iets te maken hebben met “output”*

`Get-Command *output*`

of

`Get-Help output`

`Get-Variable`

*toont alle variables*

`Get-Command mkdir`
`Get-Command sleep`
`Get-Command more`

*zijn functies, geen cmdlets*



### Expressies, variables & commentaar

`2+5*3`

*toont de uitkomst van de bewerking*

`"Dag" + " " + "wereld"`

*toont "Dag Wereld" als output*

`# commentaar`

*syntax voor commentaar in powershell*

`Write-Output (5+9)`

*toont de uitkomst van 5+9*

`Write-Output 5+9 `

*toont "5+9" als output*

`$home`

*is een variabele die de home folder bevat van de huidige gebruiker*

`Get-ChildItem ($home + "\Documents")`

*toont de files en directories in de C:\Users\alex\Documents folder*

`$som=183+21;$som`

*zet de uitkomst van de bewerking in een variabele som en print ze af*

`$datum = Get-Date; $datum`

*zet de huidige datum in een variabele datum en print ze af*

operatoren:

* Rekenkundig: +,-,\*,/,--,++

* Assignment: =, +=, -=, *=, /= 

* Vergelijken: -eq, -ne, -lt, -le, -gt, -ge

* String: +, -like, -replace

* Redirection: >, >>, 2>, 2>>

* Boolean: $true, $false, -not, !, -and, -or

* Call operator: inhoud van string variabele `$a` als commando uitvoeren: `&$a`

`"Hello world" > output.txt`

`Get-Content output.txt`

*schrijft de waarde "Hello world" naar de file output.txt en print ze af*

`265*64 >> output.txt`

*voegt de uitkomst van de bewerking toe aan de file output.txt*

`$opdracht="calc"`

`&$opdracht`

*zet de waarde van variabele \$opdracht als calc en voert deze uit als een commando*

`"Dag wereld" -like "\*we\*"`

*checkt of de waarde "we" voorkomt in de string "dag wereld", returns a boolean*

`"Dag wereld" -replace "Dag", "Daaag"`

*verandert "Dag" in "Daaag" in de string "Dag Wereld"*


### Variabelen

je kan ofwel impliciet een variabelen declareren (data type wordt afgeleid)

`$a=5`

`$c="computer"`

`r=1,2,3`

of expliciet

* `[int] $a =5`
* `[string] $c = "computer"`
* `[double] $pi = 3.145`
* `[array] $r =1,2,3; $r, $r[0]`
* `[array] $s = "een","twee","drie"`

casten van variabelen

* `$a = [int] "5"`
* `$c = [string] $a`

`$dieren="aap", "beer", "olifant"`

*maakt een array aan dieren*

`$dieren[2]`

*selecteert het derde item van de array*

`$dieren += "leeuw"`

*voegt een extra items toe aan het einde van de array"

`$a = 5; "Tel tot" + [string] $a`

*maakt een variabele a aan die gelijk is aan het cijfer 5, vervolgens wordt deze variabelen gecast naar een string en afgeprint*


### externe commando's

`$Env:path`

*plaats waar externe commando's gezocht worden*

`ipconfig`

*toont de "Windows IP Configuration" van de machine*

### aliassen

`Get-Process p*` == `ps p*`

`Get-Alias`

*toont een overzicht van alle aliasen*

`Set-Alias`

*nieuw alias aanmaken*

*voorbeeld:* `Set-Alias vi notepad.exe`

### oefeningen

Stop alle processen waarvan de naam met een m begint in de variabele `$proc`

`$proc=(Get-Process m*)`


toon het 4de element van `$proc`
	
`Write-Output $proc[4]` 

Toon alle sub-directories (geen files) van C:\Program Files waarvan de naam met een w begint en schrijf de output in een file out.txt

`Get-ChildItem "C:\Program Files" -Directory -Filter w*`

alternatief als je enkel files wilt tonen

`Get-ChildItem -Path "C:\Program Files\" -File`

Maak een array genaamd $fibo aan met volgende elementen: 1,1,2,3,5,8

`$fibo = 1,1,2,3,5,8`

Tel het 4de en het 5de element van `$fibo` op, converteer het resultaat naar een string en stop deze in een variabele `$som`

`$som=$fibo[4]+$fibo[5];$som=[string] $som;$som`

Converteer de variabele `$som` naar een integer en voeg deze toe aan de array `$fibo`

`$fibo+=[int]$som`

### Filesysteem

`pwd` = `Get Location`

`cd` = `Set-Location [[-Path] <string>]`

`ls` = `Get-ChildItem [[-Path] <string>] [[-Filter] <string>] [-File] [-Directory]
[-Recurse]`

----

`New-Item [-Path] <string> [-Type <string>] [-Value <Object>] [-Force]`

`Remove-Item [-Path] <string> [-Filter <string>] [-Recurse] [-Force]`

*file aanmaken en verwijderen*

`Copy-Item [-Path] <string> [[-Destination] <String>] [-Force] [-Recurse]`

`Move-Item [-Path] <string> [[-Destination] <String>] [-Force]`

`Rename-Item [-Path] <String> [-NewName] <String> [-Force]`

*kopieren/verplaatsen/hernoemen van files/directories*

`Test-Path [-Path] <string> [-PathType <PathType>]`

*test of bestand/directory bestaat*

`Get-Content [-Path] <string>`

*inhoud van bestand tonen*

`Set-Content [-Path] <string> [-Value] <Object[]>`

`Add-Content [-Path] <string> [-Value] <Object[]>`

`<PSObject> | Out-File -LiteralPath <String> [-Append] [-Force]`

*Bestand schrijven/toevoegen*

`New-Item $home\new_file.txt`

*maakt een nieuw file aan in de home directory*

`New-Item $home\new_dir -type directory`

*maakt een nieuwe directory aan in de home directory*

`New-Item $home\new_file.txt -type file -force -value "This is
text added to the file!`r`n"`

*voegt de string toe aan de file, als ook een line break -> \`r\`n*

`Add-Content $home\new_file.txt "This line too!!"`

*alternatieve manier om lijn tekst toe te voegen aan een file*

`Get-Content $home\new_file.txt`

*toont de inhoude van de file*

`Remove-Item $home\new_dir -Force –Recurse`

*verwijdert de folder recursief*

`Remove-Item $home\new_file.*`

*verwijdert alle file met de naam new_file ongeacht (\*) de extensie*

### providers

met providers kunnen andere data stores (bv registry) ge-accessed worden alsof het een filesysteem is

`Get-PSDrive`

*toont de verschillende drive providers*

`Get-ChildItem Env:`

*toont de inhoud van de drive Env (Environment)*

`cd HKCU:\`

*accessed de HK Current User als een file systeem*

`Set-Location Software`

*verander de pwd naar Software in HKCU*

`New-Item -Path HKCU:\Software\gdp -Value "gdp key"`

*nieuwe key-value pair aan maken in HKCU:\Software*

`New-Item -path env:\TEAMS -Value "KDG1"`

*aanmaken nieuw env variable*

`$env:TEAMS`

*aanspreken van de aangemaakt variable*

`$env:TEAMS = $env:TEAMS + ",KDG2"`

*aanpassen van variable*

### oefeningen

`Test-Path C:\Windows\System32\drivers\etc\hosts`

*Test of de file C:\Windows\System32\drivers\etc\hosts bestaat*

`Copy-Item C:\Windows\System32\drivers\etc\hosts $home`

*Kopieer deze file naar jou home directory*

`Get-Content $home\hosts`

*Toon de inhoud van deze file*

`Add-Content $home\hosts "# Deze file is een alternatief voor de DNS"`

*Voeg volgende lijn toe aan de gekopieerde host file:*

`Remove-Item $home\hosts`

*Verwijder deze file uit jou home directory*

`Get-ChildItem Function:\`

*Toon alle functies op het scherm*

`Get-Content Function:more`

*Toon de code van de functie more*

`Get-ChildItem HKLM:\`

*Toon alle registry keys in HKEY_LOCAL_MACHINE*

`Set-Alias vi notepad.exe`
`Del alias:vi`

*Maak de alias vi uit vorige les terug aan. Test deze uit. Verwijder nu terug deze alias.*

`Remove-Item HKCU:\Software\gdp`

*Verwijder de HKCU:\Software\gdp key*

`Import-Module ActiveDirectory`

`Get-PSDrive`

*Maak via ADUC een user "UserTestPS" aan onder "OU Studenten"*

cd AD:
ls
cd "DC=dehondt,DC=local"
ls
cd "OU=Studenten"
Remove-ADUser -Identity "UserTestPS"

*Navigeer naar de juiste AD map en verwijder de user "UserTestPS" via Powershell*

### pipelines

`Get-Process notepad | Format-List`

*toont de output van Get-Process in een lijst*

`Get-Process notepad | Format-Table`

*toont de output van Get-Process in een tabel*

`Get-Process notepad | Format-Table Name,Path`

*toont de output van Get-Process in een tabel, en tootn enkel de Name en Path attributen*

`Get-Process notepad | Format-List *`

*toont de output van Get-Process in een lijst en toont alle mogelijke attributen/gegevens over het process*

`Get-Process notepad | Stop-Process`

*killt alle processe in de lijst die Get-Process weergeeft*

### Formateren, selecteren, meten en sorteren

`Format-Table, Format-List [[-Property] <Property>]`

*formateert enkel de output, wijzigt de gegevens niet*

`Select-Object [[-Property] <Property>] [-Unique] [-Last <Int32>] [-First
<Int32>]`

*maakt een (nieuwe lijst van) object aan*

`Sort-Object [[-Property] <Property>] [-Descending] [-Unique] [-Top
<Int32>]`

*sorteren van de output op basis van een bepaalde property*

`Group-Object [[-Property] <Property>]`

*grouperen van de output*

`Measure-Object [[-Property] <Property>] [-Sum] [-Average] [-Maximum]
[-Minimum] [-Allstats]`

*werken met de output data (berekeningen)*

`Get-Service | Select-Object -first 5`

*Piped get-service output en selecteert de 1ste 5 rijen van de output*

`Get-date | Select-Object -Property day, month, year`

*maakt een object van get-date en selecteer de day, month en year van dat object (getoond in tabel vorm)*

`Get-ChildItem | Sort-Object LastWriteTime | Select-Object Name, LastWriteTime > C:\temp\list.txt`

*neemt de inhoud van de huidige directory, sorteert deze op LastWriteTime, maakt vervolgens een lijst van object en selecteert de Name, LastWriteTime, vervolgens wordt deze naar de file list.txt geschreven*

`Get-Process | Measure-Object | select-object Count`

*telt het aantal processen die runnen op je computer*

`Get-Service | Group-Object -Property Status`

*toont de services die runnen, vervolgens worden deze gegroupeerd op basis van de property 'status'*

### methods & properties 

`Get-Date | Get-Methods`

*Geeft alle methods & properties van object*

`Get-Date | Format-Table *`

*niet alle properties worden bij default getoond, op deze manier krijg je ze wel allemaal te zien*

`$datum=Get-Date`

*maakt een variabele die als inhoud de output van Get-Date heeft*

`$datum.AddDays(1)`

*voegt een dag toe aan dat Date object in \$datum*

`$datum.DayOfWeek`
`(Get-Date).DayOfWeek`

*toont de propety day of week van het date object of rechtstreeks op de methode (HAAKJES)*

`$processes = Get-Process`

*maakt een variabelen aan met een lijst van processen*

`$processes[9]`
`$processes[9].ProcessName`

*selecteert het 9de proces, toont de process name alleen*

`$processes.ProcessName`

*toont alle procesnamen in de lijst*

### string & array methods

`"" | Get-Member`

*toont methodes & properties die je kan callen op een string*

`"Hello world".SubString(2,5)`

*selecteert een substring van de string (char 2 tot char 5)*

`Get-Member –InputObject $rij`

*toont methodes & properties van een array*

### where object, foreach object

`Get-Process | Where-Object {$_.Name –like "w*"}`

*toont alle processen in de lijst die beginnen met de letter w*

`Get-Process | Where-Object {$_.Id -lt 1000}`

*toont alle processen met een ID lager dan 1000*

`Get-Service | ? {$_.Status –eq "Running"} | Select-Object Name`

*toont de service die de status 'running' hebben en toont daar de naam propertie van*
*'?' = Where-Object*

`Get-Process notepad | Foreach-Object {$_.Id}`

*loopt over het Get-Process object en toont voor elke rij het id*

`Get-Process notepad | % {$_.kill()}`

*loopt over het Get-Process object en killt elke rij/process in de lijst*
*% = Foreach-Object*

`Get-Process | % {$a += $_.id } ; $a`

*pipet de output van Get-Process, loopt hier over en zet de ID van elk process in de variable $a*

### oefeningen

`Get-ChildItem | Where-Object {$_.Name -like "d*"} | Format-List *`

*Toon een lijst met alle properties van alle subdirectories in je homedirectory waarvan de naam met een D begint*

`Get-ChildItem | Select-Object Fullname,Attributes | Sort-Object -Property FullName`

*Toon een tabel met enkel Fullname en Attributes van alle files en directories in je homedirectory, omgekeerd gesorteerd op naam*

`Get-Process | ? {$_.Name -like "notepad"} | % {$_.MainWindowTitle}`
`Get-Process | ? {$_.Name -like "notepad"} | % {$_.MainWindowTitle.ToUpper()}`

*Bekijk de methods en properties van Get-Process. Start notepad en toon de titel van de notepad window. Doe dit nogmaals, maar nu in uppercase*

`Get-Service DHCP | % {$_.DependentServices}`

*Toon de services waar de DHCP service afhankelijk van is.*

`Get-Process c* | % {$sum += $_.VirtualMemorySize} ; $sum`

*Tel de VirtualMemorySize op van alle processen die met een c beginnen.*

`get-Content .\filelist.txt | ForEach-Object {$filepath = $_; Get-Content -Path $filepath}`

*filelist.txt oefeninge*

### CSV files

`Import-Csv [[-Delimiter] <Char>] [[-Path] <String>] [-Header <String[]>]`

*van een CSV file naar een lijst van objecten*

`Export-Csv -InputObject <PSObject> [[-Path] <String>] [-Force] [-Append] [-Confirm]`

of

`<PSObject> | Export-Csv [[-Path] <String>] [-Force] [-Append] [-Confirm]`


*van een lijst object naar een CSV file*

`ConvertTo-CSV`
`ConvertFrom-Csv`

*Enkel converteren van/naar lijst van CSV strings (dus niet naar file schrijven)*

`ConvertFrom-JSON`

*JSON string naar lijst vna object*

`ConverTo-JSON`

*Van lijst van object naar een JSON file*

`ConvertTo-HTML`

*Lijst van objecten -> HTML*

### piping - binding by property name

`Get-Content files.csv`
met volgende inhoud

Path;Type
C:\Temp\Studenten;Directory
C:\Temp\Docenten;Directory
C:\Temp\Studenten\Student1;File
C:\Temp\Docenten\Docent1;File

`$files = Import-Csv .\files.csv -Delimiter ";"`

*store de geimporteerde csv file in een variabele files*

`$files | % { New-Item -Path $_.Path -Type $_.Type -Value ""}`

*lees de inhoud van de file en met behulp van de binding by property name worden er directories/files  aangemaakt op basis van de inhoud van de variabele*
*het kan echter korter*

`$files | New-Item -Force -Value ""`

### oefeningen 

1. Stop de onderstaande array in de variabele $fruit "meloen;2;stuk","appel;3;kg","banaan;4;kg","kokosnoot;5;stuk"

`$fruit="meloen;2;stuk","appel;3;kg","banaan;4;kg","kokosnoot;5;stuk"`

a. Converteer $fruit naar een lijst van objecten. Deze objecten hebben de volgende property names "naam","prijs","eenheid" . Stop deze lijst van objecten in dezelfde variabele $fruit

`$fruit= $fruit|ConvertFrom-Csv -Delimiter ";" -Header "naam","prijs","eenheid"`

b. Toon volgende op het scherm:
- $fruit
- $fruit.naam
- $fruit[0]
- $fruit[3].prijs

c. Schrijf $fruit weg naar JSON file fruit.json

` $fruit |convertto-json | Out-File service.json`

2. Maak een file keys.csv met 1 veld. Stop hierin de onderstaande inhoud
	HKCU:\Software\gdepaepe
	HKLM:\Software\gdepaepe

	met header
	Path;Value

	a. Maak de keys in deze csv-file aan in de registry door gebruik te maken van "binding by property name". Geef volgende als Value "oef42" mee. Voeg hiervoor eerst een juiste header lijn toe aan keys.csv
	
	`$keys | New-Item -Force -Value "oef42"`

	of korter

	`$keys | New-Item -Force -Value "oef42"`

	b. Bekijk de inhoud van de registry
	c. Verwijder deze keys nu via dezelfde methode (let goed op: verwijder niks verkeerd!)

3.

	`$cereal=Import-Csv .\cereal.csv -Delimiter ";"`

	a. Toon alle granen van type H

	`$cereal | Where-Object {$_.Type -like "H"} | Format-List`

	b. Hoeveel granen zijn er met calorieën gelijk zijn dan 50

	`$cereal | Where-Object {$_.calories -eq 50 } | Measure-Object`

	c. Stop het totale gewicht van de granen met calorieën gelijk zijn dan 50 in een variabele $TotWeight

	`$cereal | Where-Object {$_.calories -eq 50 } | Select-Object -Property weight | % {$weight += [double] $_.weight} ; $weight`
	
	
### controle structuren

if (conditie) {…} elseif (…) {…} else {…}
switch ($var) { value {…} value {…} default {…} }
while (conditie) {…}
do {…} while (conditie)
do {…} until (conditie)
foreach (\$var in \$collection) {…}
for (…; ...; ...) {…}
exit

### input output

`Write-Host "--------------"`

*schrijf van script naar terminal*

`$a = Read-Host "Geef input"`

*lees input in van terminal*

`Clear-Host`

*maak terminal leeg*

`Get-Process | Out-GridView`

*Toont de output van Get-Process in een GUI tabel overzicht*

`Get-process | Out-GridView -OutputMode Single`

*zelfde als hierboven maar selecteer de eerste rij in de tabel*

### script parameters

`# Maak-Deling2.ps1
# Default waarde van deeltal en deler is 1
Param(
[int]$deeltal=1,
[int]$deler=1
)
Write-Host ($deeltal / $deler)`

*met de Param() kan je de verwachte params als input setten*

`.\Maak-Deling2.ps1 -deler 2 –deeltal 7
.\Maak-Deling2.ps1 2`

`function FunctionName ($par1, $par2) {
	code
	return $waarde
	}
`

*declareren van functie in script*

`FunctionName value1 value2`

*callen van functie*

### Errorhandling

`$?`

*booleaanse variabele die opslaat of vorig commando succesvol werd uitgevoerd of niet*

`Get-Process notepad -ErrorAction silentlycontinue`

*de error action parameter zorgt ervoor dat er geen errors getoond worden wanneer commando uitgevoerd*

`$ErrorActionPreference = 'silentlycontinue'`

*kan ook gebruikt worden voor hele script*

`try {
    $c = Get-Content -Path C:\nonexistingfile.txt -ErrorAction stop
}
catch {
    Write-Host "File does not exist" -ForegroundColor Red
    exit 1 # geeft exit code 1 -> $? is $false
}`

*binnen een try catch mechanisme wordt de Get-Content uitgevoerd, op basis van de ErrorAction in de catch wordt dan de error message getoond wanneer de file niet bestaat*

while ($true) {
    $process = Get-Process $programName | Where-Object { $_.Name -eq $programName }

    if ($process) {
        Write-Host "$process is running"
    } else {
        Start-Process $process
        Write-Host "$process started"
        exit 0;
    }

}

### CustomObjects

*Maak fruit.csv aan met volgende inhoud
	Fruit,Aantal
	Appels,10
	Peren,8
	Kersen,5
	Bananen,23*
	
` $content = @"
>> Fruit,Aantal
>> Appels,10
>> Peren,8
>> Kersen,5
>> Bananen,25
>> "@ 
`

`$content | Out-File -FilePath "fruits.csv"`

*Importeer deze file in de variabele \$fruit. Kan je deze sorteren op de property aantal? Waarom (niet)?*

`$fruit = Import-Csv fruits.csv`

*Zet \[array\] $CopiedFruit = \$null . Kopieer de lijst \$fruit in deze lijst van custom objecten. Maak gebruik van Foreach-Object. Converteer hierbij aantal naar integer. Kan je deze nu sorteren op de property aantal*

`[array] $CopiedFruit = $null`
`$fruit | ForEach-Object {$CopiedFruit += [pscustomobject]@{Fruit=$_.Fruit;Aantal=[int]$_.Aantal} }`



`& '.\Program With Spaces.exe' arguments`

*To run a command with spaces in its name from the current directory, precede it with both an ampersand and .\:*

    
    

