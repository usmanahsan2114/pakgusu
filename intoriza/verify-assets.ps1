# Verify all asset links are correct

$files = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*"
}

$errors = @()

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Calculate depth
    $relativePath = $file.DirectoryName.Replace($PWD.Path, "").TrimStart("\")
    $depth = 0
    if ($relativePath) {
        $depth = ($relativePath -split "\\").Count
    }
    
    # Expected prefix
    $expectedPrefix = ""
    if ($depth -eq 1) {
        $expectedPrefix = "../"
    } elseif ($depth -eq 2) {
        $expectedPrefix = "../../"
    }
    
    # Check CSS links
    if ($content -match 'href="(?!https?://|\.\./|\.\.\./|css/)css/') {
        $errors += "$($file.Name): Incorrect CSS link (depth $depth)"
    }
    
    # Check JS links
    if ($content -match 'src="(?!https?://|\.\./|\.\.\./|js/)js/') {
        $errors += "$($file.Name): Incorrect JS link (depth $depth)"
    }
    
    # Check image links
    if ($content -match 'src="(?!https?://|\.\./|\.\.\./|images/)images/') {
        $errors += "$($file.Name): Incorrect image link (depth $depth)"
    }
}

if ($errors.Count -eq 0) {
    Write-Host "All asset links verified correctly!"
} else {
    Write-Host "Found $($errors.Count) issues:"
    $errors | ForEach-Object { Write-Host "  - $_" }
}

