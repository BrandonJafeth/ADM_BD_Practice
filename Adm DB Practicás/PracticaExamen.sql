


-- Estructuras de los temas vistos en el curso para este ultimo examen 


-------------------------------------------------------------------Transacción--------------------------------------------------------------------------------------------------------------

USE NombreBaseDeDatos;  
GO

-- Validar si la tabla ya existe, si es así, eliminarla
IF OBJECT_ID('NombreBaseDeDatos.dbo.NuevaTabla', 'U') IS NOT NULL
BEGIN
    DROP TABLE NombreBaseDeDatos.dbo.NuevaTabla;
    PRINT 'Tabla NuevaTabla eliminada porque ya existía.';
END
GO

-- Si se pide crear una copia de la tabla correspondiente 
SELECT * INTO NuevaTabla FROM OtraBaseDeDatos.dbo.TablaExistente;
PRINT 'Tabla NuevaTabla creada exitosamente.';
GO

-- Iniciar la transacción
BEGIN TRANSACTION;

-- Operación de ejemplo: eliminación de registros de la tabla, pero en si puede ser cualquier operación que se vaya a realizar, ya sea insert,update o delete 
DELETE FROM NuevaTabla
WHERE 
    ColumnaEjemplo = 'Valor1'
    OR ColumnaEjemplo = 'Valor2';

-- Condición para decidir si confirmar o revertir la transacción, por si hay alguna validación o demás
IF (SELECT COUNT(*) FROM NuevaTabla) <= 5
BEGIN
    ROLLBACK TRANSACTION;  -- Revierte la transacción si se cumple la condición
    PRINT 'Transacción revertida: número de registros menor o igual a 5.';
END
ELSE
BEGIN
    COMMIT TRANSACTION;  -- Confirma la transacción si no se cumple la condición
    PRINT 'Transacción confirmada: número de registros mayor a 5.';
END;

GO



-- Practica De transacción 

Select * from Employees

Use Northwind 
GO

IF OBJECT_ID('Northwind.dbo.JunniorEmployees', 'U') IS NOT NULL
BEGIN
    DROP TABLE Northwind.dbo.JunniorEmployees;
    PRINT 'La tabla JuniorEmployees existía, por lo cual se eliminó.';
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
PRINT 'No se pudo realizar la operación porque el numero de empleados :'  + CAST(@TOTALEMPLEADOS AS VARCHAR);

END
ELSE
BEGIN 
COMMIT TRAN 
 PRINT 'Se realizó la transacción con éxito. Número de empleados restantes: ' + CAST(@TOTALEMPLEADOS AS VARCHAR);
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






