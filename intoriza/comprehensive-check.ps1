# Comprehensive check of all pages

Write-Host "=== Comprehensive Page Check ===" -ForegroundColor Cyan
Write-Host ""

$errors = @()
$warnings = @()
$filesChecked = 0

# Get all HTML files
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*"
}

foreach ($file in $htmlFiles) {
    $filesChecked++
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Check for duplicate navigation blocks
    $navCount = ([regex]::Matches($content, '<ul class=" nav navbar-nav nav-line-animation">')).Count
    if ($navCount -gt 1) {
        $errors += "$($file.Name): Multiple navigation blocks ($navCount)"
    }
    
    # Check for missing closing tags in About submenu
    if ($content -match 'Cleanroom Classifications</a></li>\s*<li>\s*<a href="javascript:;" >Products') {
        $errors += "$($file.Name): Missing closing tags in About submenu"
    }
    
    # Check for double quote issue
    if ($content -match '<div class="wt-header-right " ">') {
        $errors += "$($file.Name): Double quote issue in header-right div"
    }
    
    # Check for duplicate navigation items (pattern: Contact us followed by extra </li> and duplicate nav)
    if ($content -match '</a></li>\s*</li>\s*<li>\s*<a href="javascript:;" >Products') {
        $errors += "$($file.Name): Duplicate navigation items detected"
    }
    
    # Check footer structure
    if ($content -notmatch 'footer-link') {
        $warnings += "$($file.Name): Missing footer-link section"
    }
    
    # Check for required navigation items
    $requiredNav = @("Home", "About", "Products", "Services", "Sectors", "Contact")
    foreach ($nav in $requiredNav) {
        if ($content -notmatch $nav) {
            $warnings += "$($file.Name): Missing navigation item '$nav'"
        }
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
    foreach ($warning in $warnings | Select-Object -First 10) {
        Write-Host "  $warning" -ForegroundColor Yellow
    }
    if ($warnings.Count -gt 10) {
        Write-Host "  ... and $($warnings.Count - 10) more warnings" -ForegroundColor Yellow
    }
    Write-Host ""
}

Write-Host "Check complete!" -ForegroundColor Cyan

