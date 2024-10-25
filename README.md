# Nombre del Repositorio SQL Server

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
Detallar cómo se manejan las transacciones y los controles de flujo en los scripts SQL. Por ejemplo:

- **Transacciones en procedimientos**: Describe cómo se utilizan las transacciones para garantizar la integridad de los datos en operaciones críticas.
  - **Ejemplo**:
    ```sql
    GO
    BEGIN TRANSACTION;
    TRY
      -- Instrucciones SQL
      COMMIT TRANSACTION;
    CATCH
      ROLLBACK TRANSACTION;
    END TRY
    GO
    ```


