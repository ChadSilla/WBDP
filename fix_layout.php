<?php
$f = 'c:/xampp/htdocs/WBDP/PHP/home.php';
$content = file_get_contents($f);

// 1. Close the containers before the footer
$content = preg_replace('/(\s*<\/div>\s*<\/section>\s*)<footer/s', "$1                </div>\n            </div>\n    <footer", $content);

// 2. Remove all stray </div> tags at the very end and replace with exactly two </div> tags
$content = preg_replace('/<\/footer>\s*(<div[^>]*>|<\/div>|\s)*<\?php include \'includes\/chatbot.php\'; \?>/s', "</footer>\n        </div>\n    </div>\n    <?php include 'includes/chatbot.php'; ?>", $content);

file_put_contents($f, $content);
echo "Done";
