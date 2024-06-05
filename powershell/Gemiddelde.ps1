
$grades = [System.Collections.ArrayList]::new()
$grades.IsFixedSize

function Lees-Punten() {
   $amount_courses = Read-Host "Give the amount of grades"
   $amount_students = Read-Host "Give the amount of students"
   

   for ($i=1;$i -le $amount_courses;$i++) {
    $course = [pscustomobject]@{
            CourseName = ""
            Grades = @()
        }
        $course.CourseName = Read-Host "What is the name of the course"
    for ($j=1;$j -le $amount_students;$j++) {
        $g = read-host "What is the grade for student $j in $course.CourseName"
        $course.Grades += [int]$g
    
    }
    [void]$grades.Add($course)
   }

}

function Schrijf-Gemiddelde($grades) {
    foreach ($g in $grades) {
        $average = ($g.Grades | Measure-Object -Average).Average
        $course = ($g | Select-Object -Property CourseName).CourseName
        Write-Host "The average great for $course : $average"
        
    }
}

Lees-Punten
Schrijf-Gemiddelde $grades