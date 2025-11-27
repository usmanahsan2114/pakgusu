$rootPath = "c:\xampp\htdocs\fsdc\pakgusu\intoriza"
$files = Get-ChildItem -Path $rootPath -Recurse -Filter "*.php"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content

    # Add fade-up to icon boxes
    $content = $content -replace 'class="wt-icon-box-wraper', 'data-aos="fade-up" class="wt-icon-box-wraper'
    
    # Add fade-right to about content
    $content = $content -replace 'class="about-content', 'data-aos="fade-right" class="about-content'
    
    # Add fade-left to about images
    $content = $content -replace 'class="about-img', 'data-aos="fade-left" class="about-img'
    
    # Add fade-down to section headers
    $content = $content -replace 'class="section-head', 'data-aos="fade-down" class="section-head'
    
    # Add zoom-in to service boxes
    $content = $content -replace 'class="service-box', 'data-aos="zoom-in" class="service-box'

    # Add fade-up to team boxes
    $content = $content -replace 'class="wt-team-1', 'data-aos="fade-up" class="wt-team-1'
    
    # Add fade-up to blog posts
    $content = $content -replace 'class="blog-post', 'data-aos="fade-up" class="blog-post'

    if ($content -ne $originalContent) {
        $content | Set-Content $file.FullName
        Write-Host "Updated $($file.Name)"
    }
}
Write-Host "AOS attributes injection complete."
