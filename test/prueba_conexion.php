
<?php
//  Requerimos la clase de conexión
require_once('../models/Conexion.php');

//  Instanciamos la clase de conexión
$conexion = new Conexion();

//  Obtenemos la conexión a la base de datos
$db = $conexion->getConexion();

//  Preparamos la consulta
$query = $db->prepare("SELECT idplato, nombrePlato FROM platos");

//  Ejecutamos la consulta
$query->execute();

//  Obtenemos los resultados
//  le indicamos que queremos que el resultado se devuelva como un arreglo asociativo
$resultados = $query->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
	<title>Resultados de la consulta</title>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>ID</th>
				<th>NOMBRE</th>
			</tr>
		</thead>
		<tbody>
			<?php foreach ($resultados as $resultado): ?>
				<tr>
					<td><?php echo $resultado['idplato']; ?></td>
					<td><?php echo $resultado['nombrePlato']; ?></td>
				</tr>
			<?php endforeach; ?>
		</tbody>
	</table>
</body>
</html>
