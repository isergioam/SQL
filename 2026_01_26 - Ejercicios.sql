/* Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada. Sin hacer uso de MIN, ORDER BY ni LIMIT */

SELECT departamento.nombre, departamento.presupuesto
FROM departamento
WHERE departamento.presupuesto <= ALL(SELECTdepartamento.presupuesto FROM departamento);

/* Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando IN o NOT IN) */
SELECT departamento.nombre
FROM departamento
WHERE departamento.id IN (SELECT empleado.id_departamento
							FROM empleado);

/* Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. (Sin utilizar INNER JOIN) */
SELECT *
FROM pedido
WHERE pedido.id_cliente = ( SELECT cliente.id
                           FROM cliente
                           WHERE cliente.nombre = "Adela"
                           AND cliente.apellido1 = "Salas"
                           AND cliente.apellido2 = "Díaz");

/* Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han realizado un pedido durante el año 2017 con un valor mayor o igual al valor medio de los pedidos realizados durante ese mismo año */
SELECT cliente.*, pedido.*
FROM cliente INNER JOIN pedido
ON cliente.id = pedido.id_cliente
WHERE YEAR(pedido.fecha) = 2017
AND pedido.total >= (
    SELECT AVG(pedido.total)
    FROM pedido
    WHERE YEAR(pedido.fecha) = 2017
                   );
/* Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL */
SELECT comercial.nombre
FROM comercial
WHERE comercial.id != ALL(SELECT pedido.id_comercial
                     FROM pedido);


/* Devuelve el nombre del cliente con mayor límite de crédito */
SELECT cliente.nombre_cliente
FROM cliente 
WHERE cliente.limite_credito >= ALL(SELECT cliente.limite_credito FROM cliente);

/* Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN) */
SELECT cliente.nombre_cliente
FROM cliente
WHERE cliente.limite_credito >= (
    SELECT SUM(pago.total)
    FROM pago
	WHERE cliente.codigo_cliente = pago.codigo_cliente
);

/* Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria */
SELECT empleado.nombre, empleado.apellido1, empleado.apellido2, empleado.email
FROM empleado
WHERE empleado.codigo_jefe = (SELECT empleado.codigo_empleado
                             FROM empleado
                             WHERE empleado.nombre = "Alberto"
                             AND empleado.apellido1 = "Soria");

/* Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago (Usando IN o NOT IN) */
SELECT cliente.*
FROM cliente
WHERE cliente.codigo_cliente NOT IN(SELECT pago.codigo_cliente
                               FROM pago
                               );

/* Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago */
SELECT cliente.*
FROM cliente
WHERE cliente.codigo_cliente IN (
    SELECT pedido.codigo_cliente
	FROM pedido)
    AND cliente.codigo_cliente NOT IN (
    SELECT pago.codigo_cliente
    FROM pago);
