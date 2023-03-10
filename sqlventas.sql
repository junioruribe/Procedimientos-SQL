USE [master]
GO
/****** Object:  Database [dbVentas]    Script Date: 21/09/2022 12:07:24 ******/
CREATE DATABASE [dbVentas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbVentas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\dbVentas.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbVentas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\dbVentas_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dbVentas] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbVentas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbVentas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbVentas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbVentas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbVentas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbVentas] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbVentas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbVentas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbVentas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbVentas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbVentas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbVentas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbVentas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbVentas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbVentas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbVentas] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbVentas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbVentas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbVentas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbVentas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbVentas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbVentas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbVentas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbVentas] SET RECOVERY FULL 
GO
ALTER DATABASE [dbVentas] SET  MULTI_USER 
GO
ALTER DATABASE [dbVentas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbVentas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbVentas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbVentas] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [dbVentas] SET DELAYED_DURABILITY = DISABLED 
GO
USE [dbVentas]
GO
/****** Object:  UserDefinedFunction [dbo].[fGetId]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fGetId]()
returns int
as
begin
declare @id int
set @id=(select max(idventa) from venta)
if @id is null
set @id=1;

return @id
end
GO
/****** Object:  UserDefinedFunction [dbo].[fnBuscarIdCategoria]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fnBuscarIdCategoria](@nom varchar(30))
returns int
begin
	declare @id int;
	set  @id=(select idCategoria from categoria where Nombre=@nom);
	return @id;
end
GO
/****** Object:  UserDefinedFunction [dbo].[fnBuscarNombreCategoria]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fnBuscarNombreCategoria](@id int)
returns varchar(30)
begin
	declare @nom varchar(30);
	set  @nom=(select Nombre from categoria where idCategoria=@id);
	return @nom;
end
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categoria](
	[idCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
	[Estado] [char](1) NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleVenta]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleVenta](
	[idVenta] [int] NOT NULL,
	[idProducto] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[vrUnitario] [int] NOT NULL,
	[vrDescuento] [float] NOT NULL,
 CONSTRAINT [PK_DetalleVenta] PRIMARY KEY CLUSTERED 
(
	[idVenta] ASC,
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Producto]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Producto](
	[idProducto] [int] NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
	[Categoria] [int] NOT NULL,
	[Vencimiento] [date] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Valor] [int] NOT NULL,
	[Descuento] [float] NOT NULL,
	[Imagen] [varchar](50) NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Venta](
	[idVenta] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Cliente] [varchar](30) NOT NULL,
	[Empleado] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Venta] PRIMARY KEY CLUSTERED 
(
	[idVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[DetalleVenta]  WITH CHECK ADD  CONSTRAINT [FK_DetalleVenta_Producto] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Producto] ([idProducto])
GO
ALTER TABLE [dbo].[DetalleVenta] CHECK CONSTRAINT [FK_DetalleVenta_Producto]
GO
ALTER TABLE [dbo].[DetalleVenta]  WITH CHECK ADD  CONSTRAINT [FK_DetalleVenta_Venta] FOREIGN KEY([idVenta])
REFERENCES [dbo].[Venta] ([idVenta])
GO
ALTER TABLE [dbo].[DetalleVenta] CHECK CONSTRAINT [FK_DetalleVenta_Venta]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_Producto_Categoria] FOREIGN KEY([Categoria])
REFERENCES [dbo].[Categoria] ([idCategoria])
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [FK_Producto_Categoria]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarProducto]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ActualizarProducto]
@id int,
@nom varchar (30),
@cat int,
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
		set @msg='Producto Actualizado correctamente';
END
	else
		set @msg='No existe el Producto'+@id;
	select @msg AS Resultado;
END
GO
/****** Object:  StoredProcedure [dbo].[spActualizarCategoria]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spActualizarCategoria]
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
GO
/****** Object:  StoredProcedure [dbo].[spBuscar]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spBuscar]
@nom varchar(30)
As
Begin
	select *
	from categoria
	where nombre=@nom
end
GO
/****** Object:  StoredProcedure [dbo].[spBuscarTodos]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spBuscarTodos]
As
Begin
	select *
	from categoria
end
GO
/****** Object:  StoredProcedure [dbo].[spConsultarCategoria]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spConsultarCategoria]
@dato varchar (30)
as
begin
	set nocount on;
	if @dato is null
	select * from Producto
	else
	if exists (select * from Producto where nombre=@dato or convert (varchar(30),idProducto)=@dato)
	select * from Producto where Nombre=@dato or convert (varchar(30),idProducto)=@dato;
	else
	select 'Producto no existe'
end
GO
/****** Object:  StoredProcedure [dbo].[spListarInformacion]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spListarInformacion]
@dato varchar (50)
as
begin
	set nocount on;
	if exists (select * from Producto where Nombre=@dato or CONVERT(varchar(50),idProducto)=@dato)
	select idProducto,Producto.Nombre,Categoria.Nombre,Cantidad,Valor,Descuento
	from Producto inner join Categoria on idCategoria=Categoria
	 Where Producto.Nombre=@dato or CONVERT(varchar (50),idProducto)=@dato;
	else
	select CONCAT('el Producto',@dato,'no se encuentra registrado')
end
GO
/****** Object:  StoredProcedure [dbo].[spMostrarCategoria]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spMostrarCategoria]
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
GO
/****** Object:  StoredProcedure [dbo].[spMostrarCategorias]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spMostrarCategorias]
as
begin
set nocount on;
	select Nombre from Categoria
end
GO
/****** Object:  StoredProcedure [dbo].[spMostrarProducto]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spMostrarProducto]
@dato varchar (30)
as
begin
	set nocount on;
	if @dato is null
	select idProducto,Nombre,dbo.fnBuscarNombreCategoria(Categoria),Vencimiento,Cantidad,Valor,Descuento,Imagen,Estado
	 from Producto
	else
	if exists (select * from Producto where nombre=@dato or convert (varchar(30),idProducto)=@dato)
	select idProducto,Nombre,dbo.fnBuscarNombreCategoria(Categoria),Vencimiento,Cantidad,Valor,Descuento,Imagen,Estado
	 from Producto where Nombre=@dato or convert (varchar(30),idProducto)=@dato;
	else
	select 'Producto no existe'
end
GO
/****** Object:  StoredProcedure [dbo].[spMostrarVenta]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spMostrarVenta]
as
begin
	select idventa,fecha,cliente,empleado
	from Venta
end
GO
/****** Object:  StoredProcedure [dbo].[spMostrarVentaymas]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spMostrarVentaymas]
@id int
as
begin
	select v.idVenta,Cliente,Fecha,p.Nombre,vrUnitario,d.Cantidad,vrDescuento,vrUnitario*d.Cantidad as SubTotal
	from Producto p inner join DetalleVenta d
		on p.idProducto=d.idProducto  inner join Venta v
		on d.idVenta=v.idVenta 
	where v.idVenta=@id
end
GO
/****** Object:  StoredProcedure [dbo].[spRegistrarCategoria]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRegistrarCategoria]
@nom varchar(30),
@esta char(1)
As
Begin
	declare @msg varchar(40);
	insert into categoria(nombre,estado) values(@nom,@esta);
	set @msg = 'Categoria registrada exitosamente';
	select @msg as Resultado;
end
GO
/****** Object:  StoredProcedure [dbo].[spRegistrarDetalle]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spRegistrarDetalle]
@idprod  int,
@cant   int,
@vrUni	int,
@vrdesc	float
AS
Begin
	insert into DetalleVenta(idVenta,idProducto,Cantidad,vrUnitario,vrDescuento)
	values(dbo.fGetId(),@idprod,@cant,@vrUni,@vrdesc);
End
GO
/****** Object:  StoredProcedure [dbo].[spRegistrarProducto]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spRegistrarProducto]
@id int,
@nom varchar(30),
@cat varchar(30),
@vencimiento date,
@cant int,
@vr	int,
@desc float,
@img varchar(50),
@esta bit
AS
Begin
	set nocount on;
	declare @msg varchar(50);
	if exists (select * from Producto where Nombre=@nom)
	begin
		set @msg=concat ('El Producto ',@nom,'',' ya existe');
	end
	else
	begin
	if exists (select * from Producto where idProducto=@id)
		begin
		set @msg=concat ('El Producto ',@id,'',' ya existe');
	end
	else
	begin
		insert into producto values (@id,@nom,dbo.fnBuscarIdCategoria(@cat),@vencimiento,@cant,@vr,@desc,@img,@esta);
		set @msg='Producto registro exitosamente';
	
	End
end
select @msg as Resultado;
end
GO
/****** Object:  StoredProcedure [dbo].[spRegistrarVenta]    Script Date: 21/09/2022 12:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spRegistrarVenta]
@cliente   varchar(30),
@emple		varchar(30)
AS
Begin
	set nocount on;
	declare @mensaje varchar(50);
	insert into Venta(fecha,cliente,empleado)
	values(GETDATE(),@cliente,@emple);
	if @@ROWCOUNT>0
	set @mensaje =CONCAT('Venta ',dbo.fGetId(), ' Venta registrada exitosamente');
	else
	set @mensaje='error no se registro la venta'
	Select @mensaje AS Respuesta;
End
GO
USE [master]
GO
ALTER DATABASE [dbVentas] SET  READ_WRITE 
GO
