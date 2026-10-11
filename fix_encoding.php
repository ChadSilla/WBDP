<?php
$c = file_get_contents('PHP/print_pwd_form.php');
// Replace corrupted <span class="cbox">...</span>
$c = preg_replace('/<span class="cbox">[^\x20-\x7E]+<\/span>/', '<span class="cbox">&#9633;</span>', $c);
$c = preg_replace('/<span style="visibility:hidden;" class="cbox">[^\x20-\x7E]+<\/span>/', '<span style="visibility:hidden;" class="cbox">&#9633;</span>', $c);
// Replace corrupted PHP ternary outputs '? '...' : '...';'
$c = preg_replace('/\'[^\x20-\x7E]+\'\s*:\s*\'[^\x20-\x7E]+\'/', '\'&#9632;\' : \'&#9633;\'', $c);
file_put_contents('PHP/print_pwd_form.php', $c);
echo "Done";
