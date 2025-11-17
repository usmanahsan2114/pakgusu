# Comprehensive website verification script

Write-Host "=== Website Verification ===" -ForegroundColor Cyan
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

Write-Host "Checking $($htmlFiles.Count) HTML files..." -ForegroundColor Yellow
Write-Host ""

foreach ($file in $htmlFiles) {
    $filesChecked++
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $relativePath = $file.DirectoryName.Replace($PWD.Path, "").TrimStart("\")
    $depth = 0
    if ($relativePath) {
        $depth = ($relativePath -split "\\").Count
    }
    
    $prefix = ""
    if ($depth -eq 1) {
        $prefix = "../"
    } elseif ($depth -eq 2) {
        $prefix = "../../"
    }
    
    # Check for missing closing tags
    $openTags = ([regex]::Matches($content, '<(?!\/)[^>]+>')).Count
    $closeTags = ([regex]::Matches($content, '<\/[^>]+>')).Count
    if ($openTags -gt $closeTags + 10) {
        $warnings += "$($file.Name): Possible missing closing tags (open: $openTags, close: $closeTags)"
    }
    
    # Check CSS links
    $cssMatches = [regex]::Matches($content, 'href="([^"]*css/[^"]*)"')
    foreach ($match in $cssMatches) {
        $cssPath = $match.Groups[1].Value
        if ($cssPath -notmatch '^https?://' -and $cssPath -notmatch '^\.\./') {
            if ($depth -gt 0 -and $cssPath -notmatch '^\.\./') {
                $errors += "$($file.Name): CSS link missing prefix: $cssPath"
            }
        }
        # Check if file exists
        $fullPath = Join-Path $file.DirectoryName $cssPath
        if ($cssPath -notmatch '^https?://' -and -not (Test-Path $fullPath)) {
            $errors += "$($file.Name): CSS file not found: $cssPath"
        }
    }
    
    # Check JS links
    $jsMatches = [regex]::Matches($content, 'src="([^"]*js/[^"]*)"')
    foreach ($match in $jsMatches) {
        $jsPath = $match.Groups[1].Value
        if ($jsPath -notmatch '^https?://' -and $jsPath -notmatch '^\.\./') {
            if ($depth -gt 0 -and $jsPath -notmatch '^\.\./') {
                $errors += "$($file.Name): JS link missing prefix: $jsPath"
            }
        }
        # Check if file exists
        $fullPath = Join-Path $file.DirectoryName $jsPath
        if ($jsPath -notmatch '^https?://' -and -not (Test-Path $fullPath)) {
            $errors += "$($file.Name): JS file not found: $jsPath"
        }
    }
    
    # Check image links
    $imgMatches = [regex]::Matches($content, 'src="([^"]*images/[^"]*)"')
    foreach ($match in $imgMatches) {
        $imgPath = $match.Groups[1].Value
        if ($imgPath -notmatch '^https?://' -and $imgPath -notmatch '^\.\./') {
            if ($depth -gt 0 -and $imgPath -notmatch '^\.\./') {
                $errors += "$($file.Name): Image link missing prefix: $imgPath"
            }
        }
    }
    
    # Check internal page links
    $pageMatches = [regex]::Matches($content, 'href="([^"]*\.html)"')
    foreach ($match in $pageMatches) {
        $pagePath = $match.Groups[1].Value
        if ($pagePath -notmatch '^https?://' -and $pagePath -notmatch '^#') {
            $fullPath = Join-Path $file.DirectoryName $pagePath
            if (-not (Test-Path $fullPath)) {
                $warnings += "$($file.Name): Page link may not exist: $pagePath"
            }
        }
    }
    
    # Check for required meta tags
    if ($content -notmatch '<title>') {
        $warnings += "$($file.Name): Missing <title> tag"
    }
    if ($content -notmatch '<meta.*description') {
        $warnings += "$($file.Name): Missing meta description"
    }
    
    # Check for logo
    if ($content -notmatch 'logo-dark\.png') {
        $warnings += "$($file.Name): Logo image not found"
    }
}

Write-Host "Files checked: $filesChecked" -ForegroundColor Green
Write-Host ""

if ($errors.Count -gt 0) {
    Write-Host "=== ERRORS ($($errors.Count)) ===" -ForegroundColor Red
    foreach ($error in $errors) {
        Write-Host "  ERROR: $error" -ForegroundColor Red
    }
    Write-Host ""
} else {
    Write-Host "=== No Errors Found ===" -ForegroundColor Green
    Write-Host ""
}

if ($warnings.Count -gt 0) {
    Write-Host "=== WARNINGS ($($warnings.Count)) ===" -ForegroundColor Yellow
    foreach ($warning in $warnings) {
        Write-Host "  WARNING: $warning" -ForegroundColor Yellow
    }
    Write-Host ""
} else {
    Write-Host "=== No Warnings ===" -ForegroundColor Green
    Write-Host ""
}

# Check critical directories exist
Write-Host "=== Checking Critical Directories ===" -ForegroundColor Cyan
$criticalDirs = @("css", "js", "images", "plugins", "home", "about", "products", "services", "sectors", "contact")
foreach ($dir in $criticalDirs) {
    if (Test-Path $dir) {
        Write-Host "  ✓ $dir exists" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $dir MISSING" -ForegroundColor Red
        $errors += "Critical directory missing: $dir"
    }
}

Write-Host ""
Write-Host "=== Verification Complete ===" -ForegroundColor Cyan
if ($errors.Count -eq 0) {
    Write-Host "Website appears to be ready!" -ForegroundColor Green
} else {
    Write-Host "Please fix the errors above." -ForegroundColor Red
}

