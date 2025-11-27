import os
import re

BASE_DIR = r"c:\xampp\htdocs\fsdc\pakgusu\intoriza"
INCLUDES_DIR = "includes"

def get_depth(file_path):
    rel_path = os.path.relpath(file_path, BASE_DIR)
    return rel_path.count(os.sep)

def get_root_prefix(depth):
    if depth == 0:
        return "./"
    return "../" * depth

def convert_file(file_path):
    if file_path.endswith("index.html") and os.path.dirname(file_path) == BASE_DIR:
        print(f"Skipping root index.html: {file_path}")
        return

    print(f"Processing: {file_path}")
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
        return

    # Extract Content
    # Look for CONTENT START/END or just take body if markers missing
    # Pattern: Header end ... Footer start
    # Header usually ends with <!-- HEADER END -->
    # Footer usually starts with <!-- FOOTER START -->
    
    start_marker = "<!-- CONTENT START -->"
    end_marker = "<!-- FOOTER START -->"
    
    start_idx = content.find(start_marker)
    end_idx = content.find(end_marker)
    
    if start_idx == -1 or end_idx == -1:
        print(f"  Warning: Markers not found in {file_path}. Skipping content extraction.")
        # Fallback: Try to find <div class="page-content"> ... 
        # For now, let's just skip complex files or handle manually if many fail.
        return

    # Extract the content block
    # We want to keep <div class="page-content"> which is usually after CONTENT START
    # But wait, header.php ends before page-content div?
    # Let's check header.php
    # header.php ends with </header> and <!-- HEADER END -->
    # index.php has <div class="page-content"> after header include.
    # So we should extract FROM <div class="page-content"> TO before footer.
    
    # Refined extraction:
    # Find <!-- HEADER END -->
    header_end_idx = content.find("<!-- HEADER END -->")
    if header_end_idx != -1:
        start_idx = header_end_idx + len("<!-- HEADER END -->")
    
    body_content = content[start_idx:end_idx].strip()
    
    # Calculate Root
    depth = get_depth(file_path)
    root_prefix = get_root_prefix(depth)
    
    # Replace Paths
    # 1. Replace .html with .php
    body_content = body_content.replace(".html", ".php")
    
    # 2. Replace relative paths with $root
    # We need to handle ../ and ../../ etc.
    # If the file is at depth 1, it uses ../
    # If the file is at depth 2, it uses ../../
    # We should replace the specific prefix used in this file.
    
    current_file_prefix = "../" * depth
    if depth > 0:
        # Replace occurrences of the prefix in src and href
        # Example: src="../images/..." -> src="<?php echo $root; ?>images/..."
        # Use regex to be safe? Or simple replace?
        # Simple replace of `="../` might be risky if it's not a path.
        # But in HTML attributes it's likely a path.
        
        # We replace the exact prefix string with the php echo
        # e.g. if prefix is "../", replace "../" with "<?php echo $root; ?>"
        # But wait, if we have "../../", replacing "../" first might break it?
        # No, "../../" contains "../".
        # Actually, we should just replace the prefix that matches the depth.
        
        # Better approach:
        # Just replace `src="` + current_file_prefix with `src="<?php echo $root; ?>`
        # And `href="` + current_file_prefix with `href="<?php echo $root; ?>`
        # And `url('` + current_file_prefix with `url('<?php echo $root; ?>` (for inline styles)
        # And `url(` + current_file_prefix with `url(<?php echo $root; ?>`
        
        replacements = [
            (f'src="{current_file_prefix}', f'src="<?php echo $root; ?>'),
            (f'href="{current_file_prefix}', f'href="<?php echo $root; ?>'),
            (f'url(\'{current_file_prefix}', f'url(\'<?php echo $root; ?>'),
            (f'url({current_file_prefix}', f'url(<?php echo $root; ?>'),
             # Also handle double quotes in url
            (f'url("{current_file_prefix}', f'url("<?php echo $root; ?>'),
        ]
        
        for old, new in replacements:
            body_content = body_content.replace(old, new)

    # Construct PHP
    php_content = f"""<?php
$root = '{root_prefix}';
include($root . 'includes/head.php');
?>
<body class="footer-fixed">
    <div class="page-wraper">
        <?php include($root . 'includes/header.php'); ?>
        <!-- CONTENT START -->
        {body_content}
        <!-- CONTENT END -->
        <?php include($root . 'includes/footer.php'); ?>
    </div>
    <?php include($root . 'includes/scripts.php'); ?>
</body>
</html>"""

    # Write PHP file
    new_file_path = file_path.replace(".html", ".php")
    try:
        with open(new_file_path, 'w', encoding='utf-8') as f:
            f.write(php_content)
        print(f"  Created: {new_file_path}")
    except Exception as e:
        print(f"  Error writing {new_file_path}: {e}")

def main():
    for root, dirs, files in os.walk(BASE_DIR):
        for file in files:
            if file.endswith(".html"):
                convert_file(os.path.join(root, file))

if __name__ == "__main__":
    main()
