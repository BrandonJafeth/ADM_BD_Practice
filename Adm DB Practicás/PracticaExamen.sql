


-- Estructuras de los temas vistos en el curso para este ultimo examen 

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
