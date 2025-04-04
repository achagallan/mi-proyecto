<?php
header("Content-Type: application/json");
include 'db.php';

$sql = "SELECT itemid, nombre, precio FROM medicamentos";
$result = $conn->query($sql);

$productos = array();
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $productos[] = $row;
    }
} 

$conn->close();

echo json_encode($productos);
?>
