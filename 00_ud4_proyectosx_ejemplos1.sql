/*EJEMPLOS UNIDAD 4 - REALIZACIÓN DE CONSULTAS */
/* ----------------------------------------------*/

show databases; -- listar las bases de datos

USE proyectosx; -- poner en uso proyectosx
show tables;    -- mostrar tablas de proyectosx
describe empleado; -- describir la estructura de la tabla empleado


/* Contenido de todas las tablas*/
-- mostrar todas las columnas y filas de la tabla empleado
SELECT * FROM empleado;
-- mostrar todas las columnas y filas de la tabla departamento
SELECT * FROM departamento;
-- igual para proyecto y trabaja
SELECT * FROM proyecto;
SELECT * FROM trabaja;

-- 1) Listar el nombre de todos los empleados
SELECT nombre 
FROM empleado;

/*alias para la columna, 
se indica con AS o sin AS, 
con comillas o sin comillas(sólo si el alias es de una sola palabra) */

-- 2) Nombre de los empleados utilizando como alias de columna 'Nombre empleado'
SELECT nombre  'Nombre Empleado'
FROM empleado;

-- 3)Nombre de los empleados utilizando alias de columna con AS
SELECT nombre as 'Nombre empleado' 
FROM empleado;

/*SIN ALIAS*/
-- 4) Listado del nombre, salario y código del jefe de todos los empleados
SELECT nombre, salario, cdjefe 
FROM empleado;

-- 5) Con ALIAS 'Jefe' para el códgo del jefe

SELECT nombre, salario, cdjefe as'Jefe'
FROM empleado;

/*Uso de expresiones en la SELECT*/
-- Ejemplo usando funciones (las funiones las iremos viendo psoco a poco)
-- Consulta el año de ingreso más reciente de los empleados:
SELECT MAX(YEAR(fecha_ingreso))
FROM empleado;

-- 6) mostrar el resultado de restar 12-2 y dividirlo entre 2+3
SELECT (12-2)/(2+3);
SELECT 12-2/2+3; -- se evalúa de forma diferente

-- 7) mostrar el resultado de incrementar 50 en un 21% de IVA con ALIAS 'calculado'
SELECT 50 + 21*50/100 as'calculado';

-- 8) Listado del nombre de cada empleado, su salario 
-- y su salario incrementado en 5% => consulta calculada

SELECT nombre, salario, salario+salario*5/100 'salario con 5%' 
FROM empleado;

/*** Alias de tabla -- LO VEREMOS Y USAREMOS CON CONSULTAS A VARIAS TABLAS****
Se trata de un nombre, generalmente más corto, que se utiliza sobre todo cuando consultamos varias tablas y hay nombres de columnas que coinciden. En este caso se conoce como alias de tabla.

Por ejemplo, para listar el nombre de cada empleado y 
el nombre de su departamento:
*/
SELECT e.nombre 'empleado',  d.nombre 'departamento'
FROM empleado e, departamento d
WHERE e.cddep=d.cddep;

/****cláusula WHERE ****
filtra o selecciona las filas que 
cumplen la condición o criterio indicado */

-- en la condición se pueden utilizar OPERADORES y PREDICADOS

/*OPERADORES (algunos de ellos): 
aritméticos: +, -, *, /
relacionales:>, <, =, >=, <=, <> O !=
lógicos: NOT, AND, OR

PREDICADOS:
patrones de busqueda: [NOT]LIKE patrón (%, _)
pertenencia a un conjunto: [NOT] IN (valor1, valor2,...)
rango de valores: [NOT] BETWEEN valor1 AND valor2
comprobación null: IS NULL, IS NOT NULL
*/

/* OPERADORES relacionales: >, <, =, >=, <=, <>*/
-- permiten realizar comparaciones

/* 9) Empleados con salario superior a 1000 euros, su nombre y salario*/
SELECT nombre, salario 
FROM empleado 
WHERE salario > 1000;


-- 10)Nombre de los empleados del departamento '04'
SELECT nombre 
FROM empleado 
WHERE cddep= '04';

