*********** SQL *************  21/01/2026

DDL  Lenguaje de definición
DML  Manejo de datos


CRU Create Read Update

//-------------------------------- SENTENCIAS

* Añadir:

INSERT INTO empleados (nombre, apellido, salario)
	VALUES ('Juan', 'Pérez', 3000), ('Juan', 'Pérez', 3000), ('Juan', 'Pérez', 3000);

* Actualizar:

UPDATE nombre_tabla 
	SET columna1 = valor1, valor2, valor3
	WHERE condición;

UPDATE empleados 
	SET salario = 50000, departamento = 'Ventas' 
	WHERE id = 1;

* Eliminar:

DELETE FROM nombre_tabla
	WHERE condición;


//----------------------------- CONSULTAS

1 CONSULTA 1 Tabla

SELECT *
FROM employees
WHERE hire_date > '2020-01-30';

SELECT FROM ORDER BY ASC LIMIT;

DISTINCT Elimina los valores repetidos
ORDER BY Ordena por defecto ASC
LIMIT Saca sólo la cantidad que se indica.
OFF SET Paginación.
BETWEEN Saca datos entre valores.
IN Saca los valores especificos de una lista.
IS es para IS NULL por ejemplo.

Representa la segunda e _e%