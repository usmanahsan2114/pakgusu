# Detailed verification of all pages

Write-Host "=== Detailed Page Verification ===" -ForegroundColor Cyan
Write-Host ""

$allIssues = @()
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
    
    # Check Home link is correct
    if ($depth -eq 0) {
        # Root
        if ($content -notmatch 'href="index\.html".*Home') {
            $allIssues += "${relativePath}: Root file Home link should be index.html"
        }
    } elseif ($depth -eq 1) {
        # One level deep
        if ($content -notmatch 'href="\.\./index\.html".*Home') {
            $allIssues += "${relativePath}: Should link Home to ../index.html"
        }
    } elseif ($depth -eq 2) {
        # Two levels deep
        if ($content -notmatch 'href="\.\./\.\./index\.html".*Home') {
            $allIssues += "${relativePath}: Should link Home to ../../index.html"
        }
    }
    
    # Check logo link
    if ($depth -eq 0) {
        if ($content -notmatch 'href="index\.html".*logo') {
            $allIssues += "${relativePath}: Logo should link to index.html"
        }
    } elseif ($depth -eq 1) {
        if ($content -notmatch 'href="\.\./index\.html".*logo') {
            $allIssues += "${relativePath}: Logo should link to ../index.html"
        }
    } elseif ($depth -eq 2) {
        if ($content -notmatch 'href="\.\./\.\./index\.html".*logo') {
            $allIssues += "${relativePath}: Logo should link to ../../index.html"
        }
    }
    
    # Check navigation structure is complete
    $navItems = @("Home", "About", "Products", "Services", "Sectors", "Contact")
    foreach ($item in $navItems) {
        if ($content -notmatch $item) {
            $allIssues += "${relativePath}: Missing navigation item '$item'"
        }
    }
    
    # Check footer links
    if ($content -notmatch 'footer-link') {
        $allIssues += "${relativePath}: Missing footer navigation"
    }
    
    # Check footer sections
    if ($content -notmatch 'Get In Touch') {
        $allIssues += "${relativePath}: Missing footer 'Get In Touch' section"
    }
    if ($content -notmatch 'Address') {
        $allIssues += "${relativePath}: Missing footer 'Address' section"
    }
    if ($content -notmatch 'Company') {
        $allIssues += "${relativePath}: Missing footer 'Company' section"
    }
}

Write-Host "Files checked: $filesChecked" -ForegroundColor Green
Write-Host ""

if ($allIssues.Count -gt 0) {
    Write-Host "=== ISSUES FOUND ($($allIssues.Count)) ===" -ForegroundColor Yellow
    foreach ($issue in $allIssues | Select-Object -First 20) {
        Write-Host "  $issue" -ForegroundColor Yellow
    }
    if ($allIssues.Count -gt 20) {
        Write-Host "  ... and $($allIssues.Count - 20) more issues" -ForegroundColor Yellow
    }
} else {
    Write-Host "=== All Checks Passed ===" -ForegroundColor Green
}

Write-Host ""
Write-Host "Verification complete!" -ForegroundColor Cyan