describe empleado; -- cddep es tipo cadena, luego se pone '04' y no 04

-- 11) Nombre de los empleados que no están en el departamento 04
SELECT nombre, cddep
FROM empleado
WHERE cddep<>'04';


-- 12)Nombre y salario de los empleados con salario inferior a 2000 

SELECT nombre, salario
FROM empleado
WHERE salario <2000; 

-- 13) codigo empleado, salario y salario incrementado en un 5% de 
-- los empleados que ganan 2000 o menos euros

SELECT cdemp, salario, salario*1.05 'salario incrementado 5%'
FROM empleado
WHERE salario<=2000;


-- ¿Consulta anterior pero ordenando por salario, de menos a más salario?

/***** cláusula ORDER BY ******/
-- permite ordenar ascendentemente (ASC) o descendentemente (DESC) 
-- por un criterio o columna. Por defecto ordena ascendentemente. 

-- 14) Consulta anterior pero ordenando por salario, de menos a más salario
SELECT cdemp, salario, salario*1.05 'salario incrementado 5%'
FROM empleado
WHERE salario <=2000
ORDER BY salario;  -- por defecto orden ascendente

-- 15) 
/*Nombre y salario de los empleados con salario inferior a 2000 
ordenado de más a menos salario*/

SELECT nombre, salario
FROM empleado
WHERE salario <= 2000
ORDER BY salario DESC; 

-- 16) lo mismo, pero indicando la posición de la columna del orden 
-- en el ORDER BY
SELECT nombre, salario
FROM empleado
WHERE salario <= 2000
ORDER BY 2 DESC; 

-- 17) ordenando por varias columnas
/* Nombre de empleados y su código de departamento, 
ordenado primero por departamento y después por nombre. Ambas ascendente*/

SELECT nombre, cddep
FROM empleado
ORDER BY cddep, nombre; 

/*** EJERCICIO 1: la consulta anterior pero 
el orden del departamento descendente*/

/* 18) código, nombre y fecha de ingreso de empleados con 
-- fecha de ingreso anterior al 31-12-2000
-- ordenar por fecha_ingreso descendente*/
SELECT cdemp, nombre, fecha_ingreso
FROM empleado
WHERE fecha_ingreso < '2000-12-31'
ORDER BY 3 desc; -- observa que 3 es la posición de la columna fecha_ingreso


/* 19) nombre, departamento y salario de los empleados. 
Ordenado por salario, de más a menos salario*/
SELECT nombre, cddep, salario
FROM empleado
ORDER BY 3 DESC;  -- salario ocupa en la SELECT la posición 3

/* 20) código, nombre y salario de empleados, 
ascendente por nombre, descendente por salario*/

SELECT cdemp, nombre, salario 
FROM empleado
ORDER BY nombre, salario DESC; 


/*** EJERCICIO 2: nombre, departamento y salario de empleados con jefe 'A11'. 
Ordenar primero por departamento ascentende, después por nombre alfabéticamente
y luego por salario de más a menos 
*/




/* ***********************************
-- CLÁUSULA DISTINCT 
La cláusula DISTINCT suprime los resultados repetidos de la consulta, 
de forma que se muestren sólo los resultados distintos, 
es decir, cada resultado aparecerá en la consulta una sola vez. 
-- **************************************** */

/* 21) Departamentos en los que hay empleados. 
Observa que se repiten departamentos */
SELECT cddep
FROM empleado;

/*Sería mas correcto realizarla con DISTINCT*/
SELECT DISTINCT cddep
FROM empleado;

/* 22) código de empleados que trabajan 30 horas o más en algún proyecto*/ 
SELECT  cdemp 
FROM trabaja 
WHERE nhoras>=30;

/* 23) DISTINCT se aplica a la fila completa. Si escribimos:
 la consulta 22) mostrando también el proeycto, no se repetirían
 */
SELECT DISTINCT cdemp, cdpro
FROM trabaja
WHERE nhoras>=30;

-- Observa que se obtienen las combinaciones únicas de empleado y proyecto.

