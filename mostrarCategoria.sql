USE [dbVentas]
GO
/****** Object:  StoredProcedure [dbo].[spMostrarCategoria]    Script Date: 20/09/2022 12:05:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[spMostrarCategoria]
@dato varchar(30)
as
begin
	set nocount on;
	if @dato is null
	select * from Categoria
	else
	if exists (select * from Categoria where nombre=@dato or convert (varchar(30),idCategoria)=@dato)
	select * from Categoria where Nombre=@dato or convert (varchar(30),idCategoria)=@dato;
	else
	select 'Categoria no existe'
end