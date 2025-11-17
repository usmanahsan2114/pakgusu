# Fix all headers and footers - remove duplicates and fix structure

$mainPages = @(
    "products/index.html",
    "services/index.html",
    "sectors/index.html",
    "contact/index.html"
)

foreach ($filePath in $mainPages) {
    $file = Join-Path $PWD $filePath
    if (Test-Path $file) {
        Write-Host "Fixing: $filePath" -ForegroundColor Yellow
        $content = Get-Content $file -Raw -Encoding UTF8
        $originalContent = $content
        
        # Remove duplicate navigation (pattern: Contact us</a></li> followed by extra </li> and duplicate nav)
        $content = $content -replace '(?s)</a></li>\s*</li>\s*<li>\s*<a href="javascript:;" >Products</a>.*?</ul>\s*</div>\s*</div>\s*<div class="wt-header-right " ">', '</a></li>                               
                                </ul>
                            </div>
                        </div>
                        <div class="wt-header-right ">'
        
        # Fix the double quote issue
        $content = $content -replace '<div class="wt-header-right " ">', '<div class="wt-header-right ">'
        
        if ($content -ne $originalContent) {
            Set-Content -Path $file -Value $content -Encoding UTF8 -NoNewline
            Write-Host "  Fixed: $filePath" -ForegroundColor Green
        }
    }
}

# Fix sectors/index.html - correct the Sectors submenu links
$sectorsFile = Join-Path $PWD "sectors/index.html"
if (Test-Path $sectorsFile) {
    Write-Host "Fixing sectors/index.html submenu links" -ForegroundColor Yellow
    $content = Get-Content $sectorsFile -Raw -Encoding UTF8
    $originalContent = $content
    
    # Fix Sectors submenu links to use correct relative paths
    $content = $content -replace 'href="pharmaceutical-nutraceutical/index.html"', 'href="pharmaceutical-nutraceutical/index.html"'
    $content = $content -replace 'href="hospital/index.html"', 'href="hospital/index.html"'
    $content = $content -replace 'href="food-industry/index.html"', 'href="food-industry/index.html"'
    $content = $content -replace 'href="electronics/index.html"', 'href="electronics/index.html"'
    $content = $content -replace 'href="laboratories/index.html"', 'href="laboratories/index.html"'
    $content = $content -replace 'href="medical-surgical-devices/index.html"', 'href="medical-surgical-devices/index.html"'
    
    if ($content -ne $originalContent) {
        Set-Content -Path $sectorsFile -Value $content -Encoding UTF8 -NoNewline
        Write-Host "  Fixed sectors/index.html" -ForegroundColor Green
    }
}

Write-Host "Done!" -ForegroundColor Cyan
