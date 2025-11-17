# Fix logo links based on file depth

$files = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*"
}

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Calculate depth
    $relativePath = $file.DirectoryName.Replace($PWD.Path, "").TrimStart("\")
    $depth = 0
    if ($relativePath) {
        $depth = ($relativePath -split "\\").Count
    }
    
    # Fix logo link based on depth
    if ($depth -eq 0) {
        # Root level - should be "home/index.html"
        $content = $content -replace 'href="(\.\.\/)*index\.html"', 'href="home/index.html"'
    } elseif ($depth -eq 1) {
        # One level deep - should be "../home/index.html"
        $content = $content -replace 'href="(\.\.\/)*index\.html"', 'href="../home/index.html"'
        $content = $content -replace 'href="home/index\.html"', 'href="../home/index.html"'
    } else {
        # Two levels deep - should be "../../home/index.html"
        $content = $content -replace 'href="(\.\.\/)*index\.html"', 'href="../../home/index.html"'
        $content = $content -replace 'href="home/index\.html"', 'href="../../home/index.html"'
        $content = $content -replace 'href="\.\.\/home/index\.html"', 'href="../../home/index.html"'
    }
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Fixed logo link: $($file.Name)"
    }
}

Write-Host "Logo links fixed!"

