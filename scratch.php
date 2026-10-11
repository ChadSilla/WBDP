<?php
$c=new mysqli('localhost','root','','bida_portal');
$r=$c->query('SHOW TABLES');
while($row=$r->fetch_row()) echo $row[0]."\n";
?>
