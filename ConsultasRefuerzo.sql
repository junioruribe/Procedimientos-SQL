--crear tablas ejn la base de datos
create table pago 
(
idpago int identity (1,2) primary key,
valor int not null,
fecha date not null,
idprestamo int not null,
foreign key(idprestamo) references prestamo(idprestamo)
)

--insertar valores en las tablas cliente,sucursal,prestamo,tipo de cuenta,cuenta,cajero,transacciones
insert into Cliente (Nombre,Apellido,Telefono,IdCliente)
values('sofia','velez','57584',1058)
insert into Cliente (Nombre,Apellido,Telefono,IdCliente)
values('felipe','perea','44448',4518)
insert into Cliente (Nombre,Apellido,Telefono,IdCliente)
values('bibian','ruiz','44548',2258)

insert into Sucursal values(111,'San javier','Medellin')
insert into Sucursal values(222,'chapinero','bogota')
insert into Sucursal values(333,'san tigo','cali')

insert into Prestamo(IdPrestamo,IdSucursal,IdCliente,Fecha,Valor)
values(555,333,2258,'2011/10/05',1000000)

insert into Prestamo(IdPrestamo,IdSucursal,IdCliente,Fecha,Valor)
values(444,222,4518,'2011/10/05',1000000)


insert into Prestamo(IdPrestamo,IdSucursal,IdCliente,Fecha,Valor)
values(666,333,4518,'2011/10/05',5300000)



insert into TipoCuenta(Nombre,Descripcion)
values('nomina','para pago')
insert into TipoCuenta values('corriente','para ahorrar')
insert into TipoCuenta values('ahorro','para no gastar')

insert into Cuenta values(1,2258,222,20000,'20/07/2021')
insert into Cuenta values(2,4518,111,500000,'20/07/2020')
insert into Cuenta values(3,1058,111,300000,'20/07/2020')

insert into Cajero values(222,'principal','cra11532a11')
insert into Cajero values(111,'centro','cra100#11a25')

insert into Transacciones values(1,1,'20/07/2020',1000000)
insert into Transacciones values(2,2,'20/07/2020',2000000)



-- el nombre del cliente,nombre sucursal,y valor del prestamo.
select C.nombre,S.nombre,P.valor
from Cliente C inner join Prestamo P 
on C.idCliente= p.IdCliente inner join Sucursal S on P.IdSucursal=P.IdSucursal

-- la informacion de los prestamos realizados en la sucursal =222
select *
from Prestamo
where IdSucursal=222

--la cantidad de cuenta que tengan saldo entre 100000 y 45000
select count(*) as cantidad
from Cuenta
where saldo between 100000 and 450000

--id sucursal, nombre y  la cantidad de prestamos que se alizaron en cada sucursal
select S.idSucursal, S.Nombre, count(*) as cantidad
from Prestamo P inner join Sucursal S on P.IdSucursal=s.IdSucursal
group by s.IdSucursal,S.Nombre







		






