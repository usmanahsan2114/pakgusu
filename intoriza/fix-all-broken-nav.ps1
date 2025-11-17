# Fix all broken navigation menus

$files = @(
    "about/index.html",
    "contact/index.html",
    "products/index.html",
    "services/index.html",
    "sectors/index.html"
)

foreach ($filePath in $files) {
    $file = Join-Path $PWD $filePath
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        $originalContent = $content
        
        # Check if navigation is broken (missing Products/Services/Sectors/Contact)
        if ($content -match '</ul>\s*</div>\s*</div>\s*<div class="wt-header-right') {
            Write-Host "Found broken navigation in: $filePath" -ForegroundColor Yellow
            
            # Determine depth and build correct navigation
            $depth = 0
            if ($filePath -match '/') {
                $depth = ($filePath -split '/').Count - 1
            }
            
            $prefix = ""
            if ($depth -eq 1) {
                $prefix = "../"
            }
            
            # Build the missing navigation items
            $navItems = @"
                                    </li>
                                    <li>
                                        <a href="javascript:;" >Products</a>
                                        <ul class="sub-menu">
                                            <li><a href="${prefix}products/index.html">All Products</a></li>
                                            <li><a href="${prefix}products/clean-room-panels/index.html">Clean Room Panels</a></li>
                                            <li><a href="${prefix}products/windows/index.html">Windows</a></li>
                                            <li><a href="${prefix}products/doors/index.html">Doors</a></li>
                                            <li><a href="${prefix}products/transfer-window/index.html">Transfer Window</a></li>
                                            <li><a href="${prefix}products/aluminum-profile/index.html">Aluminum Profile</a></li>
                                            <li><a href="${prefix}products/clean-led-lights/index.html">Clean LED Lights</a></li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="javascript:;" >Services</a>
                                        <ul class="sub-menu">
                                            <li><a href="${prefix}services/index.html">All Services</a></li>
                                            <li><a href="${prefix}services/planning-and-design/index.html">Planning & Design</a></li>
                                            <li><a href="${prefix}services/clean-room-construction/index.html">Clean Room Construction</a></li>
                                            <li><a href="${prefix}services/installation/index.html">Installation</a></li>
                                            <li><a href="${prefix}services/after-sale-services/index.html">After-Sale Services</a></li>                                        
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="javascript:;" >Sectors</a>
                                        <ul class="sub-menu">
                                            <li><a href="${prefix}sectors/index.html">All Sectors</a></li>
                                            <li><a href="${prefix}sectors/pharmaceutical-nutraceutical/index.html">Pharmaceutical & Nutraceutical</a></li>
                                            <li><a href="${prefix}sectors/hospital/index.html">Hospital</a></li>
                                            <li><a href="${prefix}sectors/food-industry/index.html">Food Industry</a></li>
                                            <li><a href="${prefix}sectors/electronics/index.html">Electronics</a></li>
                                            <li><a href="${prefix}sectors/laboratories/index.html">Laboratories</a></li>
                                            <li><a href="${prefix}sectors/medical-surgical-devices/index.html">Medical & Surgical Devices</a></li>
                                        </ul>                                    
                                    </li>
                                    <li>
                                        <a href="${prefix}contact/index.html">Contact us</a>
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
                Write-Host "  Fixed: $filePath" -ForegroundColor Green
            }
        }
    }
}

Write-Host "Done!" -ForegroundColor Cyan

