$baseDir = "c:\xampp\htdocs\fsdc\pakgusu\intoriza"
$files = Get-ChildItem -Path $baseDir -Recurse -Filter "*.html"

foreach ($file in $files) {
    if ($file.Name -eq "index.html" -and $file.DirectoryName -eq $baseDir) {
        Write-Host "Skipping root index.html"
        continue
    }

    Write-Host "Processing: $($file.FullName)"
    
    # Calculate depth
    $relativePath = $file.FullName.Substring($baseDir.Length + 1)
    $depth = ($relativePath.Split("\").Count) - 1
    
    $rootPrefix = ""
    if ($depth -gt 0) {
        $rootPrefix = "../" * $depth
    } else {
        $rootPrefix = "./"
    }
    
    $content = Get-Content $file.FullName -Raw
    
    # Extract Body
    # Look for <!-- HEADER END --> and <!-- FOOTER START -->
    $headerEndMarker = "<!-- HEADER END -->"
    $footerStartMarker = "<!-- FOOTER START -->"
    
    $startIdx = $content.IndexOf($headerEndMarker)
    $endIdx = $content.IndexOf($footerStartMarker)
    
    if ($startIdx -eq -1 -or $endIdx -eq -1) {
        Write-Host "  Warning: Markers not found in $($file.Name). Skipping."
        continue
    }
    
    $startIdx += $headerEndMarker.Length
    $bodyContent = $content.Substring($startIdx, $endIdx - $startIdx).Trim()
    
    # Replace Paths
    $bodyContent = $bodyContent.Replace(".html", ".php")
    
    if ($depth -gt 0) {
        # Replace relative prefixes with PHP echo
        # We need to escape regex special chars in the prefix if we used regex, but simple replace is safer for literal strings
        # But we need to be careful about what we replace.
        # The file uses prefixes like "../" or "../../"
        # We want to replace THAT specific prefix with "<?php echo `$root; ?>"
        
        # Construct the prefix string used in this file
        $filePrefix = "../" * $depth
        
        # Replace src="prefix...
        $bodyContent = $bodyContent.Replace("src=""$filePrefix", "src=""<?php echo `$root; ?>")
        $bodyContent = $bodyContent.Replace("href=""$filePrefix", "href=""<?php echo `$root; ?>")
        $bodyContent = $bodyContent.Replace("url('$filePrefix", "url('<?php echo `$root; ?>")
        $bodyContent = $bodyContent.Replace("url($filePrefix", "url(<?php echo `$root; ?>")
        $bodyContent = $bodyContent.Replace("url(""$filePrefix", "url(""<?php echo `$root; ?>")
    }
    
    # Construct PHP Content
    $phpContent = "<?php`r`n`$root = '$rootPrefix';`r`ninclude(`$root . 'includes/head.php');`r`n?>`r`n<body class=""footer-fixed"">`r`n    <div class=""page-wraper"">`r`n        <?php include(`$root . 'includes/header.php'); ?>`r`n        <!-- CONTENT START -->`r`n        $bodyContent`r`n        <!-- CONTENT END -->`r`n        <?php include(`$root . 'includes/footer.php'); ?>`r`n    </div>`r`n    <?php include(`$root . 'includes/scripts.php'); ?>`r`n</body>`r`n</html>"
    
    $newFilePath = $file.FullName.Replace(".html", ".php")
    Set-Content -Path $newFilePath -Value $phpContent -Encoding UTF8
    Write-Host "  Created: $newFilePath"
}
