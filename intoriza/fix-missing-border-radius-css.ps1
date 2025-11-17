# Fix missing border-radius CSS links

Write-Host "=== Fixing Missing Border Radius CSS Links ===" -ForegroundColor Cyan
Write-Host ""

$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*"
}

$fixedCount = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Skip if already has border-radius CSS
    if ($content -match 'border-radius-global\.css') {
        continue
    }
    
    $relativePath = $file.FullName.Replace($PWD, "").TrimStart('\')
    $depth = ($relativePath -split '\\').Count - 1
    
    # Determine CSS path prefix
    if ($depth -eq 0) {
        $cssPath = "css/border-radius-global.css"
    } elseif ($depth -eq 1) {
        $cssPath = "../css/border-radius-global.css"
    } elseif ($depth -eq 2) {
        $cssPath = "../../css/border-radius-global.css"
    } else {
        $cssPath = "../css/border-radius-global.css"
    }
    
    # Add CSS link after skin-1.css
    if ($content -match '(css/skin/skin-1\.css"[^>]*>)') {
        $content = $content -replace '(css/skin/skin-1\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- GLOBAL BORDER RADIUS -->"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Fixed: $relativePath" -ForegroundColor Green
        $fixedCount++
    } elseif ($content -match '(\.\./css/skin/skin-1\.css"[^>]*>)') {
        $content = $content -replace '(\.\./css/skin/skin-1\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- GLOBAL BORDER RADIUS -->"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Fixed: $relativePath" -ForegroundColor Green
        $fixedCount++
    } elseif ($content -match '(\.\./\.\./css/skin/skin-1\.css"[^>]*>)') {
        $content = $content -replace '(\.\./\.\./css/skin/skin-1\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- GLOBAL BORDER RADIUS -->"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Fixed: $relativePath" -ForegroundColor Green
        $fixedCount++
    }
}

Write-Host ""
Write-Host "Fixed $fixedCount files" -ForegroundColor Cyan
Write-Host "Done!" -ForegroundColor Green

