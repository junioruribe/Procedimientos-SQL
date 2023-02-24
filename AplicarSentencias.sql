-- 1)insertar un registro en la tabla pais con el nuevo idpais y el resto de datos de pais a actualizar.
insert into Pais(idPais,Nombre,Capital,Habitantes)
select 100,Nombre,Capital,Habitantes
from Pais
where idPais =99
--consulta de la tabla
select *
from Ciudad

--2. Realice consulta que muestre por cada empresa la cantidad de vendedores. Ordene las empresas ascendentemente por el nombre
SELECT Empresa,Nombre,count(*) AS 'CANTIDAD DE VENDEDORES'
FROM vendedor inner join Empresa on IdEmpresa=Empresa 
GROUP BY Empresa,Nombre
ORDER By Nombre

--3. Realice consulta que muestre el valor de venta mínima más alto que tiene asignado un trabajador

Select *
from vendedor
where VentaMin=(
Select Max(VentaMin)
from vendedor)

update Operacion set Empresa=4010 where Empresa=5030
update Asesoria set Empresa=4010 where Empresa=5030
update vendedor set Empresa=4010 where Empresa=5030

--4. Realice consulta me muestre el nombre y la cantidad de asesorías realizada por cada asesor.
Select Nombres,count(*) as 'cantidad de asesorias'
from asesor inner join Asesoria  on IdAsesor=asesor
group by Nombres

--5 Realice consulta que muestre información de los primeros 5 países con el menor número de habitantes. Mostrar los resultados ordenados ascendentemente por el número de habitantesSelect *
select top 5 *
from Pais 
order by Habitantes asc



--6 Realice consulta que muestre por cada país las suma y el promedio de los habitantes de las ciudades que hacen parte de ese país.
select Pais,Pais.Nombre, SUM(Ciudad.Habitantes)as'SUMA',AVG(Ciudad.Habitantes)as PROMEDIO 
from Pais inner join Ciudad on idPais=Pais
group by Pais, Pais.Nombre


--7 Realice consulta me muestre la cantidad de asesorías realizada por cada asesor en cada uno de las áreas. Ordene descendentemente los asesores por su nombre
select Area,Nombre,Nombres, COUNT(*) as 'cantidad de asesorias'
from Asesor inner join Asesoria on IdAsesor=asesor inner join Area on IdArea=Area
group by Area,Nombre,Nombres
order by Nombres desc

--8 Realice sentencia SQL que permita habilitar (Estado = A) el asesor identificado con el código 8888
update asesor set Estado='A' where IdAsesor=8888

select *
from asesor

--9.Realice sentencia SQL que permita cambiar la sede de la empresa identificada con código 5050. La nueva sede de la empresa será la ciudad identificada con el código C571
update Empresa set Sede='C571' where IdEmpresa=5050
select *
from Empresa

--10.Realice sentencia SQL que permita actualizar el código de la empresa BBVA por el código 6090
update Empresa set IdEmpresa=6090 where Nombre='BBVBA'

select *
from Empresa

--11.Realice sentencia SQL que permita eliminar la empresa BBVA
insert into Empresa(IdEmpresa,Nombre,FechaIngreso,ObjVenta,Sede,Estado)
select 5031,'temporal',fechaIngreso,ObjVenta,Sede,'I'
from Empresa
where IdEmpresa=5030
update Operacion set Empresa=5031 where empresa=5030
update Asesoria set Empresa=5031 where empresa=5030
update vendedor set Empresa=5031 where empresa=5030
delete from empresa where IdEmpresa=5030
select*
from Operacion

--12.Realice sentencia SQL que permita actualizar la fecha de inicio de la asesoría realizada por el asesor
--1111 a la empresa 5030 en el área 40. La nueva fecha a establecer es 20/10/1998
update Asesoria set FechaInicio='20/10/1998'
where asesor=1111 and Empresa= 4010 and area =40
select*
from Asesoria

--13.Realice sentencias que permita cambia la ciudad sede de la empresa Jumbo, la nueva sede será la
--ciudad de Madrid
update ciudad set Nombre ='ciudad de madrid'
where Nombre='RioJaneiro'

update Empresa set Sede=(select idCiudad from Ciudad 
						where Nombre='madrid')
where Nombre='Jumbo'
					
select*
from Ciudad