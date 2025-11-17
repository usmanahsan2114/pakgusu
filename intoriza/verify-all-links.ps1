# Comprehensive link verification script

Write-Host "=== Verifying All Links ===" -ForegroundColor Cyan
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
    
    # Calculate depth
    $relativePath = $file.DirectoryName.Replace($PWD.Path, "").TrimStart("\")
    $depth = 0
    if ($relativePath) {
        $depth = ($relativePath -split "\\").Count
    }
    
    $expectedPrefix = ""
    if ($depth -eq 1) {
        $expectedPrefix = "../"
    } elseif ($depth -eq 2) {
        $expectedPrefix = "../../"
    }
    
    # Check CSS links
    $cssMatches = [regex]::Matches($content, 'href="([^"]*css/[^"]*)"')
    foreach ($match in $cssMatches) {
        $cssPath = $match.Groups[1].Value
        if ($cssPath -notmatch '^https?://') {
            if ($depth -gt 0 -and $cssPath -notmatch '^\.\./') {
                $errors += "$($file.Name): CSS missing prefix - $cssPath (should start with $expectedPrefix)"
            }
            $fullPath = Join-Path $file.DirectoryName $cssPath
            if (-not (Test-Path $fullPath)) {
                $errors += "$($file.Name): CSS file not found - $cssPath"
            }
        }
    }
    
    # Check JS links
    $jsMatches = [regex]::Matches($content, 'src="([^"]*js/[^"]*)"')
    foreach ($match in $jsMatches) {
        $jsPath = $match.Groups[1].Value
        if ($jsPath -notmatch '^https?://') {
            if ($depth -gt 0 -and $jsPath -notmatch '^\.\./') {
                $errors += "$($file.Name): JS missing prefix - $jsPath (should start with $expectedPrefix)"
            }
            $fullPath = Join-Path $file.DirectoryName $jsPath
            if (-not (Test-Path $fullPath)) {
                $errors += "$($file.Name): JS file not found - $jsPath"
            }
        }
    }
    
    # Check image links
    $imgMatches = [regex]::Matches($content, 'src="([^"]*images/[^"]*)"')
    foreach ($match in $imgMatches) {
        $imgPath = $match.Groups[1].Value
        if ($imgPath -notmatch '^https?://') {
            if ($depth -gt 0 -and $imgPath -notmatch '^\.\./') {
                $errors += "$($file.Name): Image missing prefix - $imgPath (should start with $expectedPrefix)"
            }
        }
    }
    
    # Check internal page links
    $pageMatches = [regex]::Matches($content, 'href="([^"]*\.html)"')
    foreach ($match in $pageMatches) {
        $pagePath = $match.Groups[1].Value
        if ($pagePath -notmatch '^https?://' -and $pagePath -notmatch '^#' -and $pagePath -notmatch '^javascript:') {
            $fullPath = Join-Path $file.DirectoryName $pagePath
            if (-not (Test-Path $fullPath)) {
                $warnings += "$($file.Name): Page link may not exist - $pagePath"
            }
        }
    }
    
    # Check for duplicate navigation (common issue)
    $navCount = ([regex]::Matches($content, '<ul class=" nav navbar-nav nav-line-animation">')).Count
    if ($navCount -gt 1) {
        $errors += "$($file.Name): Multiple navigation blocks found ($navCount)"
    }
    
    # Check for proper closing tags
    $openDiv = ([regex]::Matches($content, '<div')).Count
    $closeDiv = ([regex]::Matches($content, '</div>')).Count
    if ($openDiv -ne $closeDiv) {
        $warnings += "$($file.Name): Div tag mismatch (open: $openDiv, close: $closeDiv)"
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
} else {
    Write-Host "=== No Warnings ===" -ForegroundColor Green
    Write-Host ""
}

Write-Host "Verification complete!" -ForegroundColor Cyan

