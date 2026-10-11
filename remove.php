<?php $lines = file('c:/xampp/htdocs/WBDP/PHP/index.php'); array_splice($lines, 1012, 1181 - 1013 + 2); file_put_contents('c:/xampp/htdocs/WBDP/PHP/index.php', implode('', $lines));
