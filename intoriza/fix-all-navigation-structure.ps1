# Fix all navigation structure issues

Write-Host "=== Fixing Navigation Structure ===" -ForegroundColor Cyan
Write-Host ""

# Fix subdirectory pages - missing closing tags in About submenu
$subdirPages = Get-ChildItem -Path . -Filter "index.html" -Recurse | Where-Object { 
    $_.FullName -match '\\about\\|\\products\\|\\services\\|\\sectors\\' -and
    $_.FullName -notmatch '\\about\\index\.html$|\\products\\index\.html$|\\services\\index\.html$|\\sectors\\index\.html$' -and
    $_.FullName -notlike "*fonts*" -and 
    $_.FullName -notlike "*phpmailer*"
}

$fixedCount = 0
foreach ($file in $subdirPages) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Fix missing closing tags in About submenu
    $content = $content -replace '(Cleanroom Classifications</a></li>)\s*(<li>\s*<a href="javascript:;" >Products)', '$1                                            
                                        </ul>
                                    </li>
                                    $2'
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Fixed: $($file.Name)" -ForegroundColor Green
        $fixedCount++
    }
}

# Fix about/index.html - remove duplicate navigation
$aboutFile = Join-Path $PWD "about\index.html"
if (Test-Path $aboutFile) {
    $content = Get-Content $aboutFile -Raw -Encoding UTF8
    $originalContent = $content
    
    # Remove duplicate navigation
    $content = $content -replace '(?s)</a></li>\s*</li>\s*<li>\s*<a href="javascript:;" >Products</a>.*?</ul>\s*</div>\s*</div>\s*<div class="wt-header-right " ">', '</a></li>                               
                                </ul>
                            </div>
                        </div>
                        <div class="wt-header-right ">'
    
    # Fix double quote if still present
    $content = $content -replace '<div class="wt-header-right " ">', '<div class="wt-header-right ">'
    
    if ($content -ne $originalContent) {
        Set-Content -Path $aboutFile -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Fixed: about/index.html" -ForegroundColor Green
        $fixedCount++
    }
}

Write-Host ""
Write-Host "Fixed $fixedCount files" -ForegroundColor Cyan
Write-Host "Done!" -ForegroundColor Green

