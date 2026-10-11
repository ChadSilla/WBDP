<?php
$c = file_get_contents('PHP/print_pwd_form.php');
// Replace corrupted DASMARIÑAS with DASMARI&#209;AS
$c = preg_replace('/DASMARI[^\x20-\x7E]+AS/', 'DASMARI&#209;AS', $c);
file_put_contents('PHP/print_pwd_form.php', $c);
echo "Done";
