
file_path = r'c:\xampp\htdocs\fsdc\pakgusu\intoriza\index_utf8.php'

try:
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    if 'class="contact-slide"' in content:
        new_content = content.replace('class="contact-slide"', 'class="contact-slide-hide"')
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print("Successfully replaced class.")
    elif 'class="contact-slide-hide"' in content:
        print("Class already replaced.")
    else:
        print("Target class not found.")

except Exception as e:
    print(f"Error: {e}")
