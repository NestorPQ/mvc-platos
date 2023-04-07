<?php
require_once "../models/Conexion.php";

class Plato extends Conexion{
    private $accesoBD;


    public function __CONSTRUCT(){
        //  almacenamos la conexion obtenida
        $this->accesoBD = parent::getConexion();
    }


    //  Método listar platos
    public function listarPlatos(){
        try {
            //  1. Preparamos la consulta
            $consulta = $this->accesoBD->prepare("CALL spu_platos_listar()");

            //  2. Ejecutamos la consulta
            $consulta->execute();

            //  3. Devolvemos el resultado
            return $consulta->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }


    //  Método registrar plato
    public function registrarPlato($datos = []){
        try {
            $consulta = $this->accesoBD->prepare("CALL spu_platos_registrar(?,?,?,?,?,?,?)");

            $consulta->execute(
                array(
                    $datos["nombrePlato"],
                    $datos["descripcion"],
                    $datos["ingredientes"],
                    $datos["nacionalidadPlato"],
                    $datos["precio"],
                    $datos["porciones"],
                    $datos["tiempoPrepacion"]
                )
            );

        } catch (Exception $e) {
            die($e->getMessage());
        }
    }


    //  Método eliminar plato
    public function eliminarPlato($idplato = 0){
        try {
            $consulta = $this->accesoBD->prepare("CALL spu_platos_eliminar(?,?)");
            $consulta->execute(array($idplato,'0'));

        } catch (Exception $e) {
            die($e->getMessage());
        }
    }

}

?>