/*LIKE---para patrones de búsqueda de caracteres o cadenas. 
Símbolos comodín: _ y % 
- un carácter
% cualquier número de caracteres*/

-- 24) Datos de empleados con nombre que contenga la palabra 'verde' 
SELECT * 
FROM empleado 
WHERE nombre  LIKE '%VERDE%';

-- 25) Datos de empleados con nombre que NO contenga la palabra 'verde'
SELECT * 
FROM empleado 
WHERE nombre NOT LIKE '%VERDE%';

-- 26) Datos de empleados cuyo nombre NO contiene una 'a' en la segunda letra
SELECT *
FROM empleado
WHERE nombre NOT LIKE '_a%';

-- 27) Datos de empleados cuyo código de jefe termina en 1
SELECT *
FROM empleado
WHERE cdjefe LIKE '%1';

/*** EJERCICIO 3. Datos de departamentos cuya ciudad empieza por 'C'*/





/*IS [NOT] NULL---comprobación de valores nulos*/

-- 28) Datos de los empleados sin jefe 
SELECT * 
FROM empleado 
WHERE cdjefe is NULL;

-- 29) Datos de los empleados con jefe asignado
SELECT * 
FROM empleado 
WHERE cdjefe IS NOT NULL;

/*** EJERCICO 4: datos de empleados sin departamento */





/* OPERADORES LÓGICOS: AND, OR, NOT */

/* 30) Empleados cuyo nombre comienza por A y salario es superior a 1000 euros*/
SELECT nombre, salario 
FROM empleado 
WHERE nombre LIKE 'A%' AND salario>1000; 

-- Observa que las dos condiciones se deben cumplir. 
-- Si solo fuera una de esas condiciones, lo haráimaos con OR
-- Empleados cuyo nombre comienza por A o el salario es superior a 1000 euros
SELECT nombre, salario 
FROM empleado 
WHERE nombre LIKE 'A%' OR salario>1000; 

/* 31) negando alguna parte: su nombre no comienza por A, salario mayor de 1000 
y son del departamento 03*/

SELECT nombre, salario, cddep
FROM empleado 
WHERE  nombre NOT LIKE 'A%' AND salario>1000 and cddep ='03'; 

/* 32) nombre y código de los empleados cuyo código comienza con una letra cualquiera y 
después un 1 y luego cualquier carácter*/

SELECT nombre, cdemp
FROM empleado
WHERE cdemp LIKE '_1%'; 

/* 33) Todos los datos de los empleados 
del departamento 02 y jefe A07*/
SELECT * 
FROM empleado 
WHERE cddep='02' AND cdjefe='A07';

/* 34) Todos los datos de los empleados que 
no pertenecen al departamento 02*/
SELECT * 
FROM empleado 
WHERE  cddep <>'02';


/*** EJERCICO 5: datos de empleados con salario menor de 2000€, 
del departamento 03 cuyo nombre tiene en segunda posición una A
ordenado de más a menos salario*/






/* predicado IN: pertenencia a un conjunto de valores*/

/* 35) EJERCICIO resuelto: datos de los departamentos cuya ciudad es 
Sevilla o Cádiz */
SELECT cddep, nombre, ciudad 
FROM departamento
WHERE ciudad IN ('SEVILLA', 'CÁDIZ');

-- 36) es equivalente a : 
SELECT cddep, nombre, ciudad 
FROM departamento
WHERE ciudad = 'SEVILLA' OR  ciudad LIKE 'Cádiz';
-- en comparaciones de cadenas en términos de igualdad 
-- se puede utilizar = o LIKE

/* 37) Datos de los departamentos que no son de Sevilla o Cadiz*/
SELECT cddep, nombre, ciudad 
FROM departamento
WHERE ciudad not IN ('SEVILLA', 'CÁDIZ');


/* 38) Listado de empleados del departamento 01, 02 o 04*/
SELECT * 
FROM empleado 
WHERE cddep='02' OR cddep ='04' OR cddep ='01';

SELECT * 
FROM empleado 
WHERE cddep IN ('02', '04','01');


