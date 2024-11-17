


-- Estructuras de los temas vistos en el curso para este ultimo examen 


-------------------------------------------------------------------Transacci�n--------------------------------------------------------------------------------------------------------------

USE NombreBaseDeDatos;  
GO

-- Validar si la tabla ya existe, si es as�, eliminarla
IF OBJECT_ID('NombreBaseDeDatos.dbo.NuevaTabla', 'U') IS NOT NULL
BEGIN
    DROP TABLE NombreBaseDeDatos.dbo.NuevaTabla;
    PRINT 'Tabla NuevaTabla eliminada porque ya exist�a.';
END
GO

-- Si se pide crear una copia de la tabla correspondiente 
SELECT * INTO NuevaTabla FROM OtraBaseDeDatos.dbo.TablaExistente;
PRINT 'Tabla NuevaTabla creada exitosamente.';
GO

-- Iniciar la transacci�n
BEGIN TRANSACTION;

-- Operaci�n de ejemplo: eliminaci�n de registros de la tabla, pero en si puede ser cualquier operaci�n que se vaya a realizar, ya sea insert,update o delete 
DELETE FROM NuevaTabla
WHERE 
    ColumnaEjemplo = 'Valor1'
    OR ColumnaEjemplo = 'Valor2';

-- Condici�n para decidir si confirmar o revertir la transacci�n, por si hay alguna validaci�n o dem�s
IF (SELECT COUNT(*) FROM NuevaTabla) <= 5
BEGIN
    ROLLBACK TRANSACTION;  -- Revierte la transacci�n si se cumple la condici�n
    PRINT 'Transacci�n revertida: n�mero de registros menor o igual a 5.';
END
ELSE
BEGIN
    COMMIT TRANSACTION;  -- Confirma la transacci�n si no se cumple la condici�n
    PRINT 'Transacci�n confirmada: n�mero de registros mayor a 5.';
END;

GO



-- Practica De transacci�n 

Select * from Employees

Use Northwind 
GO

IF OBJECT_ID('Northwind.dbo.JunniorEmployees', 'U') IS NOT NULL
BEGIN
    DROP TABLE Northwind.dbo.JunniorEmployees;
    PRINT 'La tabla JuniorEmployees exist�a, por lo cual se elimin�.';
END
GO





GO
BEGIN TRAN

Select * into dbo.JunniorEmployees from Employees


DELETE FROM JunniorEmployees 
WHERE DATEDIFF(YEAR,HireDate,GETDATE()) >= 5;


DECLARE @TOTALEMPLEADOS  INT 

SELECT  @TOTALEMPLEADOS = COUNT(*) from JunniorEmployees


IF @TOTALEMPLEADOS < 4

BEGIN 

ROLLBACK 
PRINT 'No se pudo realizar la operaci�n porque el numero de empleados :'  + CAST(@TOTALEMPLEADOS AS VARCHAR);

END
ELSE
BEGIN 
COMMIT TRAN 
 PRINT 'Se realiz� la transacci�n con �xito. N�mero de empleados restantes: ' + CAST(@TOTALEMPLEADOS AS VARCHAR);
END

GO


---------------------------------------------------------------------Final----------------------------------------------------------------------------------------------------------




-------------------------------------------------------------------Vista--------------------------------------------------------------------------------------------------------------



USE Northwind 

GO 


IF OBJECT_ID('dbo.Nombredelavista','V') IS NOT NULL
BEGIN 

DROP VIEW dbo.Nombredelavista
END

GO


Go
-- Primero se crea la vista y se le pone un nombre
CREATE VIEW Nombredelavista
AS --IMPORTANTE EL AS SIEMPRE VA

--Estructura de la consulta que se quiere realizar 
Select Employees.FirstName From Employees 

WITH CHECK OPTION -- Propiedad para poder modificar la vista
Go


-- Practica De Vista 


SELECT * FROM rutas
Use Datos 

Go


