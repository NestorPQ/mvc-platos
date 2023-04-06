<?php

//  Creamos la clase conexión
class Conexion {
  //  Atributos
  private $host = "localhost";
  private $port = "3306";
  private $database = "restaurante";
  private $charset = "UTF8";
  private $user = "root";
  private $password = "";


  //  Almacenamos la conexión
  private $pdo;

  //  1. Creamos el método para la acceder a la base de datos
  private function conectarServidor(){
    $conexion = new PDO("mysql:host={$this->host};port={$this->port};dbname={$this->database};charset={$this->charset}",$this->user,$this->password);

    return $conexion;
  }


  //  2. Retornamos el acceso
  public function getConexion(){
    try {

      //  Objeto pdo
      $this->pdo = $this->conectarServidor();

      //  Capturamos cualquier excepción que ocurra durante la conexion
      $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

      return $this->pdo;
    }catch(Exception $error){
      die($error->getMessage());
    }
  }
}