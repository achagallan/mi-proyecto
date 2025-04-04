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

    if (!$correo_electronico) {
        echo json_encode(["success" => false, "message" => "Faltan campos requeridos"]);
        exit();
    }

    $sql = "SELECT * FROM recibos WHERE correo_electronico='$correo_electronico'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $recibos = [];
        while($row = $result->fetch_assoc()) {
            $recibos[] = $row;
        }
        echo json_encode($recibos);
    } else {
        echo json_encode([]);
    }

    $conn->close();
} else {
    echo json_encode(["status" => "error", "message" => "Método de solicitud no permitido"]);
}
?>
