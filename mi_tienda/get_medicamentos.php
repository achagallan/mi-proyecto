<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "botica_guerrero";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM medicamentos";
$result = $conn->query($sql);

$medicamentos = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $medicamentos[] = $row;
    }
}

$conn->close();

header('Content-Type: application/json');
echo json_encode($medicamentos);
?>
