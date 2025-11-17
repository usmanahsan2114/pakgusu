# Verify all structure and links

Write-Host "=== Verifying Website Structure ===" -ForegroundColor Cyan
Write-Host ""

$issues = @()

# Check root index.html exists
if (-not (Test-Path "index.html")) {
    $issues += "ERROR: Root index.html not found!"
} else {
    Write-Host "[OK] Root index.html exists" -ForegroundColor Green
}

# Check home folder should not exist or be empty
if (Test-Path "home") {
    $homeFiles = Get-ChildItem -Path "home" -Filter "*.html" | Where-Object { $_.Name -ne "index-2.html" -and $_.Name -ne "index-3.html" -and $_.Name -ne "index-4.html" }
    if ($homeFiles.Count -gt 0) {
        $issues += "WARNING: home folder still contains index.html (should be moved to root)"
    } else {
        Write-Host "[OK] home folder structure correct" -ForegroundColor Green
    }
}

# Verify all main sections exist
$mainSections = @("about", "products", "services", "sectors", "contact")
foreach ($section in $mainSections) {
    $sectionIndex = Join-Path $section "index.html"
    if (Test-Path $sectionIndex) {
        Write-Host "[OK] $section/index.html exists" -ForegroundColor Green
    } else {
        $issues += "ERROR: $sectionIndex not found"
    }
}

# Check root index.html navigation
$rootIndex = Get-Content "index.html" -Raw -Encoding UTF8
if ($rootIndex -match 'href="index\.html"') {
    Write-Host "[OK] Root index.html has correct Home link" -ForegroundColor Green
} else {
    $issues += "ERROR: Root index.html Home link incorrect"
}

if ($rootIndex -match 'href="about/index\.html"') {
    Write-Host "[OK] Root index.html has correct About link" -ForegroundColor Green
} else {
    $issues += "ERROR: Root index.html About link incorrect"
}

# Check one level deep (about/index.html)
$aboutIndex = Get-Content "about\index.html" -Raw -Encoding UTF8
if ($aboutIndex -match 'href="../index\.html"') {
    Write-Host "[OK] about/index.html has correct Home link" -ForegroundColor Green
} else {
    $issues += "ERROR: about/index.html Home link incorrect"
}

# Check two levels deep (products/clean-room-panels/index.html)
$productDetail = Get-Content "products\clean-room-panels\index.html" -Raw -Encoding UTF8
if ($productDetail -match 'href="../../index\.html"') {
    Write-Host "[OK] products/clean-room-panels/index.html has correct Home link" -ForegroundColor Green
} else {
    $issues += "ERROR: products/clean-room-panels/index.html Home link incorrect"
}

# Check for any remaining home/index.html references
$allHtmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*" -and
    $_.FullName -notlike "*home\*"
}

$homeRefs = 0
foreach ($file in $allHtmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    if ($content -match 'home/index\.html') {
        $relativePath = $file.FullName.Replace($PWD, "").TrimStart('\')
        $issues += "ERROR: ${relativePath} still references home/index.html"
        $homeRefs++
    }
}

if ($homeRefs -eq 0) {
    Write-Host "[OK] No remaining home/index.html references" -ForegroundColor Green
}

Write-Host ""
if ($issues.Count -gt 0) {
    Write-Host "=== ISSUES FOUND ===" -ForegroundColor Red
    foreach ($issue in $issues) {
        Write-Host "  $issue" -ForegroundColor Red
    }
} else {
    Write-Host "=== All Structure Checks Passed ===" -ForegroundColor Green
}

Write-Host ""
Write-Host "Verification complete!" -ForegroundColor Cyan

