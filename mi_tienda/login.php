<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json; charset=UTF-8");
$servername = "localhost";
$username = "root";
$password = ""; // Asume que la contraseña está vacía si estás usando XAMPP con la configuración predeterminada
$dbname = "botica_guerrero";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Conexión fallida: " . $conn->connect_error]);
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = isset($_POST["email"]) ? $_POST["email"] : null;
    $password = isset($_POST["password"]) ? $_POST["password"] : null;

    if (!$email || !$password) {
        echo json_encode(["success" => false, "message" => "Faltan campos requeridos"]);
        exit();
    }

    $sql = "SELECT * FROM users WHERE correo_electronico='$email'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        if (password_verify($password, $row["contraseña"])) {
            // Excluir el ID del usuario antes de enviarlo de vuelta
            $user = [
                
                'Nombre' => $row["Nombre"],
                'Apellidos' => $row["Apellidos"],
                'correo_electronico' => $row["correo_electronico"],
                'direccion' => $row["direccion"],
                'edad' => $row["edad"],
                'sexo' => $row["sexo"] // Asegúrate de que estos nombres coincidan con tu base de datos
            ];
            echo json_encode(["success" => true, "message" => "Inicio de sesión exitoso", "user" => $user]);
        } else {
            echo json_encode(["success" => false, "message" => "Contraseña incorrecta"]);
        }
    } else {
        echo json_encode(["success" => false, "message" => "Usuario inexistente"]);
    }

    $conn->close();
} else {
    echo json_encode(["status" => "error", "message" => "Método de solicitud no permitido"]);
}
?>
