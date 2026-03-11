<?php

ini_set('max_execution_time', 600);
set_time_limit(600);

include "connection.php";

// Read JSON input
$data = json_decode(file_get_contents("php://input"), true);

$question = $data["question"] ?? "";

// Escape question
$safe_question = escapeshellarg($question);

// ---------- STEP 1: Generate SQL ----------
$sql_query = trim(shell_exec("python generate_sql.py $safe_question"));

$sql_query = preg_replace('/\s+/', ' ', $sql_query);

if (!$sql_query) {
    echo json_encode(["error" => "SQL generation failed"]);
    exit;
}

// ---------- STEP 2: Execute SQL ----------
$result = $conn->query($sql_query);

if (!$result) {
    echo json_encode([
        "error" => "SQL execution failed",
        "sql_query" => $sql_query,
        "mysql_error" => $conn->error
    ]);
    exit;
}

$data_rows = [];

while ($row = $result->fetch_assoc()) {
    $data_rows[] = $row;
}

// ---------- STEP 3: Send result to answer generator ----------

// Convert result to JSON
$result_json = json_encode($data_rows);

// Base64 encode
$encoded_result = base64_encode($result_json);

// Escape for shell
$safe_result = escapeshellarg($encoded_result);

// Call answer generator
$answer = trim(shell_exec("python generate_answer.py $safe_question $safe_result"));

// ---------- RESPONSE ----------
header('Content-Type: application/json');

echo json_encode([
    "sql_query" => $sql_query,
    "data" => $data_rows,
    "answer" => $answer
]);

?>