/* 39) nombre y ciudad de todos los departamentos menos 
los de Sevilla y Granada*/
SELECT nombre, ciudad
FROM departamento
WHERE ciudad NOT IN ('Sevilla', 'Granada'); 

/***** EJERCICIO 6: Datos de los empleados que NO tienen como jefes 
a A11, B06 o A03*/






/* 40) nombre de empleados con salario menor o igual a 2000 o superior 2500 euros*/
SELECT nombre, salario
FROM empleado
WHERE salario <=2000 OR salario>2500; 

/* 41) nombre de empleados que ganan entre 1000 y 2000 euros, 
incluidos límites*/

SELECT nombre, salario
FROM empleado
WHERE salario >=1000 AND salario<=2000; 
/*Lo habitual es usar BETWEEN en estos casos*/


-- predicado BETWEEN: para rangos de valores incluidos límites,
-- se puede usar con cualquier tipo de dato


/* 42) nombre de empleados que ganan entre 1000 y 2000 euros, 
incluidos límites*/
SELECT nombre, salario
FROM empleado
WHERE salario BETWEEN 1000 AND 2000;

-- 43) lo contario, cuyo salario no está en ese rango
SELECT nombre, salario
FROM empleado
WHERE nombre NOT BETWEEN 1000 AND 2000;

/* 44) nombre de empleados que ganan entre 1000 y 2000 euros, 
incluidos límites ordenados de menos a más salario*/
SELECT nombre, salario
FROM empleado
WHERE salario BETWEEN 1000 AND 2000
ORDER BY salario; 

-- 45) nombre y fecha de empleados dados de alta entre el 1995 y 2005, 
-- incluidos esos años

SELECT nombre, fecha_ingreso
FROM empleado
WHERE fecha_ingreso >= '1995-01-01' AND fecha_ingreso <='2005-12-31';

-- o usando BETWEEN 

SELECT nombre, fecha_ingreso
FROM empleado
WHERE fecha_ingreso BETWEEN '1995-01-01' AND '2005-12-31';

-- incluso mejor, usando la función YEAR() de fechas

SELECT nombre, fecha_ingreso
FROM empleado
WHERE YEAR(fecha_ingreso) BETWEEN 1995 AND 2005;


/***** EJERCICIO 7: código de empleado, de proyecto y horas trabajadas en el proyecto,
para aquellos empleados que han trabajado entre 5 y 15 horas*/





/**** uso de paréntesis en expresiones para forzar evaluación*/

/* 46) Empleados que trabajan en proyecto DAG o bien 
trabajan en GRE con 15 o más horas trabajadas*/
SELECT * 
FROM trabaja 
WHERE cdpro='DAG' OR (cdpro='GRE' AND nhoras>=15);

/* 47) Empleados que llevan trabajadas 15 o más horas
en los proyectos DAG o GRE*/
SELECT * 
FROM trabaja 
WHERE (cdpro='DAG' OR cdpro='GRE') AND nhoras>=15;



/* 48) Datos de empleados del departamento 03 o 04
y con jefe A11*/
SELECT *
FROM empleado
WHERE cddep IN ('04', '03') AND cdjefe='A11';


/* 49) ¿sería correcta esta otra forma de hacerlo?*/
SELECT *
FROM empleado
WHERE cddep  = '04' OR cddep= '03' AND cdjefe='A11';




/*Observa que faltan paréntesis para forzar el orden de evaluación
de los operadores AND y OR*/


SELECT *
FROM empleado
WHERE (cddep  = '04' OR cddep= '03') AND cdjefe='A11';


/***** EJERCICIO 8: datos de empleados con Jefe A11 o A03 
y de departamento 03 o 04 */





/******** CONSULTAS DE RESUMEN ******/
-- Obtiene resultados de operar con columnas utilizando alguna 
-- de las funciones de agregado

