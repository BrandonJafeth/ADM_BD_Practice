


-- Estructuras de los temas vistos en el curso para este ultimo examen 

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
