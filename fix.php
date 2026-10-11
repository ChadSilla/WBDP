<?php
$lines = file('c:\xampp\htdocs\WBDP\PHP\includes\sidebar.php');
$new_lines = ["<?php\n"];
for ($i = 4; $i < 137; $i++) {
    $new_lines[] = $lines[$i];
}
$new_lines[] = "<?php \n";
$new_lines[] = "// Globally include the modal files so the ID can be viewed anywhere\n";
$new_lines[] = "if (!empty(\) || !empty(\)) {\n";
$new_lines[] = "    if (empty(\['profile_photo']) && !empty(\['profile_photo'])) {\n";
$new_lines[] = "        \['profile_photo'] = basename(\['profile_photo']);\n";
$new_lines[] = "    }\n";
$new_lines[] = "}\n";
$new_lines[] = "if (!empty(\)) {\n";
$new_lines[] = "    \ = \ ?? [];\n";
$new_lines[] = "    include_once __DIR__ . '/senior_digital_id_modal.php';\n";
$new_lines[] = "}\n";
$new_lines[] = "if (!empty(\)) {\n";
$new_lines[] = "    \ = \C:\xampp\htdocs\WBDP ?? [];\n";
$new_lines[] = "    include_once __DIR__ . '/digital_id_modal.php';\n";
$new_lines[] = "}\n";
$new_lines[] = "?>\n";
file_put_contents('c:\xampp\htdocs\WBDP\PHP\includes\sidebar.php', implode("", $new_lines));
echo "Fixed!";
