# Final verification of headers and footers

Write-Host "=== Final Header & Footer Verification ===" -ForegroundColor Cyan
Write-Host ""

$errorList = @()
$warningList = @()
$filesChecked = 0

# Get all HTML files
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*"
}

foreach ($file in $htmlFiles) {
    $filesChecked++
    $relativePath = $file.FullName.Replace($PWD, "").TrimStart('\')
    $depth = ($relativePath -split '\\').Count - 1
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # HEADER CHECKS
    # Check logo exists
    if ($content -notmatch 'logo-dark\.png') {
        $errorList += "${relativePath}: Missing logo"
    }
    
    # Check navigation menu exists
    if ($content -notmatch '<ul class=" nav navbar-nav nav-line-animation">') {
        $errorList += "${relativePath}: Missing navigation menu"
    }
    
    # Check required navigation items
    $requiredNav = @("Home", "About", "Products", "Services", "Sectors", "Contact")
    foreach ($nav in $requiredNav) {
        if ($content -notmatch $nav) {
            $errorList += "${relativePath}: Missing navigation item '$nav'"
        }
    }
    
    # Check for duplicate navigation
    $navCount = ([regex]::Matches($content, '<ul class=" nav navbar-nav nav-line-animation">')).Count
    if ($navCount -gt 1) {
        $errorList += "${relativePath}: Multiple navigation blocks ($navCount)"
    }
    
    # Check for broken navigation structure
    if ($content -match 'Cleanroom Classifications</a></li>\s*<li>\s*<a href="javascript:;" >Products') {
        $errorList += "${relativePath}: Missing closing tags in About submenu"
    }
    
    # Check for formatting issues
    if ($content -match '<div class="wt-header-right " ">') {
        $errorList += "${relativePath}: Double quote issue in header-right div"
    }
    
    # FOOTER CHECKS
    # Check footer exists
    if ($content -notmatch '<footer') {
        $errorList += "${relativePath}: Missing footer"
    }
    
    # Check footer navigation
    if ($content -notmatch 'footer-link') {
        $errorList += "${relativePath}: Missing footer navigation"
    }
    
    # Check footer sections
    if ($content -notmatch 'Get In Touch') {
        $errorList += "${relativePath}: Missing footer 'Get In Touch' section"
    }
    
    if ($content -notmatch 'Address') {
        $errorList += "${relativePath}: Missing footer 'Address' section"
    }
    
    if ($content -notmatch 'Company') {
        $errorList += "${relativePath}: Missing footer 'Company' section"
    }
    
    # Check copyright
    if ($content -notmatch 'Pak Gusu Technology') {
        $warningList += "${relativePath}: Missing copyright text"
    }
}

Write-Host "Files checked: $filesChecked" -ForegroundColor Green
Write-Host ""

if ($errorList.Count -gt 0) {
    Write-Host "=== ERRORS ($($errorList.Count)) ===" -ForegroundColor Red
    foreach ($err in $errorList) {
        Write-Host "  $err" -ForegroundColor Red
    }
    Write-Host ""
} else {
    Write-Host "=== No Errors Found ===" -ForegroundColor Green
    Write-Host ""
}

if ($warningList.Count -gt 0) {
    Write-Host "=== WARNINGS ($($warningList.Count)) ===" -ForegroundColor Yellow
    foreach ($warn in $warningList | Select-Object -First 10) {
        Write-Host "  $warn" -ForegroundColor Yellow
    }
    if ($warningList.Count -gt 10) {
        Write-Host "  ... and $($warningList.Count - 10) more warnings" -ForegroundColor Yellow
    }
    Write-Host ""
}

Write-Host "Verification complete!" -ForegroundColor Cyan

