# Verify headers and footers structure

Write-Host "=== Verifying Headers and Footers ===" -ForegroundColor Cyan
Write-Host ""

$mainPages = @(
    "home/index.html",
    "about/index.html",
    "products/index.html",
    "services/index.html",
    "sectors/index.html",
    "contact/index.html"
)

$errors = @()
$warnings = @()

foreach ($filePath in $mainPages) {
    $file = Join-Path $PWD $filePath
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        
        # Check header navigation
        $navItems = @("Home", "About", "Products", "Services", "Sectors", "Contact")
        foreach ($item in $navItems) {
            if ($content -notmatch $item) {
                $warnings += "$filePath: Missing navigation item '$item'"
            }
        }
        
        # Check for duplicate navigation
        $navCount = ([regex]::Matches($content, '<ul class=" nav navbar-nav nav-line-animation">')).Count
        if ($navCount -gt 1) {
            $errors += "$filePath: Multiple navigation blocks found ($navCount)"
        }
        
        # Check footer navigation
        if ($content -notmatch 'footer-link') {
            $warnings += "$filePath: Missing footer-link section"
        } else {
            # Check footer links
            $footerLinks = @("About", "Products", "Services", "Sectors", "Contact")
            foreach ($link in $footerLinks) {
                if ($content -notmatch "footer-link.*$link") {
                    $warnings += "$filePath: Missing footer link '$link'"
                }
            }
        }
        
        # Check footer sections
        if ($content -notmatch 'Get In Touch') {
            $warnings += "$filePath: Missing 'Get In Touch' section"
        }
        if ($content -notmatch 'Address') {
            $warnings += "$filePath: Missing 'Address' section"
        }
        if ($content -notmatch 'Company') {
            $warnings += "$filePath: Missing 'Company' section"
        }
        if ($content -notmatch 'copyrights-text') {
            $warnings += "$filePath: Missing copyright section"
        }
        
        # Check for formatting issues
        if ($content -match '<div class="wt-header-right " ">') {
            $errors += "$filePath: Double quote issue in header-right div"
        }
        
        Write-Host "[OK] $filePath" -ForegroundColor Green
    }
}

Write-Host ""
if ($errors.Count -gt 0) {
    Write-Host "=== ERRORS ===" -ForegroundColor Red
    foreach ($error in $errors) {
        Write-Host "  $error" -ForegroundColor Red
    }
}

if ($warnings.Count -gt 0) {
    Write-Host "=== WARNINGS ===" -ForegroundColor Yellow
    foreach ($warning in $warnings) {
        Write-Host "  $warning" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Verification complete!" -ForegroundColor Cyan