IF OBJECT_ID('dbo.infoClien','V') IS NOT NULL

DROP VIEW dbo.infoClien

PRINT 'Se elimino la vista correctamente'
GO


GO

CREATE OR ALTER VIEW infoClien
AS
SELECT clientes.NNOMBRE, clientes.IAPELLI, clientes.IIAPELL ,saldos.FESALDO,rutas.DISTRITO FROM clientes, saldos,rutas


WHERE 
clientes.NCEDULA = saldos.NCEDULA

AND rutas.DISTRITO = 'Nicoya'

WITH CHECK OPTION; 
GO


SELECT * FROM infoClien





-------------------------------------------------------------------FIN--------------------------------------------------------------------------------------------------------------






-------------------------------------------------------------------Cursores---------------------------------------------------------------------------------------------------------




Use Northwind

go

--Declaración del Cursor --SCROLL

Declare Cursor_Region cursor scroll

for select RegionID,RegionDescription from Region

--Apertura del cursor

Open Cursor_Region

--Lectura de filas

fetch LAST from Cursor_Region -- SCROLL(FIRST, LAST, PRIOR, NEXT)
--FETCH RECORRE FILA X FILA

select @@FETCH_STATUS --esta es una variable global que me dice el estado del enunciado fetch

--cierre del curso

close Cursor_Region

--liberación de memora

deallocate Cursor_Region














USE DATOS;
GO

DECLARE 
    @Cedula varchar(9),
    @FechaContrato date,
    @CodigoRuta varchar(6),
    @nombre varchar(30),
    @Apellido1 varchar(30),
    @Apellido2 varchar(30),
    @Distrito varchar(34),
    @Monto decimal;

DECLARE Cursor_Octubre CURSOR FOR 
SELECT TOP 10 
    NCEDULA, FVECONT, CODRUTA 
FROM clientes 
WHERE FVECONT >= '2023-10-01' 
  AND IGENERO = 'F';

OPEN Cursor_Octubre;

FETCH NEXT FROM Cursor_Octubre INTO @Cedula, @FechaContrato, @CodigoRuta;
WHILE (@@FETCH_STATUS = 0)
BEGIN
    -- Consulta para obtener los detalles del cliente
    SELECT 
        c.NNOMBRE, c.IAPELLI, c.IIAPELL, r.DISTRITO, s.SAMONTO
    FROM 
        clientes c
    JOIN 
        rutas r ON c.CODRUTA = r.CODRUTA
    JOIN 
        saldos s ON c.NCEDULA = s.NCEDULA
    WHERE 
        c.NCEDULA = @Cedula;

    -- Asignación a las variables para la impresión
    SELECT 
        @nombre = c.NNOMBRE,
        @Apellido1 = c.IAPELLI,
        @Apellido2 = c.IIAPELL,
        @Distrito = r.DISTRITO,
        @Monto = s.SAMONTO
    FROM 
        clientes c
    JOIN 
        rutas r ON c.CODRUTA = r.CODRUTA
    JOIN 
        saldos s ON c.NCEDULA = s.NCEDULA
    WHERE 
        c.NCEDULA = @Cedula;

    -- Impresión de los resultados
    PRINT 'Nombre :' + RTRIM(@nombre) + ' ' + RTRIM(@Apellido1) + ' ' + RTRIM(@Apellido2);
    PRINT 'Distrito : ' + @Distrito;
    PRINT 'Monto : ' + CAST(@Monto AS varchar);
    PRINT ' ';

    FETCH NEXT FROM Cursor_Octubre INTO @Cedula, @FechaContrato, @CodigoRuta;
END;

CLOSE Cursor_Octubre;
DEALLOCATE Cursor_Octubre;
GO








-------------------------------------------------------------------Final--------------------------------------------------------------------------------------------------------------







-------------------------------------------------------------------Funciones---------------------------------------------------------------------------------------------------------



--Practica Funciones de numeros

