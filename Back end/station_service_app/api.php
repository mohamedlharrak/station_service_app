<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "station_service";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $ville = $data['ville'];
    $nom_station = $data['nom_station'];
    $logo_url = $data['logo_url'];
    $prix_diesel = $data['prix_diesel'];
    $prix_essence = $data['prix_essence'];
    $prix_services = $data['prix_services'];
    $latitude = $data['latitude'];
    $longitude = $data['longitude'];

    $sql = "INSERT INTO stations (ville, nom_station, logo_url, prix_diesel, prix_essence, prix_services, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssddssdd", $ville, $nom_station, $logo_url, $prix_diesel, $prix_essence, $prix_services, $latitude, $longitude);
    if ($stmt->execute()) {
        echo json_encode(["message" => "Station added successfully"]);
    } else {
        echo json_encode(["message" => "Error adding station"]);
    }
} elseif ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['ville'])) {
    $ville = $_GET['ville'];
    $sql = "SELECT * FROM stations WHERE ville = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $ville);
    $stmt->execute();
    $result = $stmt->get_result();

    $stations = [];
    while($row = $result->fetch_assoc()) {
        $stations[] = $row;
    }
    echo json_encode($stations);
} elseif ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $sql = "SELECT * FROM stations";
    $result = $conn->query($sql);
    $stations = [];
    while($row = $result->fetch_assoc()) {
        $stations[] = $row;
    }
    echo json_encode($stations);
}

$conn->close();
?>