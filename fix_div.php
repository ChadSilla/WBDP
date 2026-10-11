<?php
$f = 'c:/xampp/htdocs/WBDP/PHP/home.php';
$content = file_get_contents($f);
$content = str_replace("    </footer>\n    </div>\n\n\n\n                </div>\n            </div>", "    </footer>\n                </div>\n            </div>", $content);
file_put_contents($f, $content);
echo "Fixed!";