create function f_promedio 
( @valor1 decimal(4,2), @valor2 decimal(4,2)
)

returns decimal (6,2)
-- se pone 6 porque el valor se puede pasar de 4 
--tener cuiadado con el consumo de recursos, de no sacrificarlo por completo 
--importante la "s" en el return
as
Begin
  declare @resultado decimal(6,2)
  -- puedo usar SET 
  select @resultado = ( @valor1 + @valor2 ) / 2

  return @resultado
End;
go


Go
Create function fn_suma 
(
@valor1 decimal(4,2),
@Valor2 decimal(4,2)
)
returns decimal(6,2)
AS 
BEGIN
Declare @resultado decimal(6,2)

select @resultado = @valor1 + @Valor2

return @resultado

end

Go

select dbo.fn_suma(2,3.6)
---


Go
CREATE FUNCTION fn_Multiplicaci�n
(
@valor1 int,
@valor2 int
)

RETURNS int

AS
BEGIN 
DECLARE @RESULTADO int

SELECT @RESULTADO = @valor1 * @valor2

RETURN @RESULTADO
end;

GO

SELECT dbo.fn_Multiplicaci�n(3,20)

--Practica funciones de tablas 

Use Datos
go
create function f_Cliente (@CodiRuta varchar(6))

returns table
as
Return
-- importante el return 
(
   select * from rutas
   where CODRUTA = @CodiRuta
)
go

select * from dbo.f_Cliente('508002')


--Practica parecida
Use PracticaJoins 
GO
Create function fn_codigoruta
(

@Codru INT
)

returns table

Return
(
Select * from clientes
where Clientes.CodRuta = @Codru
)

GO


select * from dbo.fn_codigoruta(101)



--Practicas pareccidas a quiz anterior

select * from titles
Exec sp_help titleauthor

Use Pubs 
Go
Create Function fn_Searchforidtitle
(

@IdTitle varchar(6)
)

RETURNS TABLE 

RETURN
(

Select titles.title, titles.type, titles.price, CONCAT(authors.au_lname, ' ', authors.au_fname)AS NombreAutor,  authors.phone,authors.city, authors.state 

from titles, authors, titleauthor

where 

titles.title_id = titleauthor.title_id
AND authors.au_id = titleauthor.au_id
AND @IdTitle = titles.title_id
)
GO


SELECT * FROM dbo.fn_Searchforidtitle('BU1032');

-------------------------------------------------------------------Final--------------------------------------------------------------------------------------------------------------




-------------------------------------------------------------------Procedimientos---------------------------------------------------------------------------------------------------------


--Ejemplo de la estructura de un procedimiento almacenado
USE NombreBaseDeDatos;
GO

CREATE PROCEDURE NombreDelProcedimiento
(
    @Parametro1 TipoDato,
    @Parametro2 TipoDato
)
AS
BEGIN
    -- Cuerpo del procedimiento
    -- Ejemplo de una consulta
    SELECT * FROM NombreTabla
    WHERE Columna1 = @Parametro1
      AND Columna2 = @Parametro2;
    
    RETURN;
END;
GO






--Practica Procedimiento almacenado

Use pubs
go
CREATE PROC proc_author_info
(
@lname varchar(40), 
@fname varchar(20)
)
AS
Select au_lname, au_fname, title
from authors,titles, titleauthor

Where 

au_fname = @fname
AND au_lname = @lname
AND authors.au_id = titleauthor.au_id
AND titles.title_id = titleauthor.title_id
RETURN
GO


 exec proc_author_info @fname='Albert',@lname='Ringer'
-- !!!!!!!!!!!!! no importa el orden de la variable !!!!!!!!!!!!! --

 exec proc_author_info 'Ringer', 'Albert'
 exec proc_author_info 'Albert', 'Ringer'  -----incorrecto por orden porque aqui no se especifica la variable 

 --Termina el procedimiento 



-------------------------------------------------------------------Final--------------------------------------------------------------------------------------------------------------