/*FUNCIONES DE AGRAGADO O AGREGACIÓN: 
COUNT(), MIN(), MAX(),SUM(),AVG()
- realizan cálculos sobre columnas
- arg = columna o expresión
- Ignoran el valor NULL excepto COUNT()
SUM(arg): devuelve la suma - argumento Numérico
AVG(arg): devuelve la media - arg.  Numérico
MAX(arg): devuelve el máximo - arg. cualquier tipo
MIN(arg): devuelve el mínimo - arg. cualquier tipo
COUNT(arg): cuenta filas y devuelve el total contado - arg. cualquier tipo
si arg es NULL, no la cuenta
COUNT(*): cuenta todas las filas*/


/* 50) listar la suma de todos los salarios de los empleados*/
SELECT SUM( salario) 
FROM empleado;

/* 51) Listar el menor salario*/
SELECT MIN(salario) 
FROM empleado; 

/* 52) Fecha más antigua de ingreso*/
SELECT MIN(fecha_ingreso) 
FROM empleado;

/* 53) El mayor salario*/
SELECT MAX(salario) 
FROM empleado; 

/* 54) Fecha más actual de ingreso*/
SELECT date_format(MAX(fecha_ingreso), '%d-%m-%Y') 
FROM empleado;

/* 55) Salario medio de empleados*/
 SELECT AVG(salario) as 'Salario medio' 
 FROM empleado;
 
 
/* 56) Salario medio de empleados, con dos decimales*/ 
SELECT round(AVG(salario),2)  'Salariomedio'
FROM empleado;

/* 57) Salario máximo y mínimo de empleados y total de empleados*/
SELECT MAX(salario) 'salario máximo', MIN(salario), COUNT(*) 'total', Max(fecha_ingreso) fechareceinte
FROM empleado; 

/* 58)Total de empleados*/
SELECT COUNT(*) 
FROM empleado;

/* 59) EJERCICIO: total empleados con departamento asignado*/
SELECT COUNT(*) 
FROM empleado 
WHERE cddep IS NOT NULL;

-- o bien
SELECT COUNT(cddep) -- si cddep es NULL, count() no lo cuenta
FROM empleado;


/***** EJERCICIO 9: total de horas trabajas en proyectos, 
menor y mayor número de horas trabajadas en algún proyecto */





/* 60) empleado con menor salario de la empresa 
¿es correcta la siguiente solución?*/
SELECT nombre, MIN(salario) 'salario'
FROM empleado;
-- observa si se corresponde ese salario mínimo con el de ese empleado
select nombre, salario
from empleado
where nombre like 'Pedro Rojo';


-- Lo correcto sería con una subconsulta:
SELECT nombre, salario
FROM empleado 
WHERE salario =(SELECT MIN(salario) FROM empleado);


-- 61) se pueden poner varias funciones de agregado en la misma SELECT
SELECT avg(salario) SalarioMedio, MIN(salario) MinimoSalario, MAX(salario) as 'Máximo Salario', sum(salario) TotalSalarios
from empleado;


 
/************ GROUP BY ************/
/*Muy util combinar las  funciones de agregación con cláusula GROUP BY*/
/*Con GROUP BY: se  agrupan filas por un valor común en una  o más columnas*/
/*en este caso es posible mezclar F. agregación con expr. simples que aparecen 
en group by

/* 62) Total de empleados por departamento. 
Se muestra el código y el total*/
SELECT cddep, count(*) 
FROM empleado 
GROUP BY cddep;

/* 63) código de departamento y su total de empleados con salario superior 
a 1500€*/

SELECT cddep, COUNT(*) 
FROM empleado 
WHERE salario > 1500 and cddep is not null
GROUP BY cddep; 


/*EJERCICIOS CLASE*/
/* 64) Empleados por jefe, mostrando el código de jefe 
y total empleados, ordenado de más a menos empleados*/
select cdjefe, count(*) as 'empleados'
from empleado
where cdjefe is not null
group by cdjefe
order by 2 desc;

-- o bien

SELECT cdjefe 'jefe', COUNT(*) 'empleados'
from empleado
where cdjefe is not null
group by cdjefe
order by count(*) desc;

/* 65) Salario medio por departamento, 
mostrando la media y código departamento*/

SELECT cddep, round(AVG(salario),0) 'Salario  medio'
from empleado
where cddep is not null
group by cddep;

