USE [master]
GO

CREATE DATABASE [JN_DB]
GO

USE [JN_DB]
GO

CREATE TABLE [dbo].[Usuario](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Identificacion] [varchar](15) NOT NULL,
	[Nombre] [varchar](250) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[Contrasenna] [varchar](50) NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[Usuario] ON 
GO
INSERT [dbo].[Usuario] ([Id], [Identificacion], [Nombre], [Correo], [Contrasenna], [Estado]) VALUES (1, N'304590415', N'Eduardo Calvo Castillo', N'ecalvo90415@ufide.ac.cr', N'o7ZFK+0vH7H7CzFhUIz2ig==', 1)
GO
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO

ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [Uk_Correo] UNIQUE NONCLUSTERED 
(
	[Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [Uk_Identificacion] UNIQUE NONCLUSTERED 
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE PROCEDURE [dbo].[IniciarSesion]
	@Identificacion varchar(15),
	@Contrasenna varchar(50)
AS
BEGIN
	
	SELECT	Id,Identificacion,Nombre,Correo,Estado
	FROM	dbo.Usuario
	WHERE   Identificacion = @Identificacion
		AND Contrasenna = @Contrasenna
		AND Estado = 1

END
GO

CREATE PROCEDURE [dbo].[RegistrarCuenta]
	@Identificacion varchar(15),
	@Nombre varchar(250),
	@Correo varchar(100),
	@Contrasenna varchar(50)
AS
BEGIN
	
	IF NOT EXISTS(SELECT 1 FROM dbo.Usuario 
				  WHERE Identificacion = @Identificacion
					 OR Correo = @Correo)
	BEGIN

		INSERT INTO dbo.Usuario(Identificacion,Nombre,Correo,Contrasenna,Estado)
		VALUES (@Identificacion,@Nombre,@Correo,@Contrasenna,1)

	END

END
GO