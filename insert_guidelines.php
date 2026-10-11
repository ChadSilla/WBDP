<?php
$landing = file('c:/xampp/htdocs/WBDP/PHP/landing.php');
// lines 543 to 747 in 1-indexed is index 542 to 746
$guidelines = implode('', array_slice($landing, 542, 747-542+1));
$home = file_get_contents('c:/xampp/htdocs/WBDP/PHP/home.php');

$placeholder = '                    <!-- Placeholder for future sections -->' . PHP_EOL . '                    <div class="mt-5 text-center">' . PHP_EOL . '                        <p class="text-muted"><i class="fas fa-tools me-2"></i>More content will be added here soon...</p>' . PHP_EOL . '                    </div>';

// Let's do a more robust replace by just matching the start of the placeholder
$home = preg_replace('/<!-- Placeholder for future sections -->.*/s', $guidelines . "\n                </div>\n            </div>\n        </div>\n    </div>\n    <?php include 'includes/chatbot.php'; ?>\n    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\n    <script src=\"/WBDP/JS/script.js?v=2\"></script>\n</body>\n</html>", $home);

file_put_contents('c:/xampp/htdocs/WBDP/PHP/home.php', $home);
echo "Done";
