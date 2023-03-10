USE [dbVentas]
GO
/****** Object:  StoredProcedure [dbo].[guardarCategoria]    Script Date: 22/09/2022 4:10:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[guardarCategoria]
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
		set @msg='Categoria Guardada correctamente';
END
	else
		set @msg='No existe el codigo'+@id;
	select @msg AS Resultado;
END