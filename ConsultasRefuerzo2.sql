select * from tipocuenta
-- crear funcion que busque nombre tipo de cuenta
alter function fnNombreTipoCuenta (@id int)
returns varchar(25)
AS
begin
	declare @nom varchar(25);
	set  @nom=(select Nombre from TipoCuenta where idTipo=@id);
	return @nom; 
end

select dbo.fnNombreTipoCuenta(2)

------------------------------------------------------------------------------------------------
--crear funcion que busque codigo tipo cuenta
create function fnCodigoTipoCuenta (@nom varchar(25))
returns int
AS
begin
	declare @id int;
	set  @id=(select idTipo from TipoCuenta where Nombre=@nom);
	return @id; 
end

select dbo.fnCodigoTipoCuenta('ahorro')

----------------------------------------------------------------------------------------------------
--1)registrar cuenta
create procedure spCuenta

@tipo varchar(30),
@idcli int,
@idsucu int,
@saldo int

as
begin
	set nocount on;
	insert into Cuenta(Tipo,IdCliente,IdSucursal,Saldo,Fecha)
	values(dbo.fnCodigoTipoCuenta(@tipo),@idcli,@idsucu,@saldo,GETDATE());
	if @@ROWCOUNT>0
	select 'Producto registro exitosamente';
	else
	Select 'Error al registrar cuenta'
end

select* from Cuenta
exec spRegitrarCuenta 'ahorro',2258,222,20000
-------------------------------------------------------------------------------------------------------
--2)registrar prestamo
create procedure spRegistrarPrestamo

@idsucursal int,
@idcli int ,
@vr float
As
Begin
	set nocount on;
	insert into Prestamo(IdSucursal,IdCliente,Fecha,Valor)
	values(@idsucursal,@idcli,GETDATE(),@vr);
	if @@ROWCOUNT>0
	select 'Prestamos registrado exitosamente';
	else
	Select 'Error al registrar el Prestamo'
end

exec spRegistrarPrestamo 222,4518,1000000
--------------------------------------------------------------------------------------------------------------
--4)registrar sucursal
create procedure spRegistrarSucursal
@idsucur int,
@nom varchar (50),
@ciud varchar (30)
As
Begin
	set nocount on;
	declare @msg varchar (50)
	if exists (select * from Sucursal where Nombre=@nom or IdSucursal=@idsucur)
begin
	set @msg=concat ('la sucursal ',@nom,'',' ya existe');
end
else
begin
	if exists (select * from Sucursal where IdSucursal=@idsucur)
	begin
		set @msg=concat ('El idsucursal ',@idsucur,'',' ya existe');
end
	else
begin
	insert into Sucursal(IdSucursal,Nombre,Ciudad)
	values(@idsucur,@nom,@ciud);
	set @msg='sucursal registrada exitosamente';
End
end
select @msg as Resultado;
end

exec spRegistrarSucursal 111,'San javier','Medellin'
--------------------------------------------------------------------------------------------
--3)Registrar cliente
create procedure spRegistrarCliente
@idclien int,
@nom varchar (30),
@apell varchar (30),
@tel varchar (30)
as
begin
	set nocount on;
	insert into Cliente(IdCliente,Nombre,Apellido,Telefono)
	values(@idclien,@nom,@apell,@tel);
	if @@ROWCOUNT>0
	select 'Cliente registrado exitosamente';
	else
	Select 'Error al registrar el Cliente'
end

exec spRegistrarCliente 4444,'junior','cañola','57584'
---------------------------------------------------------------------------------------------------
--5)consultar cuenta por idcliente , fecha o por tipo cuenta
go
alter procedure spConsultarCuenta
@dato varchar (30)

As
Begin
   set nocount on;
   select * from cuenta
   where convert(varchar(30),IdCliente)=@dato
	or convert(varchar(30),Fecha)=@dato
	or Tipo=dbo.fnCodigoTipoCuenta(@dato)
 end
     exec spConsultarCuenta '2020-07-20'
--------------------------------------------------------------------------------------------
--6) consultar imformacion de transacciones realizadas por un cliente dado (idcliente) en una cuenta dada(idcuenta)
alter procedure spBuscarTransa
@dato int
as
begin
	set nocount on;
	select Transacciones.*
	from Cliente C inner join Cuenta Cu on C.IdCliente= Cu.IdCliente inner join Transacciones  on Cu.IdCuenta=Transacciones.Idcuenta
	where Cu.IdCliente=@dato
	or Cu.IdCuenta=@dato
end

exec spBuscarTransa 2258
---------------------------------------------------------------------------------------------
--7)consultar los pagos realizados al prestamos xxxx
alter procedure spBuscarPago
@idprest int
as
begin
	
	select *
	from pago
	where idprestamo=@idprest

end

exec  spBuscarPago 555

-------------------------------------------------------------------------------------
--8)consulte el cliente,idprestamo, y la suma de los pagos para cada prestamo
alter procedure spBuscarsumaPago
as 
begin
	select IdCliente,Prestamo.IdPrestamo, sum(pago.valor) as valor 
	from Prestamo  inner join pago on prestamo.IdPrestamo=pago.idprestamo
	group by IdCliente,Prestamo.IdPrestamo
end

exec spBuscarsumaPago 