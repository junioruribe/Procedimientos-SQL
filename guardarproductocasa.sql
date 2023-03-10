USE [dbVentas]
GO
/****** Object:  StoredProcedure [dbo].[GuardarProducto]    Script Date: 22/09/2022 4:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[GuardarProducto]
@id int,
@nom varchar (30),
@cat varchar (30),
@ven date,
@can int,
@valor int,
@desc float,
@imag varchar (50),
@esta bit
AS
BEGIN
SET nocount on;
	Declare @msg varchar(50);
	if exists(select * from Producto where idProducto=@id)
BEGIN
		update Producto
		set Nombre= @nom,Categoria=(dbo.fnBuscarIdCategoria(@cat)),Vencimiento=@ven,Cantidad=@can,Valor=@valor,Descuento=@desc,Imagen=@imag,Estado=@esta
		where idProducto=@id;
		set @msg='Producto guardado correctamente';
END
	else
		set @msg='No existe el Producto'+@id;
	select @msg AS Resultado;
END