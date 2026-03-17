/* Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos */

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto, fabricante
WHERE producto.id_fabricante = fabricante.id;

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id;

/* Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético */

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto, fabricante
WHERE producto.id_fabricante = fabricante.id ORDER BY fabricante.nombre;

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id ORDER BY fabricante.nombre;

/* Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato */

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto, fabricante
WHERE producto.id_fabricante = fabricante.id ORDER BY producto.precio AS LIMIT 1

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id ORDER BY producto.precio AS LIMIT 1

/* Devuelve una lista de todos los productos del fabricante Lenovo */

SELECT producto.* FROM producto INNER JOIN fabricante ON producto.id_fabricante = fabricante.id AND fabricante.nombre = "Lenovo";

SELECT producto.* FROM producto INNER JOIN fabricante ON producto.id_fabricante = fabricante.id AND fabricante.nombre IN ("Lenovo");

SELECT producto.* FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id AND fabricante.nombre = "Lenovo";

SELECT producto.* FROM producto, fabricante WHERE producto.id_fabricante = fabricante.id AND fabricante.nombre IN ("Lenovo");

/* Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€. */

SELECT producto.* FROM producto INNER JOIN fabricante ON producto.id_fabricante = fabricante.id AND fabricante.nombre IN ("Crucial") AND producto.precio > 200;


/* Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate */

SELECT producto.*, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.id_fabricante = fabricante.id AND fabricante.nombre IN ("Asus", "Hewlett-Packard", "Seagate");

/* Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente) */

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto, fabricante
WHERE producto.id_fabricante = fabricante.id AND producto.precio >= 180
ORDER BY producto.precio DESC, producto.nombre ASC;

/* Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados */

SELECT empleado.*, departamento.id
FROM empleado, departamento
WHERE empleado.id_departamento = departamento.id
ORDER BY departamento.nombre, empleado.apellido1, empleado.apellido2, empleado.nombre;


/* Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M */

SELECT departamento.nombre
FROM empleado, departamento
WHERE empleado.id_departamento = departamento.id AND empleado.nif = "38382980M";

/* Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana */
SELECT departamento.nombre
FROM empleado, departamento
WHERE empleado.id_departamento = departamento.id 
AND empleado.nombre = "Pepe"
AND empleado.apellido1 = "Ruiz"
AND empleado.apellido2 = "Santana";

/* Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente. */

SELECT empleado.* 
FROM empleado, departamento 
WHERE empleado.id_departamento = departamento.id AND departamento.nombre = "I+D"
ORDER BY empleado.nombre;

/* Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros */

SELECT empleado.*
FROM empleado, departamento
WHERE empleado.id_departamento = departamento.id
AND departamento.presupuesto NOT BETWEEN 100000 AND 200000;

/* Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos. */

SELECT DISTINCT departamento.nombre
FROM empleado, departamento
WHERE empleado.id_departamento = departamento.id
AND empleado.apellido2 IS NULL;

/* Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos. */

SELECT DISTINCT cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2
FROM cliente, pedido
WHERE cliente.id = pedido.id_cliente
ORDER BY cliente.nombre;

/* Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido */

SELECT cliente.*, pedido.*, comercial.*
FROM cliente, pedido, comercial
WHERE pedido.id_cliente = cliente.id AND pedido.id_comercial = comercial.id
ORDER BY cliente.nombre;

/* Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 € */

SELECT cliente.*
FROM cliente, pedido
WHERE pedido.id_cliente = cliente.id
AND YEAR(pedido.fecha) = 2017
AND pedido.total BETWEEN 300 AND 1000;

/* Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno */

SELECT DISTINCT comercial.*, cliente.nombre
FROM pedido, comercial, cliente
WHERE pedido.id_comercial = comercial.id AND pedido.id_cliente = cliente.id
AND cliente.nombre = "María"
AND cliente.apellido1 = "Santana"
AND cliente.apellido2 = "Moreno";


/* Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de venta */

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2
FROM cliente, empleado
WHERE cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

/* Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante. */

SELECT DISTINCT cliente.nombre_cliente, empleado.nombre, oficina.ciudad
FROM cliente, empleado, pago, oficina
WHERE cliente.codigo_cliente = pago.codigo_cliente
AND empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
AND oficina.codigo_oficina = empleado.codigo_oficina;

/* Lista la dirección de las oficinas que tengan clientes en Fuenlabrada */

SELECT oficina.*
FROM oficina, empleado, cliente
WHERE empleado.codigo_oficina = oficina.codigo_oficina
AND empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
AND cliente.ciudad = "Fuenlabrada";

/* Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante */

SELECT DISTINCT cliente.nombre_cliente, empleado.nombre, oficina.ciudad
FROM empleado, cliente, oficina
WHERE empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
AND empleado.codigo_oficina = oficina.codigo_oficina;

/* Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes */

SELECT emp.nombre, jefe.nombre
FROM empleado emp, empleado jefe
WHERE emp.codigo_jefe = jefe.codigo_empleado;

/* Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido */

SELECT cliente.nombre_cliente
FROM pedido, cliente
WHERE pedido.codigo_pedido = cliente.codigo_cliente
AND pedido.fecha_entrega > pedido.fecha_esperada;

/* Devuelve el listado de los clientes que han realizado pedidos en el año 2009 */

SELECT cliente.*, pedido.fecha_pedido
FROM pedido, cliente
WHERE pedido.codigo_cliente = cliente.codigo_cliente
AND YEAR (pedido.fecha_pedido) = 2009;

/* Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas */

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2
FROM cliente INNER JOIN empleado
ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

/* Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas */

SELECT cliente.nombre_cliente
FROM cliente INNER JOIN pago
ON cliente.codigo_cliente = pago.codigo_cliente
INNER JOIN empleado
ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

/* Lista la dirección de las oficinas que tengan clientes en Fuenlabrada */

SELECT oficina.*
FROM oficina INNER JOIN empleado
ON empleado.codigo_oficina = oficina.codigo_oficina
INNER JOIN cliente
ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE cliente.ciudad = "Fuenlabrada";

