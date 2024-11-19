


---Practicas 

Select * from rutas

EXEC sp_help Usuarios
Use Datos


DROP TABLE IF EXISTS Clientes2;



SELECT 
    NCEDULA AS Cedula,
    FVECONT AS FechaContrato,
	CODRUTA AS CodigoRuta
INTO Clientes2 
FROM clientes
WHERE clientes.FVECONT >= '2023-10-01'
AND IGENERO = 'F';


DECLARE 
    @Cedula VARCHAR(9),
	@Nombre VARCHAR(30),
    @FechaContrato date,
	@CodigoRuta varchar(6),
	@Apellido1  varchar(30),
	@Apellido2 varchar(30),
	@Distrito varchar(34),
	@Saldo decimal(9,2)


DECLARE Cursor_Octubre CURSOR FOR 
SELECT Cedula, FechaContrato, CodigoRuta
FROM Clientes2;


OPEN Cursor_Octubre;


FETCH NEXT FROM Cursor_Octubre INTO @Cedula, @FechaContrato, @CodigoRuta;

WHILE
(@@FETCH_STATUS = 0)
BEGIN 
  
    SELECT 
   @Nombre = clientes.NNOMBRE, @Apellido1 = clientes.IAPELLI, @Apellido2 = clientes.IIAPELL,@Distrito = rutas.DISTRITO,@Saldo = saldos.SAMONTO
    FROM clientes,rutas,saldos
 
    WHERE 
	clientes.NCEDULA = saldos.NCEDULA
	AND clientes.CODRUTA = rutas.CODRUTA


    PRINT 'Nombre: ' + RTRIM(@Nombre) + ' ' + RTRIM(@Apellido1) + '' + RTRIM(@Apellido2);
    PRINT 'Distrito: ' + @Distrito;
	PRINT 'Saldo: ' + CAST(@Saldo AS VARCHAR);
	PRINT ' ';


FETCH NEXT FROM Cursor_Octubre INTO @Cedula, @FechaContrato, @CodigoRuta;
END;


CLOSE Cursor_Octubre;
DEALLOCATE Cursor_Octubre;

DROP TABLE Clientes2;
GO
            




			

USE DATOSOFIS;
GO

CREATE FUNCTION Fn_Usuarios_Permisoindsjnfjs
(
@Apellido2 VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
	Usuarios.NOMBRE, CONCAT(Usuarios.APE1,' ', Usuarios.APE2) AS Nombrecompleto, Usuarios.IDUSU, Permisos.CODDEJ,Permisos.CODCARGO
    FROM Usuarios,Permisos
    WHERE 
	Usuarios.IDUSU = Permisos.IDUSU
	AND usuarios.APE2 = @Apellido2
);
GO

USE DATOSOFIS;
GO

CREATE FUNCTION Fn_Usuarios_Permisos
(
    @Apellido2 VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        Usuarios.NOMBRE AS NombreUsuario,
        CONCAT(Usuarios.APE1, ' ', Usuarios.APE2) AS NombreCompleto,
        Usuarios.IDUSU AS IdUsuario,
        Permisos.CODDEJ AS CodigoDeJ,
        Permisos.CODCARGO AS CodigoCargo
    FROM Usuarios, Permisos
    WHERE 
	Usuarios.IDUSU = Permisos.IDUSU
     AND  Usuarios.APE2 = @Apellido2
);
GO

USE Datos;
GO
CREATE FUNCTION f_Clientes (@CodiRuta VARCHAR(6))
RETURNS TABLE
AS
RETURN
(
    SELECT * 
    FROM rutas
    WHERE CODRUTA = @CodiRuta
);
GO



