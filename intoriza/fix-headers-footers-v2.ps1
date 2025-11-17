# Comprehensive script to fix all headers and footers - Version 2

$files = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*"
}

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Calculate relative path depth
    $relativePath = $file.DirectoryName.Replace($PWD.Path, "").TrimStart("\")
    $depth = 0
    if ($relativePath) {
        $depth = ($relativePath -split "\\").Count
    }
    
    $relativePathPrefix = ""
    if ($depth -gt 0) {
        $relativePathPrefix = "../" * $depth
    }
    
    # Fix logo link - handle different patterns
    $content = $content -replace 'href="(\.\.\/)*index\.html"', "href=`"${relativePathPrefix}home/index.html`""
    
    # Fix header navigation - replace old menu structure with new one
    $oldNavPattern = '(?s)<ul class=" nav navbar-nav nav-line-animation">.*?</ul>'
    
    # Build navigation based on depth
    if ($depth -eq 0) {
        # Root level files
        $homeLink = "home/index.html"
        $aboutLink = "about/index.html"
        $productsLink = "products/index.html"
        $servicesLink = "services/index.html"
        $sectorsLink = "sectors/index.html"
        $contactLink = "contact/index.html"
        $aboutSub1 = "about/about-pak-gusu/index.html"
        $aboutSub2 = "about/about-gusu-china/index.html"
        $aboutSub3 = "about/cleanroom-classifications/index.html"
        $prodSub1 = "products/clean-room-panels/index.html"
        $prodSub2 = "products/windows/index.html"
        $prodSub3 = "products/doors/index.html"
        $prodSub4 = "products/transfer-window/index.html"
        $prodSub5 = "products/aluminum-profile/index.html"
        $prodSub6 = "products/clean-led-lights/index.html"
        $servSub1 = "services/planning-and-design/index.html"
        $servSub2 = "services/clean-room-construction/index.html"
        $servSub3 = "services/installation/index.html"
        $servSub4 = "services/after-sale-services/index.html"
        $sectSub1 = "sectors/pharmaceutical-nutraceutical/index.html"
        $sectSub2 = "sectors/hospital/index.html"
        $sectSub3 = "sectors/food-industry/index.html"
        $sectSub4 = "sectors/electronics/index.html"
        $sectSub5 = "sectors/laboratories/index.html"
        $sectSub6 = "sectors/medical-surgical-devices/index.html"
    } elseif ($depth -eq 1) {
        # One level deep (about/index.html, products/index.html, etc.)
        $homeLink = "../home/index.html"
        $aboutLink = "../about/index.html"
        $productsLink = "../products/index.html"
        $servicesLink = "../services/index.html"
        $sectorsLink = "../sectors/index.html"
        $contactLink = "../contact/index.html"
        $aboutSub1 = "../about/about-pak-gusu/index.html"
        $aboutSub2 = "../about/about-gusu-china/index.html"
        $aboutSub3 = "../about/cleanroom-classifications/index.html"
        $prodSub1 = "../products/clean-room-panels/index.html"
        $prodSub2 = "../products/windows/index.html"
        $prodSub3 = "../products/doors/index.html"
        $prodSub4 = "../products/transfer-window/index.html"
        $prodSub5 = "../products/aluminum-profile/index.html"
        $prodSub6 = "../products/clean-led-lights/index.html"
        $servSub1 = "../services/planning-and-design/index.html"
        $servSub2 = "../services/clean-room-construction/index.html"
        $servSub3 = "../services/installation/index.html"
        $servSub4 = "../services/after-sale-services/index.html"
        $sectSub1 = "../sectors/pharmaceutical-nutraceutical/index.html"
        $sectSub2 = "../sectors/hospital/index.html"
        $sectSub3 = "../sectors/food-industry/index.html"
        $sectSub4 = "../sectors/electronics/index.html"
        $sectSub5 = "../sectors/laboratories/index.html"
        $sectSub6 = "../sectors/medical-surgical-devices/index.html"
    } else {
        # Two levels deep (about/about-pak-gusu/index.html, etc.)
        $homeLink = "../../home/index.html"
        $aboutLink = "../../about/index.html"
        $productsLink = "../../products/index.html"
        $servicesLink = "../../services/index.html"
        $sectorsLink = "../../sectors/index.html"
        $contactLink = "../../contact/index.html"
        $aboutSub1 = "../../about/about-pak-gusu/index.html"
        $aboutSub2 = "../../about/about-gusu-china/index.html"
        $aboutSub3 = "../../about/cleanroom-classifications/index.html"
        $prodSub1 = "../../products/clean-room-panels/index.html"
        $prodSub2 = "../../products/windows/index.html"
        $prodSub3 = "../../products/doors/index.html"
        $prodSub4 = "../../products/transfer-window/index.html"
        $prodSub5 = "../../products/aluminum-profile/index.html"
        $prodSub6 = "../../products/clean-led-lights/index.html"
        $servSub1 = "../../services/planning-and-design/index.html"
        $servSub2 = "../../services/clean-room-construction/index.html"
        $servSub3 = "../../services/installation/index.html"
        $servSub4 = "../../services/after-sale-services/index.html"
        $sectSub1 = "../../sectors/pharmaceutical-nutraceutical/index.html"
        $sectSub2 = "../../sectors/hospital/index.html"
        $sectSub3 = "../../sectors/food-industry/index.html"
        $sectSub4 = "../../sectors/electronics/index.html"
        $sectSub5 = "../../sectors/laboratories/index.html"
        $sectSub6 = "../../sectors/medical-surgical-devices/index.html"
    }
    
    $newNav = @"
                                <ul class=" nav navbar-nav nav-line-animation">
                                    <li>
                                    	<a href="$homeLink">Home</a>
                                    </li>
                                    <li>
                                        <a href="javascript:;" >About</a>
                                        <ul class="sub-menu">
                                            <li><a href="$aboutLink">About Pak Gusu</a></li>
                                            <li><a href="$aboutSub1">About Pak Gusu</a></li>
                                            <li><a href="$aboutSub2">About GUSU China</a></li>
                                            <li><a href="$aboutSub3">Cleanroom Classifications</a></li>                                            
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="javascript:;" >Products</a>
                                        <ul class="sub-menu">
                                            <li><a href="$productsLink">All Products</a></li>
                                            <li><a href="$prodSub1">Clean Room Panels</a></li>
                                            <li><a href="$prodSub2">Windows</a></li>
                                            <li><a href="$prodSub3">Doors</a></li>
                                            <li><a href="$prodSub4">Transfer Window</a></li>
                                            <li><a href="$prodSub5">Aluminum Profile</a></li>
                                            <li><a href="$prodSub6">Clean LED Lights</a></li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="javascript:;" >Services</a>
                                        <ul class="sub-menu">
                                            <li><a href="$servicesLink">All Services</a></li>
                                            <li><a href="$servSub1">Planning & Design</a></li>
                                            <li><a href="$servSub2">Clean Room Construction</a></li>
                                            <li><a href="$servSub3">Installation</a></li>
                                            <li><a href="$servSub4">After-Sale Services</a></li>                                        
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="javascript:;" >Sectors</a>
                                        <ul class="sub-menu">
                                            <li><a href="$sectorsLink">All Sectors</a></li>
                                            <li><a href="$sectSub1">Pharmaceutical & Nutraceutical</a></li>
                                            <li><a href="$sectSub2">Hospital</a></li>
                                            <li><a href="$sectSub3">Food Industry</a></li>
                                            <li><a href="$sectSub4">Electronics</a></li>
                                            <li><a href="$sectSub5">Laboratories</a></li>
                                            <li><a href="$sectSub6">Medical & Surgical Devices</a></li>
                                        </ul>                                    
                                    </li>
                                    <li>
                                        <a href="$contactLink">Contact us</a>
                                    </li>                               
                                </ul>
"@
    
    if ($content -match $oldNavPattern) {
        $content = $content -replace $oldNavPattern, $newNav
    }
    
    # Fix footer navigation links
    $oldFooterNav = '(?s)<div class="footer-link">.*?</div>'
    $newFooterNav = @"
                    	<div class="footer-link">
                            <ul>
                                <li><a href="$aboutLink" data-hover="About">About</a></li>
                                <li><a href="$productsLink" data-hover="Products">Products</a></li>
                                <li><a href="$servicesLink" data-hover="Services">Services</a></li>
                                <li><a href="$sectorsLink" data-hover="Sectors">Sectors</a></li>
                                <li><a href="$contactLink" data-hover="Contact Us">Contact Us</a></li>
                            </ul>
                        </div>
"@
    
    if ($content -match $oldFooterNav) {
        $content = $content -replace $oldFooterNav, $newFooterNav
    }
    
    # Fix footer company section - simpler approach
    $content = $content -replace '<h4 class="widget-title">Studio</h4>', '<h4 class="widget-title">Company</h4>'
    $content = $content -replace '(?s)<ul><li>Pak Gusu Technology.*?</ul>', "<ul><li>Pak Gusu Technology (Pvt.) Ltd.</li><li><a href=`"$aboutLink`">About Us</a></li><li><a href=`"$contactLink`">Contact</a></li></ul>"
    
    # Fix copyright
    $content = $content -replace '©.*?All Rights Reserved\.', '© 2024 Pak Gusu Technology (Pvt.) Ltd. All Rights Reserved.'
    
    # Fix old links
    $content = $content -replace 'href="(\.\.\/)*about-1\.html"', "href=`"$aboutLink`""
    $content = $content -replace 'href="(\.\.\/)*contact-1\.html"', "href=`"$contactLink`""
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $($file.Name)"
    }
}

Write-Host "All headers and footers updated!"

