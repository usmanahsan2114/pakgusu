# Fix navigation in all subdirectory pages (depth 2)

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
        
        # Check if navigation is broken
        if ($content -match '</ul>\s*</div>\s*</div>\s*<div class="wt-header-right') {
            Write-Host "Fixing: $file" -ForegroundColor Yellow
            
            # Determine which section this is
            $isProducts = $subdir -match '^products/'
            $isServices = $subdir -match '^services/'
            $isSectors = $subdir -match '^sectors/'
            $isAbout = $subdir -match '^about/'
            
            # Build Products submenu
            $productsSubmenu = @"
                                            <li><a href="../../products/index.html">All Products</a></li>
                                            <li><a href="../../products/clean-room-panels/index.html">Clean Room Panels</a></li>
                                            <li><a href="../../products/windows/index.html">Windows</a></li>
                                            <li><a href="../../products/doors/index.html">Doors</a></li>
                                            <li><a href="../../products/transfer-window/index.html">Transfer Window</a></li>
                                            <li><a href="../../products/aluminum-profile/index.html">Aluminum Profile</a></li>
                                            <li><a href="../../products/clean-led-lights/index.html">Clean LED Lights</a></li>
"@
            
            # Build Services submenu
            $servicesSubmenu = @"
                                            <li><a href="../../services/index.html">All Services</a></li>
                                            <li><a href="../../services/planning-and-design/index.html">Planning & Design</a></li>
                                            <li><a href="../../services/clean-room-construction/index.html">Clean Room Construction</a></li>
                                            <li><a href="../../services/installation/index.html">Installation</a></li>
                                            <li><a href="../../services/after-sale-services/index.html">After-Sale Services</a></li>
"@
            
            # Build Sectors submenu
            $sectorsSubmenu = @"
                                            <li><a href="../../sectors/index.html">All Sectors</a></li>
                                            <li><a href="../../sectors/pharmaceutical-nutraceutical/index.html">Pharmaceutical & Nutraceutical</a></li>
                                            <li><a href="../../sectors/hospital/index.html">Hospital</a></li>
                                            <li><a href="../../sectors/food-industry/index.html">Food Industry</a></li>
                                            <li><a href="../../sectors/electronics/index.html">Electronics</a></li>
                                            <li><a href="../../sectors/laboratories/index.html">Laboratories</a></li>
                                            <li><a href="../../sectors/medical-surgical-devices/index.html">Medical & Surgical Devices</a></li>
"@
            
            # Build About submenu
            $aboutSubmenu = @"
                                            <li><a href="../../about/index.html">About Pak Gusu</a></li>
                                            <li><a href="../../about/about-pak-gusu/index.html">About Pak Gusu</a></li>
                                            <li><a href="../../about/about-gusu-china/index.html">About GUSU China</a></li>
                                            <li><a href="../../about/cleanroom-classifications/index.html">Cleanroom Classifications</a></li>
"@
            
            # Build complete navigation
            $navItems = @"
                                    </li>
                                    <li>
                                        <a href="javascript:;" >Products</a>
                                        <ul class="sub-menu">
$productsSubmenu
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="javascript:;" >Services</a>
                                        <ul class="sub-menu">
$servicesSubmenu
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="javascript:;" >Sectors</a>
                                        <ul class="sub-menu">
$sectorsSubmenu
                                        </ul>                                    
                                    </li>
                                    <li>
                                        <a href="../../contact/index.html">Contact us</a>
                                    </li>                               
                                </ul>
                            </div>
                        </div>
                        <div class="wt-header-right "
"@
            
            # Replace broken navigation
            $content = $content -replace '</ul>\s*</div>\s*</div>\s*<div class="wt-header-right', $navItems
            
            if ($content -ne $originalContent) {
                Set-Content -Path $file -Value $content -Encoding UTF8 -NoNewline
                Write-Host "  Fixed: $file" -ForegroundColor Green
            }
        }
    }
}

Write-Host "Done!" -ForegroundColor Cyan

