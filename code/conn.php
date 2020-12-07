<?php
$hostname = "localhost"; 
$database = "lab3"; 
$username = "root"; 
$password = ""; 
$conn = mysqli_connect($hostname, $username, $password); 
$db = mysqli_select_db($conn, $database);
?>