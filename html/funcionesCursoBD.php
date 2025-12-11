<?php
/**
 * Función que devuelve un array con todos los registros de la tabla cursos
 * o un array vacio si la tabla está vacia o si hay algún fallo
 */
    function findAllCursos(PDO $con):array{
        try{
            $stm = $con->prepare("select * from cursos");
            $stm->execute();
            $resultado = $stm->fetchAll();
            return $resultado;
        }catch(PDOException $e){
            echo $e->getMessage();
            return [];
        }
        
    }

    function findCursoById(PDO $con, $id):array|false{
        try{
            $stm = $con->prepare("select * from cursos where id=:id");

            //Hago el bind
            $stm->bindValue(':id', $id);

            $stm->execute();
            $resultado = $stm->fetch();

            return $resultado;

        }catch(PDOException $e){
            echo $e->getMessage();
            return false; //False si no encuentra el curso o si hay algún error
        }
        
    }


?>