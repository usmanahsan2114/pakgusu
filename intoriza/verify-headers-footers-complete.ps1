# Complete verification of headers and footers

Write-Host "=== Complete Header & Footer Verification ===" -ForegroundColor Cyan
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
    $relativePath = $file.FullName.Replace($PWD, "").TrimStart('\')
    $depth = ($relativePath -split '\\').Count - 1
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # HEADER CHECKS
    # Check logo exists
    if ($content -notmatch 'logo-dark\.png') {
        $errors += "${relativePath}: Missing logo"
    }
    
    # Check logo link
    if ($depth -eq 0) {
        if ($content -notmatch 'href="index\.html"[^>]*>.*<img[^>]*logo-dark') {
            $errors += "${relativePath}: Logo should link to index.html"
        }
    } elseif ($depth -eq 1) {
        if ($content -notmatch 'href="\.\./index\.html"[^>]*>.*<img[^>]*logo-dark') {
            $errors += "${relativePath}: Logo should link to ../index.html"
        }
    } elseif ($depth -eq 2) {
        if ($content -notmatch 'href="\.\./\.\./index\.html"[^>]*>.*<img[^>]*logo-dark') {
            $errors += "${relativePath}: Logo should link to ../../index.html"
        }
    }
    
    # Check navigation menu exists
    if ($content -notmatch '<ul class=" nav navbar-nav nav-line-animation">') {
        $errors += "${relativePath}: Missing navigation menu"
    }
    
    # Check required navigation items
    $requiredNav = @("Home", "About", "Products", "Services", "Sectors", "Contact")
    foreach ($nav in $requiredNav) {
        if ($content -notmatch $nav) {
            $errors += "${relativePath}: Missing navigation item '$nav'"
        }
    }
    
    # Check Home link
    if ($depth -eq 0) {
        if ($content -notmatch 'href="index\.html"[^>]*>.*Home') {
            $errors += "${relativePath}: Home link should be index.html"
        }
    } elseif ($depth -eq 1) {
        if ($content -notmatch 'href="\.\./index\.html"[^>]*>.*Home') {
            $errors += "${relativePath}: Home link should be ../index.html"
        }
    } elseif ($depth -eq 2) {
        if ($content -notmatch 'href="\.\./\.\./index\.html"[^>]*>.*Home') {
            $errors += "${relativePath}: Home link should be ../../index.html"
        }
    }
    
    # Check About submenu
    if ($content -notmatch 'About Pak Gusu') {
        $warnings += "${relativePath}: Missing About submenu items"
    }
    
    # Check Products submenu
    if ($content -notmatch 'Clean Room Panels') {
        $warnings += "${relativePath}: Missing Products submenu items"
    }
    
    # Check Services submenu
    if ($content -notmatch 'Planning & Design') {
        $warnings += "${relativePath}: Missing Services submenu items"
    }
    
    # Check Sectors submenu
    if ($content -notmatch 'Pharmaceutical & Nutraceutical') {
        $warnings += "${relativePath}: Missing Sectors submenu items"
    }
    
    # Check contact slide panel
    if ($content -notmatch 'Get In Touch') {
        $warnings += "${relativePath}: Missing contact slide panel"
    }
    
    # Check contact info in header
    if ($content -notmatch '\+92 321 8073738') {
        $warnings += "${relativePath}: Missing phone number in header"
    }
    
    if ($content -notmatch 'info@pakgusu\.com') {
        $warnings += "${relativePath}: Missing email in header"
    }
    
    # FOOTER CHECKS
    # Check footer exists
    if ($content -notmatch '<footer') {
        $errors += "${relativePath}: Missing footer"
    }
    
    # Check footer navigation
    if ($content -notmatch 'footer-link') {
        $errors += "${relativePath}: Missing footer navigation"
    }
    
    # Check footer sections
    if ($content -notmatch 'Get In Touch') {
        $errors += "${relativePath}: Missing footer 'Get In Touch' section"
    }
    
    if ($content -notmatch 'Address') {
        $errors += "${relativePath}: Missing footer 'Address' section"
    }
    
    if ($content -notmatch 'Company') {
        $errors += "${relativePath}: Missing footer 'Company' section"
    }
    
    # Check footer links
    if ($content -notmatch 'href="[^"]*about/index\.html"[^>]*>.*About') {
        $warnings += "${relativePath}: Footer About link may be incorrect"
    }
    
    if ($content -notmatch 'href="[^"]*products/index\.html"[^>]*>.*Products') {
        $warnings += "${relativePath}: Footer Products link may be incorrect"
    }
    
    # Check copyright
    if ($content -notmatch 'Pak Gusu Technology') {
        $warnings += "${relativePath}: Missing copyright text"
    }
    
    # Check for duplicate navigation
    $navCount = ([regex]::Matches($content, '<ul class=" nav navbar-nav nav-line-animation">')).Count
    if ($navCount -gt 1) {
        $errors += "${relativePath}: Multiple navigation blocks ($navCount)"
    }
    
    # Check for broken navigation structure
    if ($content -match 'Cleanroom Classifications</a></li>\s*<li>\s*<a href="javascript:;" >Products') {
        $errors += "${relativePath}: Missing closing tags in About submenu"
    }
    
    # Check for formatting issues
    if ($content -match '<div class="wt-header-right " ">') {
        $errors += "${relativePath}: Double quote issue in header-right div"
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
    foreach ($warning in $warnings | Select-Object -First 20) {
        Write-Host "  $warning" -ForegroundColor Yellow
    }
    if ($warnings.Count -gt 20) {
        Write-Host "  ... and $($warnings.Count - 20) more warnings" -ForegroundColor Yellow
    }
    Write-Host ""
}

Write-Host "Verification complete!" -ForegroundColor Cyan

