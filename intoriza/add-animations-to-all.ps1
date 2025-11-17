# Add modern animations CSS to all HTML files

Write-Host "=== Adding Modern Animations CSS to All Pages ===" -ForegroundColor Cyan
Write-Host ""

$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*"
}

$updatedCount = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Skip if already has animations CSS
    if ($content -match 'modern-animations\.css') {
        continue
    }
    
    $relativePath = $file.FullName.Replace($PWD, "").TrimStart('\')
    $depth = ($relativePath -split '\\').Count - 1
    
    # Determine CSS path prefix
    if ($depth -eq 0) {
        $cssPath = "css/modern-animations.css"
    } elseif ($depth -eq 1) {
        $cssPath = "../css/modern-animations.css"
    } elseif ($depth -eq 2) {
        $cssPath = "../../css/modern-animations.css"
    } else {
        $cssPath = "../css/modern-animations.css"
    }
    
    # Add CSS link after border-radius-global.css
    if ($content -match '(css/border-radius-global\.css"[^>]*>)') {
        $content = $content -replace '(css/border-radius-global\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- MODERN ANIMATIONS -->"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $relativePath" -ForegroundColor Green
        $updatedCount++
    } elseif ($content -match '(\.\./css/border-radius-global\.css"[^>]*>)') {
        $content = $content -replace '(\.\./css/border-radius-global\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- MODERN ANIMATIONS -->"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $relativePath" -ForegroundColor Green
        $updatedCount++
    } elseif ($content -match '(\.\./\.\./css/border-radius-global\.css"[^>]*>)') {
        $content = $content -replace '(\.\./\.\./css/border-radius-global\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- MODERN ANIMATIONS -->"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $relativePath" -ForegroundColor Green
        $updatedCount++
    } else {
        # Try to add after skin-1.css if border-radius not found
        if ($content -match '(css/skin/skin-1\.css"[^>]*>)') {
            $content = $content -replace '(css/skin/skin-1\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- MODERN ANIMATIONS -->"
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            Write-Host "Updated: $relativePath" -ForegroundColor Yellow
            $updatedCount++
        } elseif ($content -match '(\.\./css/skin/skin-1\.css"[^>]*>)') {
            $content = $content -replace '(\.\./css/skin/skin-1\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- MODERN ANIMATIONS -->"
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            Write-Host "Updated: $relativePath" -ForegroundColor Yellow
            $updatedCount++
        } elseif ($content -match '(\.\./\.\./css/skin/skin-1\.css"[^>]*>)') {
            $content = $content -replace '(\.\./\.\./css/skin/skin-1\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- MODERN ANIMATIONS -->"
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            Write-Host "Updated: $relativePath" -ForegroundColor Yellow
            $updatedCount++
        }
    }
}

Write-Host ""
Write-Host "Updated $updatedCount files" -ForegroundColor Cyan
Write-Host "Done!" -ForegroundColor Green

