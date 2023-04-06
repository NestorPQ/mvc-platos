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
                        <a href='#' data-idplato='{$plato['idplato']}' class='btn btn-success btn-sm editar'><i class='bi bi-pencil'></i></a>
                        
                    </td>
                </tr>
                
                ";
                // echo("hola mundo");
                // echo(var_dump($plato['ingredientes']));
                $numeroFila++;
            }
        }
    }
}

?>