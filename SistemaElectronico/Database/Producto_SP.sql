/* =========================================================
   Sistema de Facturacion - Procedimientos de Producto
   Version corregida (alineada con la tabla producto)

   PROBLEMAS ENCONTRADOS EN LA VERSION ORIGINAL:
   1) sp_Update_Producto asignaba pro_servicio = @pro_fisico
      (el parametro @pro_serviicio estaba declarado pero nunca usado).
   2) sp_Update_Producto usaba nombres inconsistentes:
      @pro_preciocompraRD, @pro_aplicaitebis, @contienecompra.
   3) sp_Insert_Producto declaraba @pro_status varchar(15) pero la
      columna es bit; ademas @pro_color era varchar(5) y la columna
      es varchar(15).
   4) No existia sp_ContarRegistro_Producto para generar el codigo.

   NOTA: la tabla conserva dos erratas historicas en sus columnas:
   pro_supridor (suplidor) y pro_referecia (referencia). Se mantienen
   por compatibilidad con los datos existentes.
   ========================================================= */

ALTER PROCEDURE dbo.sp_Insert_Producto
(
    @pro_codigo          int,
    @pro_nombre          varchar(50),
    @pro_fechacompra     date,
    @pro_preciocomprard  decimal(18,2),
    @pro_preciocompraus  decimal(18,2),
    @pro_bodega          varchar(25),
    @pro_ubicacion       varchar(25),
    @pro_status          bit,
    @pro_aplicaritebis   bit,
    @pro_fisico          bit,
    @pro_servicio        bit,
    @pro_ocacional       bit,
    @pro_cantidadinicial decimal(18,2),
    @pro_cantidadminima  decimal(18,2),
    @pro_fechaexpiracion date,
    @pro_supridor        varchar(50),
    @pro_marca           varchar(25),
    @pro_modelo          varchar(25),
    @pro_serie           varchar(25),
    @pro_color           varchar(15),
    @pro_categoria       varchar(25),
    @pro_subcategoria    varchar(25),
    @pro_referecia       varchar(15),
    @pro_vendepor        varchar(15),
    @pro_contienevende   decimal(18,2),
    @pro_comprapor       varchar(15),
    @pro_contienecompra  decimal(18,2),
    @pro_nota            varchar(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.producto
        (pro_codigo, pro_nombre, pro_fechacompra, pro_preciocomprard,
         pro_preciocompraus, pro_bodega, pro_ubicacion, pro_status,
         pro_aplicaritebis, pro_fisico, pro_servicio, pro_ocacional,
         pro_cantidadinicial, pro_cantidadminima, pro_fechaexpiracion,
         pro_supridor, pro_marca, pro_modelo, pro_serie, pro_color,
         pro_categoria, pro_subcategoria, pro_referecia, pro_vendepor,
         pro_contienevende, pro_comprapor, pro_contienecompra, pro_nota)
    VALUES
        (@pro_codigo, @pro_nombre, @pro_fechacompra, @pro_preciocomprard,
         @pro_preciocompraus, @pro_bodega, @pro_ubicacion, @pro_status,
         @pro_aplicaritebis, @pro_fisico, @pro_servicio, @pro_ocacional,
         @pro_cantidadinicial, @pro_cantidadminima, @pro_fechaexpiracion,
         @pro_supridor, @pro_marca, @pro_modelo, @pro_serie, @pro_color,
         @pro_categoria, @pro_subcategoria, @pro_referecia, @pro_vendepor,
         @pro_contienevende, @pro_comprapor, @pro_contienecompra, @pro_nota);
END
GO

ALTER PROCEDURE dbo.sp_Update_Producto
(
    @pro_codigo          int,
    @pro_nombre          varchar(50),
    @pro_fechacompra     date,
    @pro_preciocomprard  decimal(18,2),
    @pro_preciocompraus  decimal(18,2),
    @pro_bodega          varchar(25),
    @pro_ubicacion       varchar(25),
    @pro_status          bit,
    @pro_aplicaritebis   bit,
    @pro_fisico          bit,
    @pro_servicio        bit,
    @pro_ocacional       bit,
    @pro_cantidadinicial decimal(18,2),
    @pro_cantidadminima  decimal(18,2),
    @pro_fechaexpiracion date,
    @pro_supridor        varchar(50),
    @pro_marca           varchar(25),
    @pro_modelo          varchar(25),
    @pro_serie           varchar(25),
    @pro_color           varchar(15),
    @pro_categoria       varchar(25),
    @pro_subcategoria    varchar(25),
    @pro_referecia       varchar(15),
    @pro_vendepor        varchar(15),
    @pro_contienevende   decimal(18,2),
    @pro_comprapor       varchar(15),
    @pro_contienecompra  decimal(18,2),
    @pro_nota            varchar(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.producto
       SET pro_nombre          = @pro_nombre,
           pro_fechacompra     = @pro_fechacompra,
           pro_preciocomprard  = @pro_preciocomprard,
           pro_preciocompraus  = @pro_preciocompraus,
           pro_bodega          = @pro_bodega,
           pro_ubicacion       = @pro_ubicacion,
           pro_status          = @pro_status,
           pro_aplicaritebis   = @pro_aplicaritebis,
           pro_fisico          = @pro_fisico,
           pro_servicio        = @pro_servicio,   /* antes: = @pro_fisico */
           pro_ocacional       = @pro_ocacional,
           pro_cantidadinicial = @pro_cantidadinicial,
           pro_cantidadminima  = @pro_cantidadminima,
           pro_fechaexpiracion = @pro_fechaexpiracion,
           pro_supridor        = @pro_supridor,
           pro_marca           = @pro_marca,
           pro_modelo          = @pro_modelo,
           pro_serie           = @pro_serie,
           pro_color           = @pro_color,
           pro_categoria       = @pro_categoria,
           pro_subcategoria    = @pro_subcategoria,
           pro_referecia       = @pro_referecia,
           pro_vendepor        = @pro_vendepor,
           pro_contienevende   = @pro_contienevende,
           pro_comprapor       = @pro_comprapor,
           pro_contienecompra  = @pro_contienecompra,
           pro_nota            = @pro_nota
     WHERE pro_codigo = @pro_codigo;   /* la PK no se modifica */
END
GO

/* Codigo siguiente para el alta (equivalente a MAX + 1) */
IF OBJECT_ID('dbo.sp_ContarRegistro_Producto', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ContarRegistro_Producto;
GO

CREATE PROCEDURE dbo.sp_ContarRegistro_Producto
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ISNULL(MAX(pro_codigo), 0) + 1 AS Siguiente FROM dbo.producto;
END
GO

/* Duplicados por nombre excluyendo el registro que se edita.
   Para alta se llama con @pro_codigo = 0. */
IF OBJECT_ID('dbo.sp_RegistroExiste_Producto_Nombre', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_RegistroExiste_Producto_Nombre;
GO

CREATE PROCEDURE dbo.sp_RegistroExiste_Producto_Nombre
(
    @pro_codigo int,
    @pro_nombre varchar(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CASE
             WHEN EXISTS (SELECT 1
                            FROM dbo.producto
                           WHERE pro_nombre = @pro_nombre
                             AND pro_codigo <> @pro_codigo)
             THEN 1 ELSE 0
           END AS Existe;
END
GO
