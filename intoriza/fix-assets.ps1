# Fix all asset links based on file depth

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
    
    # Build prefix
    $prefix = ""
    if ($depth -eq 1) {
        $prefix = "../"
    } elseif ($depth -eq 2) {
        $prefix = "../../"
    }
    
    # Fix CSS links
    if ($depth -eq 0) {
        $content = $content -replace 'href="(\.\.\/)+css/', 'href="css/'
    } elseif ($depth -eq 1) {
        $content = $content -replace 'href="(\.\.\/)*css/', 'href="../css/'
        $content = $content -replace 'href="css/', 'href="../css/'
    } else {
        $content = $content -replace 'href="(\.\.\/)*css/', 'href="../../css/'
        $content = $content -replace 'href="css/', 'href="../../css/'
        $content = $content -replace 'href="\.\.\/css/', 'href="../../css/'
    }
    
    # Fix JS links
    if ($depth -eq 0) {
        $content = $content -replace 'src="(\.\.\/)+js/', 'src="js/'
    } elseif ($depth -eq 1) {
        $content = $content -replace 'src="(\.\.\/)*js/', 'src="../js/'
        $content = $content -replace 'src="js/', 'src="../js/'
    } else {
        $content = $content -replace 'src="(\.\.\/)*js/', 'src="../../js/'
        $content = $content -replace 'src="js/', 'src="../../js/'
        $content = $content -replace 'src="\.\.\/js/', 'src="../../js/'
    }
    
    # Fix images
    if ($depth -eq 0) {
        $content = $content -replace 'src="(\.\.\/)+images/', 'src="images/'
        $content = $content -replace 'href="(\.\.\/)+images/', 'href="images/'
    } elseif ($depth -eq 1) {
        $content = $content -replace 'src="(\.\.\/)*images/', 'src="../images/'
        $content = $content -replace 'href="(\.\.\/)*images/', 'href="../images/'
        $content = $content -replace 'src="images/', 'src="../images/'
        $content = $content -replace 'href="images/', 'href="../images/'
    } else {
        $content = $content -replace 'src="(\.\.\/)*images/', 'src="../../images/'
        $content = $content -replace 'href="(\.\.\/)*images/', 'href="../../images/'
        $content = $content -replace 'src="images/', 'src="../../images/'
        $content = $content -replace 'href="images/', 'href="../../images/'
        $content = $content -replace 'src="\.\.\/images/', 'src="../../images/'
        $content = $content -replace 'href="\.\.\/images/', 'href="../../images/'
    }
    
    # Fix plugins
    if ($depth -eq 0) {
        $content = $content -replace 'href="(\.\.\/)+plugins/', 'href="plugins/'
        $content = $content -replace 'src="(\.\.\/)+plugins/', 'src="plugins/'
    } elseif ($depth -eq 1) {
        $content = $content -replace 'href="(\.\.\/)*plugins/', 'href="../plugins/'
        $content = $content -replace 'src="(\.\.\/)*plugins/', 'src="../plugins/'
        $content = $content -replace 'href="plugins/', 'href="../plugins/'
        $content = $content -replace 'src="plugins/', 'src="../plugins/'
    } else {
        $content = $content -replace 'href="(\.\.\/)*plugins/', 'href="../../plugins/'
        $content = $content -replace 'src="(\.\.\/)*plugins/', 'src="../../plugins/'
        $content = $content -replace 'href="plugins/', 'href="../../plugins/'
        $content = $content -replace 'src="plugins/', 'src="../../plugins/'
        $content = $content -replace 'href="\.\.\/plugins/', 'href="../../plugins/'
        $content = $content -replace 'src="\.\.\/plugins/', 'src="../../plugins/'
    }
    
    # Fix fonts (if any)
    if ($depth -eq 1) {
        $content = $content -replace 'href="(\.\.\/)*fonts/', 'href="../fonts/'
        $content = $content -replace 'src="(\.\.\/)*fonts/', 'src="../fonts/'
    } elseif ($depth -eq 2) {
        $content = $content -replace 'href="(\.\.\/)*fonts/', 'href="../../fonts/'
        $content = $content -replace 'src="(\.\.\/)*fonts/', 'src="../../fonts/'
    }
    
    # Fix media (if any)
    if ($depth -eq 1) {
        $content = $content -replace 'href="(\.\.\/)*media/', 'href="../media/'
        $content = $content -replace 'src="(\.\.\/)*media/', 'src="../media/'
    } elseif ($depth -eq 2) {
        $content = $content -replace 'href="(\.\.\/)*media/', 'href="../../media/'
        $content = $content -replace 'src="(\.\.\/)*media/', 'src="../../media/'
    }
    
    # Fix phpmailer (if any)
    if ($depth -eq 1) {
        $content = $content -replace 'action="(\.\.\/)*phpmailer/', 'action="../phpmailer/'
    } elseif ($depth -eq 2) {
        $content = $content -replace 'action="(\.\.\/)*phpmailer/', 'action="../../phpmailer/'
    }
    
    # Fix style switcher theme parameter
    if ($depth -eq 1) {
        $content = $content -replace '\?theme=(\.\.\/)*css/', '?theme=../css/'
        $content = $content -replace '\?theme=css/', '?theme=../css/'
    } elseif ($depth -eq 2) {
        $content = $content -replace '\?theme=(\.\.\/)*css/', '?theme=../../css/'
        $content = $content -replace '\?theme=css/', '?theme=../../css/'
        $content = $content -replace '\?theme=\.\.\/css/', '?theme=../../css/'
    }
    
    # Fix URL patterns in CSS (background-image, etc.)
    if ($depth -eq 1) {
        $content = $content -replace 'url\((\.\.\/)*images/', 'url(../images/'
        $content = $content -replace 'url\("(\.\.\/)*images/', 'url("../images/'
        $content = $content -replace "url\('(\.\.\/)*images/", "url('../images/"
        $content = $content -replace 'url\(images/', 'url(../images/'
    } elseif ($depth -eq 2) {
        $content = $content -replace 'url\((\.\.\/)*images/', 'url(../../images/'
        $content = $content -replace 'url\("(\.\.\/)*images/', 'url("../../images/'
        $content = $content -replace "url\('(\.\.\/)*images/", "url('../../images/"
        $content = $content -replace 'url\(images/', 'url(../../images/'
        $content = $content -replace 'url\(\.\.\/images/', 'url(../../images/'
    }
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Fixed: $($file.Name)"
    }
}

Write-Host "Done!"

