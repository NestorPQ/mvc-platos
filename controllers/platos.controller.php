<?php

require_once '../models/Platos.php';

// Se verifica si se ha enviado una variable POST llamada "operacion"
if (isset($_POST['operacion'])){
    $plato = new Plato();

    if($_POST['operacion'] == 'listar'){

        $datosObtenidos = $plato->listarPlatos();

        if ($datosObtenidos){
            $numeroFila = 1;

            foreach($datosObtenidos as $plato){
                echo "
                <tr>
                    <td>{$numeroFila}</td>
                    <td>{$plato['nombrePlato']}</td>
                    <td>{$plato['descripcion']}</td>
                    <td>{$plato['nacionalidadPlato']}</td>
                    <td>{$plato['precio']}</td>
                    <td>{$plato['porciones']}</td>
                    <td>{$plato['tiempoPrepacion']}</td>
                    <td>
                        <a href='#' data-idplato='{$plato['idplato']}' class='btn btn-danger btn-sm eliminar'><i class='bi bi-trash'></i></a>
                        <a href='#' data-idplato='{$plato['idplato']}' class='btn btn-success btn-sm editar' style='float: right;'><i class='bi bi-pencil'></i></a>                     
                    </td>
                </tr>
                
                ";
                // echo("hola mundo");
                // echo(var_dump($plato['ingredientes']));
                $numeroFila++;
            }
        }
    }
    if($_POST['operacion'] == 'registrar'){
        $datosForm = [
            "nombreplato"            =>  $_POST['nombreplato'],
            "descripcion"            =>  $_POST['descripcion'],
            "ingredientes"           =>  $_POST['ingredientes'],
            "nacionalidadPlato"      =>  $_POST['nacionalidadPlato'],
            "precio"                 =>  $_POST['precio'],
            "porciones"              =>  $_POST['porciones'],
            "tiempoPrepacion"        =>  $_POST['tiempoPrepacion']
        ];

        $plato->registrarPlato($datosForm);
        var_dump($datosForm);
    }


    if ($_POST['operacion'] == 'eliminar'){
        $plato->eliminarPlato($_POST['idplato']);
    }
}

?>