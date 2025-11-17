# Fix asset paths in root index.html

$indexFile = Join-Path $PWD "index.html"
if (Test-Path $indexFile) {
    $content = Get-Content $indexFile -Raw -Encoding UTF8
    
    # Fix all asset paths - remove ../ prefix since we're now in root
    $content = $content -replace 'href="\.\./images/', 'href="images/'
    $content = $content -replace 'href="\.\./css/', 'href="css/'
    $content = $content -replace 'href="\.\./js/', 'href="js/'
    $content = $content -replace 'href="\.\./plugins/', 'href="plugins/'
    $content = $content -replace 'href="\.\./fonts/', 'href="fonts/'
    $content = $content -replace 'href="\.\./media/', 'href="media/'
    $content = $content -replace 'href="\.\./phpmailer/', 'href="phpmailer/'
    
    $content = $content -replace 'src="\.\./images/', 'src="images/'
    $content = $content -replace 'src="\.\./js/', 'src="js/'
    $content = $content -replace 'src="\.\./plugins/', 'src="plugins/'
    $content = $content -replace 'src="\.\./css/', 'src="css/'
    
    # Fix navigation links - remove ../ prefix
    $content = $content -replace 'href="\.\./about/', 'href="about/'
    $content = $content -replace 'href="\.\./products/', 'href="products/'
    $content = $content -replace 'href="\.\./services/', 'href="services/'
    $content = $content -replace 'href="\.\./sectors/', 'href="sectors/'
    $content = $content -replace 'href="\.\./contact/', 'href="contact/'
    
    # Fix logo link
    $content = $content -replace 'href="index\.html"', 'href="index.html"'
    
    Set-Content -Path $indexFile -Value $content -Encoding UTF8 -NoNewline
    Write-Host "Fixed root index.html asset paths" -ForegroundColor Green
}

