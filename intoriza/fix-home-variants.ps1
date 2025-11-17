# Fix home variant pages (index-2, index-3, index-4) to link to root index.html

$homeVariants = @("home\index-2.html", "home\index-3.html", "home\index-4.html")

foreach ($filePath in $homeVariants) {
    $file = Join-Path $PWD $filePath
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        $originalContent = $content
        
        # Update Home navigation link
        $variantName = Split-Path $filePath -Leaf
        $content = $content -replace "href=`"$variantName`".*Home", 'href="../index.html">Home'
        $content = $content -replace 'href="index-2\.html"', 'href="../index.html"'
        $content = $content -replace 'href="index-3\.html"', 'href="../index.html"'
        $content = $content -replace 'href="index-4\.html"', 'href="../index.html"'
        
        # Update logo link
        $content = $content -replace "href=`"$variantName`"", 'href="../index.html"'
        
        if ($content -ne $originalContent) {
            Set-Content -Path $file -Value $content -Encoding UTF8 -NoNewline
            Write-Host "Fixed: $filePath" -ForegroundColor Green
        }
    }
}

Write-Host "Done!" -ForegroundColor Cyan

