# Simple website verification

Write-Host "Checking website files..." -ForegroundColor Yellow

$errors = @()
$warnings = @()

# Check critical directories
$dirs = @("css", "js", "images", "plugins", "home", "about", "products", "services", "sectors", "contact")
foreach ($dir in $dirs) {
    if (Test-Path $dir) {
        Write-Host "[OK] Directory: $dir" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] Missing: $dir" -ForegroundColor Red
        $errors += "Missing directory: $dir"
    }
}

# Check key files exist
$keyFiles = @(
    "home/index.html",
    "about/index.html",
    "products/index.html",
    "services/index.html",
    "sectors/index.html",
    "contact/index.html"
)

Write-Host ""
Write-Host "Checking key pages..." -ForegroundColor Yellow
foreach ($file in $keyFiles) {
    if (Test-Path $file) {
        Write-Host "[OK] $file" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] Missing: $file" -ForegroundColor Red
        $errors += "Missing file: $file"
    }
}

# Check asset directories
Write-Host ""
Write-Host "Checking assets..." -ForegroundColor Yellow
$assetDirs = @("css", "js", "images")
foreach ($dir in $assetDirs) {
    $files = Get-ChildItem -Path $dir -File -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($files) {
        Write-Host "[OK] $dir has files" -ForegroundColor Green
    } else {
        Write-Host "[WARNING] $dir appears empty" -ForegroundColor Yellow
        $warnings += "$dir directory appears empty"
    }
}

Write-Host ""
if ($errors.Count -eq 0 -and $warnings.Count -eq 0) {
    Write-Host "All checks passed! Website structure looks good." -ForegroundColor Green
} else {
    if ($errors.Count -gt 0) {
        Write-Host "Found $($errors.Count) errors" -ForegroundColor Red
    }
    if ($warnings.Count -gt 0) {
        Write-Host "Found $($warnings.Count) warnings" -ForegroundColor Yellow
    }
}

