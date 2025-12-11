<?php
require_once 'conexion.php';
require_once 'funcionesCursoBD.php';
//Conectar
$con = conectar();

if($con === null){
    die('Error de conexión');
}

$cursos = findAllCursos($con);

if(empty($cursos)){
    $html = "<p>No hay cursos disponibles</p>";
}else{
    $html = "<table border=1>";
    $html .= "<thead>";
    $html .= "<tr>";
    $html .= "<th>ID</th>";
    $html .= "<th>TITULO</th>";
    $html .= "<th>DESCRIPCIÓN</th>";
    $html .= "<th>NÚMERO DE HORAS</th>";
    $html .= "</tr>";
    $html .= "</thead>";
    $html .= "<tbody>";
    foreach($cursos as $c){
        $html .= "<tr>";
        $html .= "<td>".htmlspecialchars($c['id'])."</td>";
        $html .= "<td>".htmlspecialchars($c['titulo'])."</td>";
        $html .= "<td>".htmlspecialchars($c['descripcion'])."</td>";
        $html .= "<td>".htmlspecialchars($c['numero_horas'])."</td>";
        $html .= "</tr>";
    }
    $html .= "</tbody>";
    $html .= "</table>";
}

$con = null; //Desconectar
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de cursos</title>
</head>
<body>
    <h1>Listado de Cursos</h1>
    <?= $html ?? '' ?>
    <a href="index.html">Volver</a>
</body>
</html>