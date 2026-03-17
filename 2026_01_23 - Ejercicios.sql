/* Calcula el número total de productos que hay en la tabla productos */
SELECT COUNT(*) FROM producto;

/* Calcula el precio más alto, el más bajo, el precio medio de la tabla de productos. Usa alias para cada medida */
SELECT MAX(precio) AS PMAX, MIN(precio) AS PMIN, AVG(precio) AS MEDIA FROM producto;

/* Calcula el número de productos que tiene el fabricante Asus */
SELECT COUNT(*)
FROM producto, fabricante
WHERE producto.id_fabricante = fabricante.id
AND fabricante.nombre = "Asus";

/* Calcula la media del precio de todos los productos del fabricante Asus */
SELECT ROUND(AVG(precio),0) AS MEDIA
FROM producto, fabricante
WHERE producto.id_fabricante = fabricante.id
AND fabricante.nombre = "Asus";

/* Muestra el número total de productos que tiene cada uno de los fabricantes. El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. Ordene el resultado descendentemente por el número de productos */
SELECT fabricante.nombre, COUNT(producto.id) AS Total
FROM producto, fabricante
WHERE producto.id_fabricante = fabricante.id
GROUP BY(fabricante.nombre)
ORDER BY Total DESC;

/* Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. El resultado mostrará el nombre del fabricante junto con los datos que se solicitan */
SELECT MAX(producto.precio) AS PMAX, MIN(producto.precio) PMIN, ROUND(AVG(producto.precio),0) AS MEDIA, fabricante.nombre
FROM producto, fabricante
WHERE producto.id_fabricante = fabricante.id
GROUP BY(fabricante.nombre);

/* Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. No es necesario mostrar el nombre del fabricante, con el identificador del fabricante es suficiente */
SELECT MAX(precio) AS PMAX, MIN(precio) AS PMIN, ROUND(AVG(precio),0) AS MEDIA, id_fabricante
FROM producto
GROUP BY(id_fabricante)
HAVING MEDIA > 200;

/* Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes de los productos que tienen un precio superior a 200€. No es necesario mostrar el nombre del fabricante, con el identificador del fabricante es suficiente */
SELECT MAX(precio) AS PMAX, MIN(precio) AS PMIN, ROUND(AVG(precio),0) AS MEDIA, id_fabricante
FROM producto
WHERE precio > 200
GROUP BY(id_fabricante);

/* Calcula el número de productos que tienen un precio mayor o igual a 180€ */
SELECT COUNT(producto.id) AS TOTAL
FROM producto
WHERE producto.precio >= 180;

/* Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€ */
SELECT fabricante.nombre, AVG(producto.precio) AS MEDIA
FROM producto, fabricante
WHERE producto.id_fabricante = fabricante.id
GROUP BY(fabricante.nombre)
HAVING MEDIA >= 150;

/* Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos */
SELECT COUNT(fabricante.nombre) AS TOTAL, fabricante.nombre
FROM producto, fabricante
WHERE producto.id_fabricante = fabricante.id
GROUP BY(fabricante.nombre)
HAVING TOTAL >= 2;

/* Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición */
SELECT fabricante.nombre, COUNT(producto.id) AS TOTAL
FROM producto, fabricante
WHERE producto.id_fabricante = fabricante.id
AND producto.precio >= 220
GROUP BY(fabricante.nombre);

/* Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 € */
SELECT fabricante.nombre, SUM(producto.precio) AS SUMA
FROM fabricante, producto
WHERE fabricante.id = producto.id_fabricante
GROUP BY(fabricante.nombre)
HAVING SUMA >= 1000;

/* Calcula el número de empleados que no tienen NULL en su segundo apellido */
SELECT COUNT(*)
FROM empleado
WHERE empleado.apellido2 IS NOT NULL;

/* Calcula el número de empleados que hay en cada departamento. Tienes que devolver dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados. */
SELECT COUNT(empleado.id) AS TOTAL, departamento.nombre AS DEPARTAMENTO
FROM empleado, departamento
WHERE empleado.id_departamento = departamento.id
GROUP BY departamento.nombre;

/* Calcula el número de empleados que trabajan en cada unos de los departamentos que tienen un presupuesto mayor a 200000 euros */
SELECT COUNT(empleado.id) AS TOTAL, departamento.nombre, departamento.presupuesto
FROM departamento, empleado
WHERE departamento.id = empleado.id_departamento
GROUP BY(departamento.nombre)
HAVING departamento.presupuesto > 200000;

/* Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y total */
SELECT MAX(pedido.total) AS TOTAL, comercial.nombre, comercial.apellido1, comercial.apellido2
FROM pedido, comercial
WHERE pedido.id_comercial = comercial.id
AND pedido.fecha = "2016-08-17"
GROUP BY (comercial.id);

/* Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes. */
SELECT cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2, COUNT(pedido.id) AS pedido
FROM cliente, pedido
WHERE pedido.id_cliente = cliente.id
GROUP BY(cliente.id);

/* Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes durante el año 2017 */
SELECT cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2, COUNT(pedido.id) AS PEDIDOS
FROM cliente, pedido
WHERE pedido.id_cliente = cliente.id
AND YEAR(pedido.fecha) = 2017
GROUP BY(cliente.id);

/* Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año */
SELECT MAX(pedido.total) AS TOTAL, YEAR(pedido.fecha) AS anno
FROM pedido
GROUP BY(anno);

/* Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno */
SELECT empleado.nombre, COUNT(cliente.codigo_cliente) AS TOTAL_CLIENTES
FROM empleado, cliente
WHERE empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
GROUP BY(empleado.codigo_empleado);

/* Calcula el número de productos diferentes que hay en cada uno de los pedidos */
SELECT COUNT(detalle_pedido.codigo_producto) AS PRODUCTOS, detalle_pedido.codigo_pedido
FROM detalle_pedido
GROUP BY(detalle_pedido.codigo_producto);

/* La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores. */
SELECT SUM(cantidad * precio_unidad) AS Base_Imponible,
SUM(cantidad * precio_unidad) * 0.21 AS IVA,
SUM(cantidad * precio_unidad) * 1.21 AS TOTAL
FROM detalle_pedido;

/* Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos */
SELECT SUM(total), YEAR(fecha_pago) AS anno
FROM pago
GROUP BY(anno);

/* Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado */
SELECT fabricante.nombre
FROM fabricante LEFT JOIN producto
ON fabricante.id = producto.id_fabricante
WHERE producto.nombre IS NULL;

/* Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. Este listado también debe incluir los empleados que no tienen ningún departamento asociado */
SELECT empleado.*
FROM empleado LEFT JOIN departamento
ON empleado.id_departamento = departamento.id;

/* Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado */
SELECT empleado.*, departamento.nombre AS DEPARTAMENTO
FROM empleado LEFT JOIN departamento
ON empleado.id_departamento = departamento.id
WHERE departamento.id IS NULL;

/* Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido */
SELECT cliente.*
FROM cliente LEFT JOIN pedido
ON cliente.id = pedido.id_cliente
WHERE pedido.id IS NULL;

/* Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago */
SELECT DISTINCT cliente.*
FROM cliente LEFT JOIN pago
ON cliente.codigo_cliente = pago.codigo_cliente
INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pago.codigo_cliente IS NULL;

/* Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido */
SELECT cliente.*
FROM cliente LEFT JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
LEFT JOIN pago
ON cliente.codigo_cliente = pago.codigo_cliente
WHERE pedido.codigo_pedido IS NULL
AND pago.codigo_cliente IS NULL;

/* Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada */
SELECT empleado.*
FROM empleado LEFT JOIN oficina
ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE oficina.codigo_oficina IS NULL;

/* Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan */
SELECT empleado.*, oficina.*
FROM empleado LEFT JOIN cliente
ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
INNER JOIN oficina
ON oficina.codigo_oficina = empleado.codigo_oficina
WHERE cliente.codigo_empleado_rep_ventas IS NULL;

/* Devuelve un listado de los productos que nunca han aparecido en un pedido */
SELECT producto.*
FROM producto LEFT JOIN detalle_pedido
ON detalle_pedido.codigo_producto = producto.codigo_producto
WHERE detalle_pedido.codigo_producto IS NULL;

/* Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales */
SELECT oficina.* , empleado.*
FROM oficina LEFT JOIN empleado
ON empleado.codigo_oficina = oficina.codigo_oficina
INNER JOIN cliente
ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
INNER JOIN detalle_pedido
ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
INNER JOIN producto
ON detalle_pedido.codigo_producto = producto.codigo_producto
WHERE empleado.codigo_empleado IS NULL AND producto.gama = "Frutales";

/* Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo */
SELECT producto.*
FROM producto
WHERE precio >= (
	SELECT MAX(precio)
    FROM producto, fabricante
    WHERE fabricante.id = producto.id_fabricante
    AND fabricante.nombre = "Lenovo"
);

/* Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos */
SELECT producto.*
FROM producto, fabricante
WHERE fabricante.id = producto.id_fabricante
AND fabricante.nombre = "Asus" 
AND producto.precio >=(
    SELECT AVG(producto.precio)
    FROM producto, fabricante
    WHERE fabricante.id = producto.id_fabricante
    AND fabricante.nombre = "Asus"
);

