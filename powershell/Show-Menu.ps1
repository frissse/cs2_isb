$csv_filePath = "./StudentGrades.csv"

function Lees-Punten () {
    while($true) {
        $numberof_courses = Read-Host "Give the amount of courses"
        $numberof_students = Read-Host "Give the amount of students"
        if ($numberof_courses -as [int] -and $numberof_students -as [int] -and $numberof_courses -gt 0 -and $numberof_students -gt 0) {
            Write-Host "number of courses: $numberof_courses"
            Write-Host "number of students: $numberof_students"
            break;
        } else {
            Write-Host "please provide a number bigger than 0";
            Start-Sleep -Seconds 10
            Clear-Host
        }
    }
    $courseGrades = @{}
    for ($i = 0; $i -lt $numberof_courses; $i++) {
        $courseKey = "Course$i"
        $courseGrades[$courseKey] = @{}
        for ($j = 0; $j -lt $numberof_students;$j++) {
            $studentKey = "Student$j"
            $grade = Read-Host "Enter the grade for $studentKey in $courseKey"
            $courseGrades[$courseKey][$studentKey] = $grade
        }
    }

    $csv_data = @()
    $Header ="Course, Grade"
    Set-Content $csv_filePath -Value $Header

    foreach ($course in $courseGrades.Keys) {
        foreach  ($student in $courseGrades[$course].Keys) {
            $row = [PSCustomObject]@{
                Course = $course
                Grade = $courseGrades[$course][$student]
            } 
            $csv_data += $row
        }
    }

    $csv_data | Export-Csv -Path $csv_filePath -NoTypeInformation
}

function Schrijf-Gemiddelde () {
    $csv_file = Import-Csv -Path $csv_filePath -Delimiter ","


    $entries = @()
    $csv_file | ForEach-Object {$entries += [PSCustomObject]@{
        Course = $_.Course;
        Grade = [int]$_.Grade
    }}

    $groupedGrades = $entries | Group-Object -Property Course

    $averageGrades = foreach ($group in $groupedGrades) {
        $course = $group.Name
        $averageGrade = ($group.Group | Measure-Object -Property Grade -Average).Average
        [PSCustomObject]@{
            Course = $course
            AverageGrade = $averageGrade
        }
    }

    $averageGrades | Format-Table

}   

Lees-Punten
Schrijf-Gemiddelde