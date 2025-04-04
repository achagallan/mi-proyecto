<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json; charset=UTF-8");
$servername = "localhost";
$username = "root";
$password = ""; 
$dbname = "botica_guerrero";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Conexión fallida: " . $conn->connect_error]);
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $correo_electronico = isset($_POST["correo_electronico"]) ? $_POST["correo_electronico"] : null;
    $mode = isset($_POST["mode"]) ? $_POST["mode"] : null;
    $total = isset($_POST["total"]) ? $_POST["total"] : null;
    $date = isset($_POST["date"]) ? $_POST["date"] : null;

    if (!$correo_electronico || !$mode || !$total || !$date) {
        echo json_encode(["success" => false, "message" => "Faltan campos requeridos"]);
        exit();
    }

    $sql = "INSERT INTO recibos (correo_electronico, mode, total, date) VALUES ('$correo_electronico', '$mode', '$total', '$date')";
    
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Recibo agregado exitosamente"]);
    } else {
        echo json_encode(["success" => false, "message" => "Error: " . $conn->error]);
    }

    $conn->close();
} else {
    echo json_encode(["status" => "error", "message" => "Método de solicitud no permitido"]);
}
?>
