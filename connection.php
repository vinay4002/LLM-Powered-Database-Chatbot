<?php

$host = "localhost";
$username = "root";
$password = "";
$database = "school_management_system"; // change to your database name

$conn = new mysqli($host, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Database connection failed: " . $conn->connect_error);
}

// echo "Database connection successful";
?>