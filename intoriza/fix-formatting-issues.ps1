# Fix formatting issues in subdirectory pages

$subdirs = @(
    "products/clean-room-panels",
    "products/windows",
    "products/doors",
    "products/transfer-window",
    "products/aluminum-profile",
    "products/clean-led-lights",
    "services/planning-and-design",
    "services/clean-room-construction",
    "services/installation",
    "services/after-sale-services",
    "sectors/pharmaceutical-nutraceutical",
    "sectors/hospital",
    "sectors/food-industry",
    "sectors/electronics",
    "sectors/laboratories",
    "sectors/medical-surgical-devices",
    "about/about-pak-gusu",
    "about/about-gusu-china",
    "about/cleanroom-classifications"
)

foreach ($subdir in $subdirs) {
    $file = Join-Path $subdir "index.html"
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        $originalContent = $content
        
        # Fix extra whitespace and closing tag
        $content = $content -replace '</li>\s*\s*</li>', '</li>'
        $content = $content -replace 'Cleanroom Classifications</a></li>\s*\s*</li>', 'Cleanroom Classifications</a></li>                                            
                                        </ul>
                                    </li>'
        
        # Fix double quote in header-right div
        $content = $content -replace '<div class="wt-header-right " ">', '<div class="wt-header-right ">'
        
        if ($content -ne $originalContent) {
            Set-Content -Path $file -Value $content -Encoding UTF8 -NoNewline
            Write-Host "Fixed: $file"
        }
    }
}

Write-Host "Done!"

