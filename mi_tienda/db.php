<?php
$servername = "localhost";
$username = "usuario";  // El nombre de usuario que creaste
$password = "tu_contraseña";  // La contraseña que asignaste
$dbname = "miproyecto";  // El nombre de la base de datos que creaste

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}
?>
