# Final comprehensive check after restructuring

Write-Host "=== Final Comprehensive Check ===" -ForegroundColor Cyan
Write-Host ""

$errors = @()
$warnings = @()
$filesChecked = 0

# Get all HTML files
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*" -and
    $_.FullName -notlike "*home\*"
}

foreach ($file in $htmlFiles) {
    $filesChecked++
    $relativePath = $file.FullName.Replace($PWD, "").TrimStart('\')
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Calculate depth
    $depth = ($relativePath -split '\\').Count - 1
    
    # Check for old home/index.html references
    if ($content -match 'home/index\.html') {
        $errors += "${relativePath}: Still references home/index.html"
    }
    
    # Check navigation structure
    $navCount = ([regex]::Matches($content, '<ul class=" nav navbar-nav nav-line-animation">')).Count
    if ($navCount -gt 1) {
        $errors += "${relativePath}: Multiple navigation blocks ($navCount)"
    }
    
    # Check for missing closing tags in About submenu
    if ($content -match 'Cleanroom Classifications</a></li>\s*<li>\s*<a href="javascript:;" >Products') {
        $errors += "${relativePath}: Missing closing tags in About submenu"
    }
    
    # Check for double quote issue
    if ($content -match '<div class="wt-header-right " ">') {
        $errors += "${relativePath}: Double quote issue in header-right div"
    }
    
    # Check footer structure
    if ($content -notmatch 'footer-link') {
        $warnings += "${relativePath}: Missing footer-link section"
    }
}

Write-Host "Files checked: $filesChecked" -ForegroundColor Green
Write-Host ""

if ($errors.Count -gt 0) {
    Write-Host "=== ERRORS ($($errors.Count)) ===" -ForegroundColor Red
    foreach ($error in $errors) {
        Write-Host "  $error" -ForegroundColor Red
    }
    Write-Host ""
} else {
    Write-Host "=== No Errors Found ===" -ForegroundColor Green
    Write-Host ""
}

if ($warnings.Count -gt 0) {
    Write-Host "=== WARNINGS ($($warnings.Count)) ===" -ForegroundColor Yellow
    foreach ($warning in $warnings | Select-Object -First 15) {
        Write-Host "  $warning" -ForegroundColor Yellow
    }
    if ($warnings.Count -gt 15) {
        Write-Host "  ... and $($warnings.Count - 15) more warnings" -ForegroundColor Yellow
    }
    Write-Host ""
}

Write-Host "Check complete!" -ForegroundColor Cyan
