# Fix duplicate navigation and extra whitespace

$files = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*"
}

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Fix extra whitespace before <ul in navigation
    $content = $content -replace '                                                                                                <ul class=" nav navbar-nav', '                                <ul class=" nav navbar-nav'
    
    # Remove duplicate navigation blocks (pattern: </ul> followed by </li> and duplicate nav)
    $content = $content -replace '(?s)</ul>\s*</li>\s*<li>\s*<a href="javascript:;"\s*>Products</a>.*?</ul>\s*</div>\s*</div>\s*<div class="wt-header-right', '</ul>                            </div>                        </div>                        <div class="wt-header-right'
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Fixed: $($file.Name)"
    }
}

Write-Host "Done!"

