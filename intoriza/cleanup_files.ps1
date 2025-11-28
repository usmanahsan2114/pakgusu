$root = "c:\xampp\htdocs\fsdc\pakgusu\intoriza"
$filesToMove = @(
    "about-1.php",
    "contact-1.php",
    "index_utf8.php",
    "news-grid.php",
    "news-listing.php",
    "news-masonry.php",
    "post-gallery.php",
    "post-right-sidebar.php",
    "work-grid.php",
    "work-masonry.php",
    "project-detail.php",
    "home\index-2.php",
    "home\index-3.php",
    "home\index-4.php",
    "index.html.bak"
)

# Replace project-detail.php links
$filesToUpdate = Get-ChildItem -Path "$root\services", "$root\sectors", "$root\products", "$root\about" -Recurse -Filter *.php
foreach ($file in $filesToUpdate) {
    $content = Get-Content $file.FullName -Raw
    $newContent = $content -replace 'href="[^"]*project-detail\.php"', 'href="javascript:void(0);"'
    if ($content -ne $newContent) {
        $newContent | Set-Content $file.FullName -NoNewline
        Write-Host "Updated $($file.FullName)"
    }
}

# Move files
foreach ($file in $filesToMove) {
    $path = "$root\$file"
    if (Test-Path $path) {
        Move-Item -Path $path -Destination "$root\extra-files" -Force
        Write-Host "Moved $file to extra-files"
    }
    else {
        Write-Host "File not found: $file"
    }
}