-- 66) ordenar de más a menos salario medio
select cddep, round(AVG(salario),2) 'salario medio'
from empleado
group by cddep
order by 2 desc;


/* 67) Total de ciudades diferentes en las que hay  Departamentos */

/*DISTINCT Cuenta los valores diferentes 
y que no son NULL*/
SELECT COUNT(distinct ciudad) 
FROM departamento;


/* 68) Nombre de las ciudades en las que hay departamentos*/
SELECT DISTINCT ciudad -- distinct para no mostrar filas repetidas
FROM departamento;

/* 69) Total de ciudades en las que hay departamentos*/
SELECT COUNT(DISTINCT ciudad) AS 'Total ciudades con departamento'
FROM departamento;



/*HAVING permite filtrar o seleccionar grupos realizados con GORUP BY
-- HAVING va asociado por tanto a GROUP BY
-- Tras HAVING se pone la condición de filtrado de filas*/


/* 70) código de departamento y total de empleados, sólo los 
departamentos con más de 2 empleados y con salario superior a 1500€*/

SELECT cddep, COUNT(*) 'total empleados'
FROM empleado 
WHERE salario > 1500 
GROUP BY cddep 
-- HAVING filtra los departamentos con más de 2 empleados en esas condiciones
 HAVING COUNT(*) >2;


/*HAVING y WHERE
- WHERE filtra antes de agrupar y no admite funciones de agregado
- HAVING filtra agrupamientos hechos con GROPUP BY
*/

/* 71) código y total de empleados de 
los departamentos que tienen más de un empleado 
cuyo jefe es el A11,*/
SELECT cddep, COUNT(*) as 'Empleados'
FROM empleado 
WHERE cdjefe='A11'
GROUP BY cddep
HAVING COUNT(*)>1
;

/*Sin filtrar*/
SELECT cddep, COUNT(cdemp) as 'Empleados'
FROM empleado 
WHERE cdjefe='A11'
GROUP BY cddep;


/*en WHERE no se admiten F. agregación- ERROR
WHERE filtra antes de hacer el agrupamiento.*/

SELECT cddep, COUNT(cdemp) 
FROM empleado 
WHERE cdjefe='A11' AND COUNT(cdemp)>1
GROUP BY cddep; 

/*OBSERVACIONES*/

/*1.- NO se pueden combinar F. agregacion con otras expresiones, 
como columnas simples, NO TIENE SENTIDO el resultado*/

/* 72) Empleado con menor fecha de ingreso y su jefe y departamento???? 
/*NO arroja resultados correctos*/
SELECT cdemp, nombre, MIN(fecha_ingreso),  cdjefe, cddep 
FROM empleado; 

SELECT * FROM empleado
ORDER BY fecha_ingreso;

/*se haría mediante una subconsulta*/
SELECT  cdemp, nombre, fecha_ingreso, cdjefe 
FROM empleado
WHERE fecha_ingreso = (SELECT MIN(fecha_ingreso) FROM empleado);


/*2.- Proyectar varias funciones de agregación SI tiene sentido*/

/* 73) Fechas más antigua y mas reciente de ingreso de empleados*/
SELECT MIN(fecha_ingreso), MAX(fecha_ingreso) 
FROM empleado; 

/* 74) Total empleados, empleados con departamento asignado 
y fecha de ingreso mas antigua y reciente*/
SELECT COUNT(*), COUNT(cddep), MIN(fecha_ingreso), 
MAX(fecha_ingreso) 
FROM empleado; /*Si tiene sentido*/



/*3.- Muy util combinar las  funciones de agregación con cláusula GROUP BY*/
/*Con GROUP BY: se  agrupan filas por un valor común en uno  o más campos*/
/*en este caso es posible mezclar F. agregación con expr. simples que aparecen 
en group by*/

/* 75) Total de horas trabajadas por cada empleado
en proyectos*/
SELECT cdemp,sum(nhoras)
from trabaja
group by cdemp;




