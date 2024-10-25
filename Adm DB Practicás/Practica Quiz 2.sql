-- Crear la base de datos
CREATE DATABASE PracticaJoins;
GO

-- Usar la base de datos
USE PracticaJoins;
GO

-- Crear la tabla Clientes
CREATE TABLE Clientes (
    IdCliente INT PRIMARY KEY,
    Nombre NVARCHAR(50),
    Apellido NVARCHAR(50),
    CodRuta INT
);

-- Crear la tabla Rutas
CREATE TABLE Rutas (
    CodRuta INT PRIMARY KEY,
    Canton NVARCHAR(50),
    Distrito NVARCHAR(50),
    Provincia NVARCHAR(50)
);

-- Crear la tabla Ventas
CREATE TABLE Ventas (
    IdVenta INT PRIMARY KEY,
    IdCliente INT,
    Monto DECIMAL(10, 2),
    FechaVenta DATE,
    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
);

-- Crear la tabla Productos
CREATE TABLE Productos (
    IdProducto INT PRIMARY KEY,
    NombreProducto NVARCHAR(50),
    Precio DECIMAL(10, 2)
);

-- Crear la tabla DetalleVentas
CREATE TABLE DetalleVentas (
    IdDetalleVenta INT PRIMARY KEY,
    IdVenta INT,
    IdProducto INT,
    Cantidad INT,
    FOREIGN KEY (IdVenta) REFERENCES Ventas(IdVenta),
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (IdCliente, Nombre, Apellido, CodRuta) VALUES
(1, 'Ana', 'Pérez', 101),
(2, 'Carlos', 'López', 102),
(3, 'María', 'Gómez', 101),
(4, 'José', 'Ramírez', 103);

-- Insertar datos en la tabla Rutas
INSERT INTO Rutas (CodRuta, Canton, Distrito, Provincia) VALUES
(101, 'Central', 'San José', 'San José'),
(102, 'Escazú', 'San Rafael', 'San José'),
(103, 'Alajuela', 'Central', 'Alajuela');

-- Insertar datos en la tabla Ventas
INSERT INTO Ventas (IdVenta, IdCliente, Monto, FechaVenta) VALUES
(1, 1, 5000.00, '2024-10-01'),
(2, 2, 3000.00, '2024-10-02'),
(3, 3, 7000.00, '2024-10-05'),
(4, 4, 1500.00, '2024-10-06');

-- Insertar datos en la tabla Productos
INSERT INTO Productos (IdProducto, NombreProducto, Precio) VALUES
(1, 'Laptop', 1500.00),
(2, 'Teléfono', 800.00),
(3, 'Teclado', 50.00),
(4, 'Mouse', 30.00);

-- Insertar datos en la tabla DetalleVentas
INSERT INTO DetalleVentas (IdDetalleVenta, IdVenta, IdProducto, Cantidad) VALUES
(1, 1, 1, 2),  -- Ana compró 2 laptops
(2, 2, 2, 1),  -- Carlos compró 1 teléfono
(3, 3, 3, 5),  -- María compró 5 teclados
(4, 4, 4, 3);  -- José compró 3 mouse


-- Practica 1
Use PracticaJoins
Go
Select Clientes.Nombre, Clientes.Apellido, Ventas.FechaVenta, Ventas.Monto from Clientes

INNER JOIN Ventas ON Clientes.IdCliente = Ventas.IdCliente;
Go


--Practica 1 con =

Use PracticaJoins
Go
Select Clientes.Nombre, Clientes.Apellido, Ventas.FechaVenta, Ventas.Monto from Clientes,Ventas

Where 

Clientes.IdCliente = Ventas.IdCliente;
GO





--Practica 2 con = 

Use PracticaJoins
Go
Select Clientes.Nombre, Productos.NombreProducto, DetalleVentas.Cantidad from Clientes,DetalleVentas, Productos, Ventas

Where 

Clientes.IdCliente = Ventas.IdVenta

AND Ventas.IdCliente = DetalleVentas.IdVenta

AND DetalleVentas.IdProducto = Productos.IdProducto

GO

-- Practica 2 con inner joins

Use PracticaJoins

Go

Select Clientes.Nombre, Productos.NombreProducto, DetalleVentas.Cantidad FROM Clientes

INNER JOIN Ventas ON Clientes.IdCliente = Ventas.IdCliente

INNER JOIN DetalleVentas ON Ventas.IdVenta = DetalleVentas.IdVenta

INNER JOIN Productos ON DetalleVentas.IdProducto = Productos.IdProducto

GO




--Practica 3 con Inner joins

Use PracticaJoins
go
Select 
Clientes.Nombre,
SUM(DetalleVentas.Cantidad*Productos.Precio) AS Total from Clientes 

INNER JOIN Ventas ON Ventas.IdCliente = Clientes.IdCliente

INNER JOIN DetalleVentas ON DetalleVentas.IdVenta = Ventas.IdVenta

INNER JOIN Productos ON Productos.IdProducto = DetalleVentas.IdProducto

Group by 
Clientes.Nombre
GO


--Practica 3 con = 

Use PracticaJoins
GO
SELECT 
Clientes.Nombre,
SUM(DetalleVentas.Cantidad* Productos.Precio) AS TotalGastado
FROM Clientes, Productos, Ventas, DetalleVentas

Where 

Clientes.IdCliente = Ventas.IdCliente
AND Ventas.IdVenta = DetalleVentas.IdVenta
AND Productos.IdProducto = DetalleVentas.IdProducto
GROUP BY
Clientes.Nombre
GO


-- Practica 4 INNER JOINS

Use PracticaJoins
Go

SELECT Ventas.IdVenta, 
Clientes.Nombre AS CLIENTE,
Productos.NombreProducto AS ProductoComprado 
FROM 
Clientes 
 
 INNER JOIN Ventas ON Clientes.IdCliente = Ventas.IdVenta
 INNER JOIN  DetalleVentas ON Ventas.IdVenta = DetalleVentas.IdVenta
INNER JOIN Productos ON Productos.IdProducto = DetalleVentas.IdProducto
GO

-- Practica 4 = 
USE PracticaJoins
GO 
SELECT Ventas.IdVenta, Clientes.Nombre AS CLIENTE, Productos.NombreProducto
FROM
Clientes,Ventas,DetalleVentas,Productos

WHERE

Clientes.IdCliente = Ventas.IdCliente
AND Ventas.IdVenta = DetalleVentas.IdVenta
AND Productos.IdProducto = DetalleVentas.IdProducto
GO








-- Hacer copias de las tablas 
Use Pubs
go
Select * into copiatitles3 from titles
go




Use PracticaJoins
GO
Select * into productos2 from Productos
Go

Use PracticaJoins
GO
Select productos2.NombreProducto, productos2.IdProducto From productos2
GO


Use Datos
Go
Select * into myrutas from datos..rutas

Go
--Aqui termina 





-- Para buscar los campos de una tabla
Go
Exec sp_help SuperTitles
Go
-- Aqui termina 



-- Practica Control de flujos
GO
Delete from myrutas 
Where Distrito like '%maria%'
if
@@rowcount = 0
select 'No hay datos por eliminar'
else if
@@rowcount = 1
select 'Un registro eliminado'
else 
select 'Se elimino más de un registro'
Go
--
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

-- Practica Vistas

GO
Create VIEW Product_Comprado
AS
SELECT Ventas.IdVenta, 
Clientes.Nombre AS CLIENTE,
Productos.NombreProducto AS ProductoComprado 
FROM 
Clientes 
 
 INNER JOIN Ventas ON Clientes.IdCliente = Ventas.IdVenta
 INNER JOIN  DetalleVentas ON Ventas.IdVenta = DetalleVentas.IdVenta
INNER JOIN Productos ON Productos.IdProducto = DetalleVentas.IdProducto
WITH CHECK OPTION
GO

Select * from Product_Comprado

Drop view Product_Comprado







---Terminan las vistas