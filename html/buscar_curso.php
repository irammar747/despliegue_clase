<?php
require_once 'conexion.php';
require_once 'funcionesCursoBD.php';

if($_SERVER['REQUEST_METHOD'] == 'POST'){
    //Conectar
    $con = conectar();

    if($con === null){
        die('Error de conexión');
    }
    
    //Aquí iría la validación
    $id = $_POST['id'];

    $curso = findCursoById($con, $id);

    if($curso === false){
        $html = "<p>No se ha encontrado el curso</p>";
    }else{
        $html = "<ul>";
        $html .= "<li>ID = {$curso['id']}</li>";
        $html .= "<li>Titulo = {$curso['titulo']}</li>";
        $html .= "<li>Descripción = {$curso['descripcion']}</li>";
        $html .= "<li>Número de horas = {$curso['numero_horas']}</li>";
        $html .= "<ul>";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buscar Curso</title>
</head>
<body>
    <h1>Buscar Curso</h1>
    <form action="" method="post">
        <input type="text" name="id" id="id" placeholder="Id del curso">
        <br>
        <input type="submit" value="Buscar">
    </form>
    <?= $html ?? '' ?>
</body>
</html>