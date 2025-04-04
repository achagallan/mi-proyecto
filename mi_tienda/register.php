<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$servername = "localhost";
$username = "root";
$password = ""; // Asume que la contraseña está vacía si estás usando XAMPP con la configuración predeterminada
$dbname = "botica_guerrero";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Conexión fallida: " . $conn->connect_error]));
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nombre = $_POST["nombre"];
    $apellidos = $_POST["apellidos"];
    $correo_electronico = $_POST["correo_electronico"];
    $contraseña = password_hash($_POST["contraseña"], PASSWORD_DEFAULT); // Encriptar la contraseña
    $direccion = $_POST["direccion"];
    $edad = $_POST["edad"];
    $sexo = $_POST["sexo"];

    $sql = "INSERT INTO users (Nombre, Apellidos, correo_electronico, contraseña, direccion, edad, sexo) VALUES ('$nombre', '$apellidos', '$correo_electronico', '$contraseña', '$direccion', '$edad', '$sexo')";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(["status" => "success", "message" => "Registro exitoso"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Error: " . $sql . " - " . $conn->error]);
    }

    $conn->close();
} else {
    echo json_encode(["status" => "error", "message" => "Método no permitido"]);
}
?>
