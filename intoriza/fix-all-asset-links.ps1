# Comprehensive script to fix all asset links (CSS, JS, images, fonts, plugins, media, phpmailer)

$files = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*" -and
    $_.FullName -notlike "*vendor*"
}

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Calculate depth - count how many directories deep from intoriza root
    $relativePath = $file.DirectoryName.Replace($PWD.Path, "").TrimStart("\")
    $depth = 0
    if ($relativePath) {
        $depth = ($relativePath -split "\\").Count
    }
    
    # Build relative path prefix
    $prefix = ""
    if ($depth -gt 0) {
        $prefix = "../" * $depth
    }
    
    Write-Host "Processing: $($file.Name) (depth: $depth, prefix: '$prefix')"
    
    # Fix CSS links
    $content = $content -replace 'href="(\.\.\/)*css/', "href=`"${prefix}css/"
    $content = $content -replace 'href="(\.\.\/)*plugins/', "href=`"${prefix}plugins/"
    
    # Fix JS script sources
    $content = $content -replace 'src="(\.\.\/)*js/', "src=`"${prefix}js/"
    $content = $content -replace 'src="(\.\.\/)*plugins/', "src=`"${prefix}plugins/"
    
    # Fix image sources
    $content = $content -replace 'src="(\.\.\/)*images/', "src=`"${prefix}images/"
    $content = $content -replace 'url\((\.\.\/)*images/', "url(${prefix}images/"
    $content = $content -replace 'url\("(\.\.\/)*images/', "url(`"${prefix}images/"
    $content = $content -replace "url\('(\.\.\/)*images/", "url('${prefix}images/"
    
    # Fix favicon links
    $content = $content -replace 'href="(\.\.\/)*images/favicon', "href=`"${prefix}images/favicon"
    
    # Fix font links (if any)
    $content = $content -replace 'href="(\.\.\/)*fonts/', "href=`"${prefix}fonts/"
    $content = $content -replace 'src="(\.\.\/)*fonts/', "src=`"${prefix}fonts/"
    
    # Fix media links (if any)
    $content = $content -replace 'href="(\.\.\/)*media/', "href=`"${prefix}media/"
    $content = $content -replace 'src="(\.\.\/)*media/', "src=`"${prefix}media/"
    
    # Fix phpmailer links (if any in forms)
    $content = $content -replace 'action="(\.\.\/)*phpmailer/', "action=`"${prefix}phpmailer/"
    
    # Fix style switcher theme links
    $content = $content -replace '\?theme=(\.\.\/)*css/', "?theme=${prefix}css/"
    
    # Fix any remaining incorrect patterns - ensure no double ../ or wrong paths
    # Remove any incorrect patterns like href="../css/" when it should be "../css/" for depth 1
    # This is tricky, so we'll be careful
    
    # For depth 0 (root), ensure no ../ prefix
    if ($depth -eq 0) {
        $content = $content -replace 'href="\.\.\/css/', 'href="css/'
        $content = $content -replace 'src="\.\.\/js/', 'src="js/'
        $content = $content -replace 'src="\.\.\/images/', 'src="images/'
        $content = $content -replace 'href="\.\.\/plugins/', 'href="plugins/'
        $content = $content -replace 'src="\.\.\/plugins/', 'src="plugins/'
    }
    
    # For depth 1, ensure exactly one ../
    if ($depth -eq 1) {
        # Remove double ../../
        $content = $content -replace 'href="\.\.\/\.\.\/css/', 'href="../css/'
        $content = $content -replace 'src="\.\.\/\.\.\/js/', 'src="../js/'
        $content = $content -replace 'src="\.\.\/\.\.\/images/', 'src="../images/'
        $content = $content -replace 'href="\.\.\/\.\.\/plugins/', 'href="../plugins/'
        $content = $content -replace 'src="\.\.\/\.\.\/plugins/', 'src="../plugins/'
        # Ensure single ../ exists
        $content = $content -replace 'href="css/', 'href="../css/'
        $content = $content -replace 'src="js/', 'src="../js/'
        $content = $content -replace 'src="images/', 'src="../images/'
        $content = $content -replace 'href="plugins/', 'href="../plugins/'
        $content = $content -replace 'src="plugins/', 'src="../plugins/'
    }
    
    # For depth 2, ensure exactly two ../../
    if ($depth -eq 2) {
        # Remove triple ../../../
        $content = $content -replace 'href="\.\.\/\.\.\/\.\.\/css/', 'href="../../css/'
        $content = $content -replace 'src="\.\.\/\.\.\/\.\.\/js/', 'src="../../js/'
        $content = $content -replace 'src="\.\.\/\.\.\/\.\.\/images/', 'src="../../images/'
        $content = $content -replace 'href="\.\.\/\.\.\/\.\.\/plugins/', 'href="../../plugins/'
        $content = $content -replace 'src="\.\.\/\.\.\/\.\.\/plugins/', 'src="../../plugins/'
        # Fix single ../ to ../../
        $content = $content -replace 'href="\.\.\/css/', 'href="../../css/'
        $content = $content -replace 'src="\.\.\/js/', 'src="../../js/'
        $content = $content -replace 'src="\.\.\/images/', 'src="../../images/'
        $content = $content -replace 'href="\.\.\/plugins/', 'href="../../plugins/'
        $content = $content -replace 'src="\.\.\/plugins/', 'src="../../plugins/'
        # Fix no prefix to ../../
        $content = $content -replace 'href="css/', 'href="../../css/'
        $content = $content -replace 'src="js/', 'src="../../js/'
        $content = $content -replace 'src="images/', 'src="../../images/'
        $content = $content -replace 'href="plugins/', 'href="../../plugins/'
        $content = $content -replace 'src="plugins/', 'src="../../plugins/'
    }
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "  ✓ Fixed asset links"
    } else {
        Write-Host "  - No changes needed"
    }
}

Write-Host ""
Write-Host "All asset links fixed!"

