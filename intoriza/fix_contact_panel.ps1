$path = "c:\xampp\htdocs\fsdc\pakgusu\intoriza\index_utf8.php"
$content = Get-Content $path -Raw -Encoding UTF8
if ($content -match 'class="contact-slide"') {
    $content = $content -replace 'class="contact-slide"', 'class="contact-slide-hide"'
    $content | Set-Content $path -Encoding UTF8
    Write-Host "Replaced class."
}
else {
    Write-Host "Class not found."
}
