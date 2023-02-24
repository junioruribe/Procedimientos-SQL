USE [dbVentas]
GO
/****** Object:  StoredProcedure [dbo].[spActualizarCategoria]    Script Date: 20/09/2022 10:34:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[spActualizarCategoria]
@id int,
@nom varchar (30),
@esta char (1)
AS
BEGIN
	SET nocount on;
	Declare @msg varchar(50);
	if exists(select * from Categoria where idCategoria=@id)
BEGIN
		update Categoria
		set Nombre= @nom, Estado= @esta
		where idCategoria=@id;
		set @msg='Categoria Actualizada correctamente';
END
	else
		set @msg='No existe el codigo'+@id;
	select @msg AS Resultado;
END

exec