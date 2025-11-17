# Fix all remaining asset paths in root index.html

$indexFile = Join-Path $PWD "index.html"
if (Test-Path $indexFile) {
    $content = Get-Content $indexFile -Raw -Encoding UTF8
    
    # Fix all image src paths
    $content = $content -replace 'src="\.\./images/', 'src="images/'
    
    # Fix all JS src paths  
    $content = $content -replace 'src="\.\./js/', 'src="js/'
    
    # Fix all plugin src paths
    $content = $content -replace 'src="\.\./plugins/', 'src="plugins/'
    
    # Fix logo image
    $content = $content -replace 'src="\.\./images/logo-dark\.png"', 'src="images/logo-dark.png"'
    
    Set-Content -Path $indexFile -Value $content -Encoding UTF8 -NoNewline
    Write-Host "Fixed all remaining asset paths in root index.html" -ForegroundColor Green
}

