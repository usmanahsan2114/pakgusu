# Add border-radius CSS link to all HTML files

Write-Host "=== Adding Border Radius CSS to All Pages ===" -ForegroundColor Cyan
Write-Host ""

$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*"
}

$updatedCount = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Calculate depth
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
    
    # Check if already added
    if ($content -match 'border-radius-global\.css') {
        continue
    }
    
    # Add CSS link after skin-1.css
    if ($content -match '(css/skin/skin-1\.css"[^>]*>)') {
        $content = $content -replace '(css/skin/skin-1\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- GLOBAL BORDER RADIUS -->"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $relativePath" -ForegroundColor Green
        $updatedCount++
    } elseif ($content -match '(\.\./css/skin/skin-1\.css"[^>]*>)') {
        $content = $content -replace '(\.\./css/skin/skin-1\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- GLOBAL BORDER RADIUS -->"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $relativePath" -ForegroundColor Green
        $updatedCount++
    } elseif ($content -match '(\.\./\.\./css/skin/skin-1\.css"[^>]*>)') {
        $content = $content -replace '(\.\./\.\./css/skin/skin-1\.css"[^>]*>)', "`$1`n    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- GLOBAL BORDER RADIUS -->"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $relativePath" -ForegroundColor Green
        $updatedCount++
    } else {
        # Try to add after any CSS link
        if ($content -match '(</head>)') {
            $content = $content -replace '(</head>)', "    <link rel=`"stylesheet`" href=`"$cssPath`"><!-- GLOBAL BORDER RADIUS -->`n`$1"
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            Write-Host "Updated: $relativePath (added before </head>)" -ForegroundColor Yellow
            $updatedCount++
        }
    }
}

Write-Host ""
Write-Host "Updated $updatedCount files" -ForegroundColor Cyan
Write-Host "Done!" -ForegroundColor Green

