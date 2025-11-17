# Restructure: Move home page to root and update all links

Write-Host "=== Restructuring Home Page ===" -ForegroundColor Cyan
Write-Host ""

# Step 1: Update all references to home/index.html
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*" -and
    $_.FullName -notlike "*home\index.html"
}

$updatedCount = 0
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Calculate depth (how many levels deep is this file?)
    $relativePath = $file.FullName.Replace($PWD, "").TrimStart('\')
    $depth = ($relativePath -split '\\').Count - 1
    
    # Determine correct path prefix
    if ($depth -eq 0) {
        # Root level - no prefix needed
        $homePath = "index.html"
    } elseif ($depth -eq 1) {
        # One level deep (e.g., about/index.html)
        $homePath = "../index.html"
    } elseif ($depth -eq 2) {
        # Two levels deep (e.g., about/about-pak-gusu/index.html)
        $homePath = "../../index.html"
    } else {
        # Fallback
        $homePath = "../index.html"
    }
    
    # Replace various patterns for home page links
    $content = $content -replace 'href="home/index\.html"', "href=`"$homePath`""
    $content = $content -replace 'href="../home/index\.html"', "href=`"$homePath`""
    $content = $content -replace 'href="../../home/index\.html"', "href=`"$homePath`""
    $content = $content -replace 'href="\.\./home/index\.html"', "href=`"$homePath`""
    $content = $content -replace 'href="\.\./\.\./home/index\.html"', "href=`"$homePath`""
    
    # Fix logo links
    if ($content -match 'href="[^"]*home/index\.html"') {
        $content = $content -replace 'href="([^"]*)home/index\.html"', "href=`"`$1$homePath`""
    }
    
    # Fix breadcrumb links
    $content = $content -replace '<li><a href="[^"]*home/index\.html">Home</a></li>', "<li><a href=`"$homePath`">Home</a></li>"
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $relativePath" -ForegroundColor Green
        $updatedCount++
    }
}

Write-Host ""
Write-Host "Updated $updatedCount files" -ForegroundColor Cyan
Write-Host "Done!" -ForegroundColor Green

