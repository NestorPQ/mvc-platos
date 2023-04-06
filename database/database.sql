CREATE DATABASE restaurante;
USE restaurante;

CREATE TABLE platos
(
	idplato INT AUTO_INCREMENT PRIMARY KEY,
	nombrePlato 			VARCHAR(25) 	NOT NULL UNIQUE,
	descripcion 			VARCHAR(150)	NOT NULL,
	ingredientes 			VARCHAR(150)	NOT NULL,
	nacionalidadPlato		VARCHAR(100)	NULL,
	precio					DECIMAL(7,2)	NOT NULL,
	porciones				INT 				CHECK(porciones > 0),
	tiempoPrepacion		VARCHAR(30)		NOT NULL,
	estado					CHAR(1)			NOT NULL DEFAULT '1'
	-- dificultad,
	-- calificacionCliente,
	-- fotoPlato,
	-- calorias,
	-- valor nutricional
)ENGINE = INNODB;

	
	INSERT INTO platos 
	(
	nombrePlato, 
	descripcion,
	ingredientes,
	nacionalidadPlato,
	precio,
	porciones,
	tiempoPrepacion
	) VALUES
	("Carapulcra","plato tipico de chincha","tallarires,patas,carne","Peru",12,4,"30 minutos"),
	("Lomo Saltado","plato tipico peruano con carne y verduras salteadas","carne, cebolla, tomate, papas fritas","Peru",20,3,"45 minutos"),
	("Ceviche","plato peruano de pescado marinado en limon","pescado, limon, cebolla, ají","Peru",18,2,"20 minutos"),
	("Pizza Margarita","pizza clasica con tomate y mozzarella","masa de pizza, salsa de tomate, mozzarella","Italia",15,4,"30 minutos"),
	("Sushi","plato japones de arroz y pescado crudo","arroz, pescado, alga nori","Japon",25,2,"15 minutos"),
	("Blini","Panqueques rusos tradicionales hechos con harina de trigo sarraceno","harina de trigo sarraceno, huevo, leche, crema agria","Rusia",10,4,"30 minutos"),
	('Pasta Alfredo', 'Clásica pasta alfredo con salsa cremosa de queso', 'pasta, mantequilla, crema, ajo, queso parmesano', 'Italia', 18.99, 3, '20 minutos'),
	('Ceviche de camarones', 'Delicioso ceviche de camarones con limón y ají', 'camarones, limón, ají, cebolla, cilantro', 'Perú', 22.5, 2, '30 minutos'),
	("Borscht","sopa tradicional ucraniana de remolacha","remolacha, col, zanahoria, patata, carne de res","Ucrania",10,4,"1 hora"),
	("Draniki","tortitas de patata bielorrusas","patata, cebolla, huevo, harina","Bielorrusia",8,6,"30 minutos"),
	("Karelian Pasties","pasteles de Karelia, Finlandia","harina, mantequilla, arroz, huevo","Finlandia",12,4,"1 hora"),
	("Sauerbraten","estofado de carne alemán","carne de res, vinagre, cebolla, zanahoria","Alemania",18,4,"2 horas")


SELECT * FROM platos;


--  STORE PROCEDURE
--  LISTAR PLATOS
DELIMITER $$
CREATE PROCEDURE spu_platos_listar()
BEGIN
	SELECT	idplato,
		nombrePlato,
		descripcion,
		nacionalidadPlato,
		precio,
		porciones,
		tiempoPrepacion,
		estado
	
	FROM platos
	WHERE estado = '1'
	ORDER BY idplato DESC;
END $$

CALL spu_platos_listar()


-- REGISTRAR PLATO
DELIMITER $$
CREATE PROCEDURE spu_platos_registrar(
	IN _nombrePlato VARCHAR(25),
	IN _descripcion VARCHAR(150),
	IN _ingredientes VARCHAR(70),
	IN _nacionalidadPlato VARCHAR(70),
	IN _precio DECIMAL(7,2),
	IN _porciones INT,
	IN _tiempoPrepacion VARCHAR(30)
)
BEGIN
	INSERT INTO platos (
		nombrePlato,
		descripcion,
		ingredientes,
		nacionalidadPlato,
		precio,
		porciones,
		tiempoPrepacion
	) VALUES (
		_nombrePlato,
		_descripcion,
		_ingredientes,
		_nacionalidadPlato,
		_precio,
		_porciones,
		_tiempoPrepacion
	);
END $$

CALL spu_platos_registrar("Arroz con Pollo", "Plato típico peruano de arroz con pollo", "arroz, pollo, cebolla, ajo, zanahoria", "Peru", 10.50, 3, "45 minutos");



--  ELIMINAR PLATO O ACTUALIZAR ESTADO POR ESTADO 
DELIMITER $$
CREATE PROCEDURE spu_platos_eliminar(IN _idplato INT,IN _estado CHAR(1))
BEGIN
    UPDATE platos 
    SET estado = _estado
    WHERE idplato = _idplato;
END $$

CALL spu_platos_eliminar(2,'0');


--  ELIMINAR PLATO CON DELETE
DELIMITER $$
CREATE PROCEDURE spu_platos_eliminar(IN _plato INT) BEGIN DELETE FROM platos WHERE idplato = _plato;
END $$

--  ACTUALIZAR PLATOS
DELIMITER $$
CREATE PROCEDURE spu_platos_actualizar(
	IN _idplato INT,
	IN _nombrePlato VARCHAR(25),
	IN _descripcion VARCHAR(150),
	IN _ingredientes VARCHAR(70),
	IN _nacionalidadPlato VARCHAR(70),
	IN _precio DECIMAL(7,2),
	IN _porciones INT,
	IN _tiempoPrepacion VARCHAR(30)
)
BEGIN
	UPDATE platos
    --  Si _nombrePlato no es nulo y no es una cadena vacía,
    --  entonces se asigna el valor de _nombrePlato a nombrePlato.
    --  En caso contrario, si alguna de las dos condiciones es falsa el valor se mantiene
	SET	nombrePlato = if(_nombrePlato IS NOT NULL AND _nombrePlato <> '', _nombrePlato, nombrePlato),
		descripcion = if(_descripcion IS NOT NULL AND _descripcion <> '', _descripcion, descripcion),
        ingredientes = if(_ingredientes IS NOT NULL AND _ingredientes <> '', _ingredientes, ingredientes),
        nacionalidadPlato = if(_nacionalidadPlato IS NOT NULL AND _nacionalidadPlato <> '', _nacionalidadPlato, nacionalidadPlato),
        precio = if(_precio IS NOT NULL AND _precio <> '', _precio, precio),
        porciones = if(_porciones IS NOT NULL AND _porciones <> '', _porciones, porciones),
        tiempoPrepacion = if(_tiempoPrepacion IS NOT NULL AND _tiempoPrepacion <> '', _tiempoPrepacion, tiempoPrepacion)
	WHERE idplato = _idplato;
END $$


CALL spu_platos_actualizar(1, NULL, 'La carapulcra peruana es un plato típico de la gastronomía peruana', NULL, NULL, NULL, 5, NULL);
CALL spu_platos_registrar(
	"Asado de Tira",
	"Plato argentino de carne asada",
	"costillas de res, sal, pimienta",
	"Argentina",
	25.99,
	2,
	"60 minutos"
);

--  =============================
SELECT * FROM platos;


--  VOLVEMOS AL DELIMITADOR DE SENTENCIAS PREDETERMINADO
DELIMITER ; 

