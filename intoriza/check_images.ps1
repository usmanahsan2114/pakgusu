$baseDir = "c:\xampp\htdocs\fsdc\pakgusu\intoriza"
$imagesDir = "$baseDir\images"

# Get all PHP files
$files = Get-ChildItem -Path $baseDir -Recurse -Filter "*.php"

$missingImages = @()

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Regex to find src="..."
    # We look for src="<?php echo $root; ?>images/..." or src="images/..."
    # Pattern: src=["'](?:<\?php echo \$root; \?>)?images/([^"']+)["']
    
    $matches = [regex]::Matches($content, 'src=["''](?:<\?php echo \$root; \?>)?images/([^"''?]+)["'']')
    
    foreach ($match in $matches) {
        $imagePath = $match.Groups[1].Value
        # Normalize path separators
        $imagePath = $imagePath.Replace("/", "\")
        
        $fullPath = "$imagesDir\$imagePath"
        
        if (-not (Test-Path $fullPath)) {
            if ($missingImages -notcontains $fullPath) {
                $missingImages += $fullPath
            }
        }
    }
}

Write-Host "Found $($missingImages.Count) missing images."

foreach ($img in $missingImages) {
    Write-Host "Missing: $img"
    
    # Create directory if needed
    $parentDir = Split-Path $img
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Force -Path $parentDir | Out-Null
    }
    
    # Download placeholder
    # We'll use a generic size, maybe 600x400
    try {
        Invoke-WebRequest -Uri "https://placehold.co/600x400/29afe3/ffffff.png?text=PakGusu" -OutFile $img
        Write-Host "  Downloaded placeholder."
    }
    catch {
        Write-Host "  Failed to download placeholder: $_"
    }
}
