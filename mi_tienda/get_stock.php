<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json; charset=UTF-8");

$conn = new mysqli("localhost", "root", "", "botica_guerrero");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT medicamentos.itemid, medicamentos.nombre, medicamentos.precio, stock.unidades 
        FROM stock 
        JOIN medicamentos ON stock.itemid = medicamentos.itemid";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $items = array();
    while($row = $result->fetch_assoc()) {
        array_push($items, $row);
    }
    echo json_encode($items);
} else {
    echo json_encode([]);
}

$conn->close();
?>

