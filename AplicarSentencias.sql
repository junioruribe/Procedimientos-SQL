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

--3. Realice consulta que muestre el valor de venta m�nima m�s alto que tiene asignado un trabajador

Select *
from vendedor
where VentaMin=(
Select Max(VentaMin)
from vendedor)

update Operacion set Empresa=4010 where Empresa=5030
update Asesoria set Empresa=4010 where Empresa=5030
update vendedor set Empresa=4010 where Empresa=5030

--4. Realice consulta me muestre el nombre y la cantidad de asesor�as realizada por cada asesor.
Select Nombres,count(*) as 'cantidad de asesorias'
from asesor inner join Asesoria  on IdAsesor=asesor
group by Nombres

--5 Realice consulta que muestre informaci�n de los primeros 5 pa�ses con el menor n�mero de habitantes. Mostrar los resultados ordenados ascendentemente por el n�mero de habitantesSelect *
select top 5 *
from Pais 
order by Habitantes asc



--6 Realice consulta que muestre por cada pa�s las suma y el promedio de los habitantes de las ciudades que hacen parte de ese pa�s.
select Pais,Pais.Nombre, SUM(Ciudad.Habitantes)as'SUMA',AVG(Ciudad.Habitantes)as PROMEDIO 
from Pais inner join Ciudad on idPais=Pais
group by Pais, Pais.Nombre


--7 Realice consulta me muestre la cantidad de asesor�as realizada por cada asesor en cada uno de las �reas. Ordene descendentemente los asesores por su nombre
select Area,Nombre,Nombres, COUNT(*) as 'cantidad de asesorias'
from Asesor inner join Asesoria on IdAsesor=asesor inner join Area on IdArea=Area
group by Area,Nombre,Nombres
order by Nombres desc

--8 Realice sentencia SQL que permita habilitar (Estado = A) el asesor identificado con el c�digo 8888
update asesor set Estado='A' where IdAsesor=8888

select *
from asesor

--9.Realice sentencia SQL que permita cambiar la sede de la empresa identificada con c�digo 5050. La nueva sede de la empresa ser� la ciudad identificada con el c�digo C571
update Empresa set Sede='C571' where IdEmpresa=5050
select *
from Empresa

--10.Realice sentencia SQL que permita actualizar el c�digo de la empresa BBVA por el c�digo 6090
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

--12.Realice sentencia SQL que permita actualizar la fecha de inicio de la asesor�a realizada por el asesor
--1111 a la empresa 5030 en el �rea 40. La nueva fecha a establecer es 20/10/1998
update Asesoria set FechaInicio='20/10/1998'
where asesor=1111 and Empresa= 4010 and area =40
select*
from Asesoria

--13.Realice sentencias que permita cambia la ciudad sede de la empresa Jumbo, la nueva sede ser� la
--ciudad de Madrid
update ciudad set Nombre ='ciudad de madrid'
where Nombre='RioJaneiro'

update Empresa set Sede=(select idCiudad from Ciudad 
						where Nombre='madrid')
where Nombre='Jumbo'
					
select*
from Ciudad