/* 76) Total de horas trabajadas en cada proyecto*/
/*con GROUP BY, si tiene sentido poner 
la columna objeto de agrupación en la SELECT junto a f. agregación*/
SELECT cdpro, SUM(nhoras) 
FROM trabaja 
GROUP BY cdpro;

/* 77) total horas trabajadas por cada empleado que trabaja
mostrando código de empleado y horas trabajadas
ordenado de más a menos horas*/

SELECT cdemp,  SUM(nhoras) 
FROM trabaja 
GROUP BY cdemp
ORDER BY 2 DESC;



/* 78) EJERCICIO como antes, pero  mostrando 
 solo aquellos que han trabajado entre 15 y 100 horas en total*/
SELECT cdemp,  SUM(nhoras) 
FROM trabaja 
GROUP BY cdemp
HAVING SUM(nhoras) BETWEEN 15 AND 100
ORDER BY 2 DESC
;


/* 79) EJERCICIO: 
y si se quiere mostrar también el nombre del empleado? => 
se necesita combinar tablas, trabaja y empleado*/

SELECT t.cdemp, e.nombre, SUM(t.nhoras) 'Horas trabajadas'
FROM trabaja t
INNER JOIN empleado e ON t.cdemp=e.cdemp
GROUP BY t.cdemp
HAVING SUM(t.nhoras) BETWEEN 15 AND 100
ORDER BY 3 DESC;

/**** EJERCICIO 10: mostrar para cada departamento el total de empleados
con año de ingreso anterior a 1998. 
Solo los departamentos con 2 o más empleados 
y ordenado por de más a menos empleados*/




/***** Se pueden establecer diferentes niveles de agrupamiento*/

/* 80) total empleados por departamento y jefe*/
SELECT cddep, cdjefe, COUNT(cdemp) 
FROM empleado 
GROUP BY cddep,cdjefe
order by cddep;

SELECT * FROM empleado e;

/*Indicando posiciones en Group By*/

/* 81) total empleados por departamento y jefe*/
SELECT cddep, cdjefe, COUNT(cdemp) as 'total_empleados'
FROM empleado 
GROUP BY 1,cdjefe;



/* 82) total empleados por departamento y jefe. 
Para: departamentos con empleados y con jefe asignado
No se muestran valores NULL*/
SELECT cddep, cdjefe, COUNT(cdemp) 
FROM empleado 
WHERE cddep IS NOT NULL AND cdjefe IS NOT NULL
GROUP BY 1,2
order by cddep;





/*LIMIT***************/
/*Limitando el número de filas de una consulta a 2, 3, ...filas => con LIMIT */


/* 83) tres de los empleados más antiguos de la empresa*/
SELECT nombre, fecha_ingreso 
FROM empleado
ORDER BY fecha_ingreso 
LIMIT 3
 ;  /*LIMIT 0,3 */

/* 84) sin mostrar los empleados con fecha de ingreso desconocida*/
SELECT nombre, fecha_ingreso 
FROM empleado  
WHERE fecha_ingreso IS NOT NULL
ORDER BY fecha_ingreso  
LIMIT 3;


/* 85) los tres empleados más antiguos, después de los dos primeros*/
SELECT nombre, fecha_ingreso 
FROM empleado  
WHERE fecha_ingreso IS NOT NULL
ORDER BY fecha_ingreso 
LIMIT 2,3;

/* 86) Tres de los empleados que más ganan*/
select cdemp, nombre, salario
from empleado
order by salario desc
limit 3;



/* 87) dos de los empleados que más horas han trabajado en proyectos*/
SELECT cdemp, SUM(nhoras) 
FROM trabaja
GROUP BY cdemp
ORDER BY SUM(nhoras) DESC
LIMIT 2;   /* es lo mismo que LIMIT  0,2  */


/*************Algunas FUNCIONES SQL*******************************************/
-- Funciones numéricas
-- Funciones de cadena
-- Funciones de fechas
-- funciones de control

-- https://dev.mysql.com/doc/refman/8.0/en/functions.html

/**Funciones numéricas*/
SELECT ABS(-17); -- devuelve el valor absoluto

