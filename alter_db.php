<?php
include 'PHP/db_connection.php';
$conn->query("ALTER TABLE service_applications ADD COLUMN duplicate_flag TINYINT(1) NOT NULL DEFAULT 0");
echo "Column added or already exists. Error (if any): " . $conn->error;
?>
