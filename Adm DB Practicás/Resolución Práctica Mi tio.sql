



-- Primer enunciado

USE DATOSOFIS;  
GO

GO
IF OBJECT_ID('dbo.Tabla1', 'U') IS NOT NULL
AND OBJECT_ID('dbo.Tabla2', 'U') IS NOT NULL
AND OBJECT_ID('dbo.Tabla3', 'U') IS NOT NULL
BEGIN
DROP TABLE Tabla1,Tabla2,Tabla3
END
GO


BEGIN TRANSACTION;


IF OBJECT_ID('dbo.Funcionarios', 'U') IS NOT NULL
AND  OBJECT_ID('dbo.Permisos', 'U') IS NOT NULL
AND   OBJECT_ID('dbo.Usuarios', 'U') IS NOT NULL

BEGIN

SELECT * INTO Tabla1 From Funcionarios;
PRINT 'Tabla 1 se Creo exitosamente '


SELECT * INTO Tabla2 FROM Permisos
PRINT 'Tabla 2 se Creo exitosamente '


SELECT * INTO Tabla3 FROM Permisos
PRINT 'Tabla 3 se Creo exitosamente '

   COMMIT TRANSACTION; 
    PRINT 'Se realizaron las copias con exito';
 
END
ELSE
BEGIN
 
   ROLLBACK TRANSACTION; 
    PRINT 'Falta almenos una de las tablas  necesarias.';
END;
GO



--Segundo enunciado 