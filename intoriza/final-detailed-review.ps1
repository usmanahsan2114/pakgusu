# Final detailed review of all pages

Write-Host "=== Final Detailed Review ===" -ForegroundColor Cyan
Write-Host ""

$allChecks = @()
$filesChecked = 0

# Get all HTML files
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*" -and
    $_.FullName -notlike "*home\index.html"
}

foreach ($file in $htmlFiles) {
    $filesChecked++
    $relativePath = $file.FullName.Replace($PWD, "").TrimStart('\')
    $depth = ($relativePath -split '\\').Count - 1
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Check Home link
    if ($depth -eq 0) {
        if ($content -notmatch 'href="index\.html"[^>]*>.*Home') {
            $allChecks += "${relativePath}: Home link should be index.html"
        }
    } elseif ($depth -eq 1) {
        if ($content -notmatch 'href="\.\./index\.html"[^>]*>.*Home') {
            $allChecks += "${relativePath}: Home link should be ../index.html"
        }
    } elseif ($depth -eq 2) {
        if ($content -notmatch 'href="\.\./\.\./index\.html"[^>]*>.*Home') {
            $allChecks += "${relativePath}: Home link should be ../../index.html"
        }
    }
    
    # Check logo link
    if ($depth -eq 0) {
        if ($content -notmatch 'href="index\.html"[^>]*>.*<img[^>]*logo-dark') {
            $allChecks += "${relativePath}: Logo should link to index.html"
        }
    } elseif ($depth -eq 1) {
        if ($content -notmatch 'href="\.\./index\.html"[^>]*>.*<img[^>]*logo-dark') {
            $allChecks += "${relativePath}: Logo should link to ../index.html"
        }
    } elseif ($depth -eq 2) {
        if ($content -notmatch 'href="\.\./\.\./index\.html"[^>]*>.*<img[^>]*logo-dark') {
            $allChecks += "${relativePath}: Logo should link to ../../index.html"
        }
    }
    
    # Check navigation structure
    if ($content -match 'Cleanroom Classifications</a></li>\s*<li>\s*<a href="javascript:;" >Products') {
        $allChecks += "${relativePath}: Missing closing tags in About submenu"
    }
    
    # Check footer navigation
    if ($content -notmatch 'footer-link') {
        $allChecks += "${relativePath}: Missing footer navigation"
    }
}

Write-Host "Files checked: $filesChecked" -ForegroundColor Green
Write-Host ""

if ($allChecks.Count -gt 0) {
    Write-Host "=== ISSUES ($($allChecks.Count)) ===" -ForegroundColor Yellow
    foreach ($check in $allChecks | Select-Object -First 20) {
        Write-Host "  $check" -ForegroundColor Yellow
    }
    if ($allChecks.Count -gt 20) {
        Write-Host "  ... and $($allChecks.Count - 20) more" -ForegroundColor Yellow
    }
} else {
    Write-Host "=== All Checks Passed ===" -ForegroundColor Green
}

Write-Host ""
Write-Host "Review complete!" -ForegroundColor Cyan

