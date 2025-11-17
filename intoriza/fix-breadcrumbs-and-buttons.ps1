# Fix breadcrumb and "View All" button links

# Fix Products subdirectory pages
$productPages = @(
    "products/clean-room-panels",
    "products/windows",
    "products/doors",
    "products/transfer-window",
    "products/aluminum-profile",
    "products/clean-led-lights"
)

foreach ($page in $productPages) {
    $file = Join-Path $page "index.html"
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        $content = $content -replace 'href="../../home/index.html">Products', 'href="../../products/index.html">Products'
        $content = $content -replace 'href="../../home/index.html" class="site-button.*View All Products', 'href="../../products/index.html" class="site-button m-t15 m-b15">View All Products'
        Set-Content -Path $file -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Fixed: $file"
    }
}

# Fix Services subdirectory pages
$servicePages = @(
    "services/planning-and-design",
    "services/clean-room-construction",
    "services/installation",
    "services/after-sale-services"
)

foreach ($page in $servicePages) {
    $file = Join-Path $page "index.html"
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        $content = $content -replace 'href="../../home/index.html">Services', 'href="../../services/index.html">Services'
        $content = $content -replace 'href="../../home/index.html" class="site-button.*View All Services', 'href="../../services/index.html" class="site-button m-t15 m-b15">View All Services'
        Set-Content -Path $file -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Fixed: $file"
    }
}

# Fix Sectors subdirectory pages
$sectorPages = @(
    "sectors/pharmaceutical-nutraceutical",
    "sectors/hospital",
    "sectors/food-industry",
    "sectors/electronics",
    "sectors/laboratories",
    "sectors/medical-surgical-devices"
)

foreach ($page in $sectorPages) {
    $file = Join-Path $page "index.html"
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        $content = $content -replace 'href="../../home/index.html">Sectors', 'href="../../sectors/index.html">Sectors'
        $content = $content -replace 'href="../../home/index.html" class="site-button.*View All Sectors', 'href="../../sectors/index.html" class="site-button m-t15 m-b15">View All Sectors'
        Set-Content -Path $file -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Fixed: $file"
    }
}

Write-Host "Done!" -ForegroundColor Cyan

