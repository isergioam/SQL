/* EJERCICIOS */

/* 1. Lista el nombre de todos los productos que hay en la tabla producto. */
SELECT nombre, precio FROM producto

/* 2. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares. */
SELECT nombre, precio AS "€", ROUND (precio * 1.17,2) AS "$" FROM producto;

/* 3. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendolo a minuscula */
SELECT LOWER (nombre), precio FROM producto ;

/* 4. Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos. */
SELECT DISTINCT id_fabricante FROM producto;

/* 5. Devuelve una lista con las 5 primeras filas de la tabla fabricante */
SELECT * FROM fabricante LIMIT 5;

/* 6. Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2*/

SELECT nombre FROM producto WHERE id=2;

/* 7. Lista todos los productos que tengan un precio entre 80€ y 300€*/

SELECT * FROM producto WHERE precio >=80 AND precio <= 300;
SELECT * FROM producto WHERE precio BETWEEN 80 AND 300;

/* 8. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5 */

SELECT * FROM producto WHERE id_fabricante = 1 OR id_fabricante = 3 OR id_fabricante = 5;
SELECT * FROM producto WHERE id_fabricante IN 1, 3, 5;

/* 9. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w */

SELECT nombre FROM fabricante WHERE nombre LIKE "%w%";

/* 10. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres */

SELECT nombre FROM fabricante WHERE nombre LIKE "____";
SELECT nombre FROM fabricante WHERE LENGTH(nombre) = 4;

/* 11. Lista el nombre y los apellidos de todos los empleados */

SELECT nombre, apellido1, apellido2 FROM empleado;

/* 12. Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone. Para calcular este dato tendrá que restar al valor del presupuesto inicial (columna presupuesto) los gastos que se han generado (columna gastos). Tenga en cuenta que en algunos casos pueden existir valores negativos. Utilice un alias apropiado para la nueva columna columna que está calculando */

SELECT nombre, presupuesto - gasto AS PRESUPUESTO_ACTUAL FROM departamento;

/* 13. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto */

SELECT nombre, presupuesto FROM departamento ORDER BY presupuesto DESC LIMIT 3;

/* 14. Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros */

SELECT nombre, presupuesto FROM departamento WHERE presupuesto NOT BETWEEN 100000 OR 200000;

/* 15. Lista todos los datos de los empleados cuyo segundo apellido sea NULL */
SELECT * FROM empleado WHERE apellido2 IS NULL;

/* 16. Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno */
SELECT * FROM empleado WHERE apellido2 = "Díaz" OR apellido2 = "Moreno";
SELECT * FROM empleado WHERE apellido2 IN ("Díaz", "Moreno");

/* 17. Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5 */

SELECT nombre, apellido1, apellido2, nif, id_departamento FROM empleado WHERE id_departamento = 2 OR id_departamento = 4 OR id_departamento = 5; 

SELECT nombre, apellido1, apellido2, nif, id_departamento FROM empleado WHERE id_departamento IN (2, 4, 5);