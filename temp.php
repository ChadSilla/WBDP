<?php
$c = new mysqli('localhost', 'root', '', 'bida_portal');
$c->query("ALTER TABLE pending_contact_changes ADD COLUMN proof_document VARCHAR(255) NULL");
echo $c->error;
?>
