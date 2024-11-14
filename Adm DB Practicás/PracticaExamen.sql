


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