SELECT EXP(2); -- devuelve e (base de logaritmo neperiano) elevado a 2

SELECT CEIL(17.5);  -- entero más próximo a 17 y por exceso

SELECT FLOOR(17.6); -- entero más próximo a 17 y por defecto

SELECT MOD(15, 2); -- resto de dividir 15 entre 2

SELECT POWER(2, 3); -- potencia 2 elevado a 3

SELECT ROUND(12.5854, 2); -- redondea con 2 decimales
SELECT ROUND(12.7844); -- redondea al entero más próxmo
SELECT SQRT(25); -- raiz cuadrada

SELECT TRUNCATE(127.4567, 2); -- trunca sin más dos decimales

SELECT TRUNCATE(4572.5678, -2);

SELECT TRUNCATE(4572.5678, -1);

SELECT TRUNCATE(4572.5678, 0); -- trunca todos los decimales

SELECT SIGN(-23); -- indica el signo 

/**Funciones de caracteres**/
SELECT ASCII('O'); -- devuelve el ccódigo ASCII del carcater

SELECT CONCAT('Hola  ', 'Mundo'); -- concatena cadenas


Select CONCAT('Hola ',nombre) -- concatena cadenas
FROM empleado;

SELECT LOWER('En MInúsculAS'); -- pasa a minúsculas

SELECT UPPER('En MAyúsculAS'); -- pasa a mayúsculas

SELECT INSTR('Hola', 'ol'); -- busca la psoición de la subcadena 'ol'

SELECT RPAD('M', 5, '*'); -- rellena a derecha con 4 *

SELECT LPAD('M', 5, '*'); -- rellena a izquierda con 4 *

SELECT REPLACE('correo@gmail.es', 'es', 'com'); -- reemplaza subcadena 'es' por 'com'

SELECT SUBSTR('1234567', 3, 2); -- a partir de posición 3, coge 2 caaracteres

SELECT LENGTH('hola'); -- longitud de la cadena (número de carcateres)

SELECT TRIM(' Hola de nuevo '); -- elimina blancos a derecha e izquierda

SELECT LTRIM(' Hola'); -- elimina blancos a izquierda

SELECT RTRIM('Hola ');  -- elimina blancos a derecha 

/*Funciones de Fechas*/
SELECT CURDATE();  -- fecha actUal

SELECT CURRENT_DATE(); -- fecha actUal

SELECT NOW();  -- fecha y hora actuales

SELECT CURTIME(); -- hora actual

SELECT CURRENT_TIMESTAMP(); -- fecha y hora actuales

SELECT ADDDATE('2014-11-01', 5); -- suma 5 días a la fecha

SELECT DATEDIFF('2014-04-19','2014-04-2'); -- días entre las dos fechas

SELECT DATE_FORMAT('2014-04-19','%d-%m-%Y'); -- formato de fecha con año 4 dígitos

SELECT DATE_FORMAT('2014-04-19', '%d/ %m/ %y'); -- formato de fecha con año 2 dígitos

SELECT DAY('2014-12-19'); -- número de día de la fecha

SELECT MONTH('2014-07-20'); -- número de mes de la fecha

SELECT YEAR('2014-07-20'); -- año de la fecha

SELECT DAYNAME('2018-1-9'); -- nombre del día de la fecha

SELECT MONTHNAME('2014-12-19'); -- nombre del mes de la fecha

/*Funciones de conversión*/
SELECT CONVERT(21,DECIMAL(6,2)); -- convierte el 21 en decimal con 2 decimales

SELECT CAST(2221 AS DECIMAL(6,2));

/*Funciones de control*/
SELECT IFNULL(null,'No hay dato'); -- si primer parámetro nulo, se muestra el segundo
SELECT COALESCE(NULL, 'Sin dato'); -- igual que IFNULL

USE proyectosx;

SELECT nombre, IFNULL(cddep,'sin departamento') 
FROM empleado;

SELECT cdemp, nombre, IFNULL(fecha_ingreso,'sin fecha') 
FROM empleado;


SELECT IF(3>5, 'verdad','falso'); 