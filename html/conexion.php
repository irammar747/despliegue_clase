<?php
define('SERVER', 'mysql:host=mysql_db;dbname=academia;charset=utf8mb4');
define('USER', 'usuario');
define('PASS', 'oretania');

function conectar():PDO|null{
    try{
        //Creando un objeto de la clase PDO
        //Este objeto va a guardar todo lo necesario para administrar la conexión a la BD
        $con = new PDO(SERVER, USER, PASS);
        $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $con->setAttribute(PDO::MYSQL_ATTR_INIT_COMMAND, "SET NAMES utf8mb4");
        $con->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

        return $con;

    }catch(PDOException $e){
        echo "Error de conexión: ".$e->getMessage(); //En producción nunca se pondría
        return null;
    }
}

