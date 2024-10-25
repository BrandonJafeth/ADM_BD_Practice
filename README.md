# Salvar Administración de Base De Datos

## Descripción
Este repositorio ha sido creado para practicar diferentes consultas (queries) y así prepararse de manera efectiva para el curso de administración de bases de datos. El objetivo es realizar suficientes ejercicios prácticos para que las evaluaciones resulten más sencillas.


## Estructura de Vistas
A continuación se describe cómo se crea una vista en SQL y su propósito en este repositorio.

### ¿Qué es una Vista?
Una vista es una consulta SQL almacenada que permite acceder a datos específicos de una o varias tablas como si se tratara de una tabla virtual. Facilita la reutilización de consultas complejas, mejora la legibilidad del código y puede ayudar a gestionar permisos de acceso a datos específicos.

### Sintaxis para Crear una Vista
```sql
GO
CREATE VIEW nombre_de_la_vista AS
SELECT columnas
FROM nombre_tabla_1
JOIN nombre_tabla_2 ON nombre_tabla_1.columna = nombre_tabla_2.columna
WHERE condiciones;

With Check option
GO
```

## Procedimientos Almacenados
Los procedimientos almacenados son conjuntos de instrucciones SQL que se guardan en la base de datos para ser ejecutados múltiples veces, permitiendo la automatización de tareas repetitivas y mejorando la eficiencia del sistema.

### Sintaxis para Crear un Procedimiento Almacenado
```sql
GO
CREATE PROCEDURE nombre_procedimiento
    @Parametro1 TipoDato,
    @Parametro2 TipoDato
AS
BEGIN
    -- Cuerpo del procedimiento
    Instrucciones SQL;
END;
GO
```

## Control de Flujos y Transacciones
Las transacciones permiten agrupar una o varias operaciones SQL para garantizar que todas se ejecuten de forma completa o ninguna se aplique, garantizando la integridad de los datos. El control de flujo maneja la lógica dentro de los scripts SQL mediante estructuras como `TRY...CATCH` para gestionar errores y ejecutar operaciones críticas con seguridad.

### Sintaxis para el Uso de Transacciones
```sql
BEGIN TRANSACTION;
BEGIN TRY
    -- Instrucciones SQL
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error: Se ha revertido la transacción.';
END CATCH;

    ```


