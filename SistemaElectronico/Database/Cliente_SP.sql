/* =========================================================
   Sistema de Facturacion - Procedimientos de Cliente
   Version corregida (alineada con la tabla Cliente)

   PROBLEMAS ENCONTRADOS EN LA VERSION ORIGINAL:
   1) sp_Insert_Cliente no guardaba cli_apellido ni cli_cedula.
   2) sp_Update_Cliente tenia "@cli_tipo=@cli_tipo" (asignacion de
      variable, no actualizacion de columna) y no actualizaba cli_cargo.
   3) La validacion de duplicados en UPDATE rechazaba el propio registro
      que se estaba editando (falso positivo por RNC).
   ========================================================= */

ALTER PROCEDURE dbo.sp_Insert_Cliente
(
    @cli_codigo    int,
    @cli_tipo      varchar(12),
    @cli_nombre    varchar(50),
    @cli_rnc       varchar(11),
    @cli_contacto  varchar(50),
    @cli_cargo     varchar(25),
    @cli_pagina    varchar(40),
    @cli_apellido  varchar(50),
    @cli_cedula    varchar(13),
    @cli_direccion varchar(30),
    @cli_telefono  varchar(12),
    @cli_celular   varchar(13),
    @cli_correo    varchar(65),
    @cli_pais      varchar(30),
    @cli_provincia varchar(30)
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Cliente
        (cli_codigo, cli_tipo, cli_nombre, cli_rnc, cli_contacto, cli_cargo,
         cli_pagina, cli_apellido, cli_cedula, cli_direccion, cli_telefono,
         cli_celular, cli_correo, cli_pais, cli_provincia)
    VALUES
        (@cli_codigo, @cli_tipo, @cli_nombre, @cli_rnc, @cli_contacto, @cli_cargo,
         @cli_pagina, @cli_apellido, @cli_cedula, @cli_direccion, @cli_telefono,
         @cli_celular, @cli_correo, @cli_pais, @cli_provincia);
END
GO

ALTER PROCEDURE dbo.sp_Update_Cliente
(
    @cli_codigo    int,
    @cli_tipo      varchar(12),
    @cli_nombre    varchar(50),
    @cli_rnc       varchar(11),
    @cli_contacto  varchar(50),
    @cli_cargo     varchar(25),
    @cli_pagina    varchar(40),
    @cli_apellido  varchar(50),
    @cli_cedula    varchar(13),
    @cli_direccion varchar(30),
    @cli_telefono  varchar(12),
    @cli_celular   varchar(13),
    @cli_correo    varchar(65),
    @cli_pais      varchar(30),
    @cli_provincia varchar(30)
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Cliente
       SET cli_tipo      = @cli_tipo,
           cli_nombre    = @cli_nombre,
           cli_rnc       = @cli_rnc,
           cli_contacto  = @cli_contacto,
           cli_cargo     = @cli_cargo,
           cli_pagina    = @cli_pagina,
           cli_apellido  = @cli_apellido,
           cli_cedula    = @cli_cedula,
           cli_direccion = @cli_direccion,
           cli_telefono  = @cli_telefono,
           cli_celular   = @cli_celular,
           cli_correo    = @cli_correo,
           cli_pais      = @cli_pais,
           cli_provincia = @cli_provincia
     WHERE cli_codigo = @cli_codigo;   /* el codigo es la PK: no se modifica */
END
GO

/* Duplicados excluyendo el registro que se esta editando.
   Devuelve 1 si otro cliente usa el mismo RNC, 0 en caso contrario. */
IF OBJECT_ID('dbo.sp_RegistroExiste_Cliente_Update', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_RegistroExiste_Cliente_Update;
GO

CREATE PROCEDURE dbo.sp_RegistroExiste_Cliente_Update
(
    @cli_codigo int,
    @cli_rnc    varchar(11)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CASE
             WHEN EXISTS (SELECT 1
                            FROM dbo.Cliente
                           WHERE cli_rnc = @cli_rnc
                             AND cli_codigo <> @cli_codigo)
             THEN 1 ELSE 0
           END AS Existe;
END
GO
