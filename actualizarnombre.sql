USE [dbVentas]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarNombreCliente]    Script Date: 29/09/2022 13:05:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[ActualizarNombreCliente]
@nom varchar(30),
@idVenta int
AS
BEGIN
SET nocount on;
	Declare @msg varchar(50);
	if exists(select * from Venta where idVenta=@idVenta)
	BEGIN
		update Venta
		set Cliente= @nom
		where idVenta=@idVenta
		set @msg='Cliente Actualizado correctamente';
	END
	else
		set @msg='No existe el Cliente'+@nom;
	select @msg AS Resultado;
END