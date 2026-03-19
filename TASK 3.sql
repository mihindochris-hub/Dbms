---TASK 3
CREATE DATABASE FarmFinanceDB;
GO

USE FarmFinanceDB;
GO


CREATE TABLE SalesOrders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductSold NVARCHAR(50) NOT NULL,
    QuantityOrdered INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Inventory (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(50) UNIQUE NOT NULL,
    CurrentStock INT NOT NULL,
    ValuePerUnit DECIMAL(10,2) NOT NULL
);

INSERT INTO Inventory (ProductName, CurrentStock, ValuePerUnit) VALUES
('Unga', 1000, 50.00),
('Mahindi', 800, 40.00),
('Mbosho', 600, 70.00),
('Mchele', 500, 90.00),
('Barley', 300, 55.00);

INSERT INTO SalesOrders (CustomerID, ProductSold, QuantityOrdered) VALUES
(101, 'Unga', 200),
(102, 'Mahindi', 150),
(103, 'Mbosho', 100),
(104, 'Mchele', 50),
(105, 'Barley', 75);


BEGIN TRANSACTION;

INSERT INTO SalesOrders (CustomerID, ProductSold, QuantityOrdered)
VALUES (106, 'Unga', 500);

UPDATE Inventory
SET CurrentStock = CurrentStock - 500
WHERE ProductName = 'Unga';

COMMIT TRANSACTION;


BEGIN TRANSACTION;

INSERT INTO SalesOrders (CustomerID, ProductSold, QuantityOrdered)
VALUES (107, 'Unga', 300);

UPDATE Inventory
SET CurrentStock = CurrentStock - 2000
WHERE ProductName = 'Unga';

ROLLBACK TRANSACTION;


UPDATE Inventory SET CurrentStock = CurrentStock - 100 WHERE ProductName = 'Unga';


BEGIN TRANSACTION;

SELECT CurrentStock 
FROM Inventory
WHERE ProductName = 'Unga'
WITH (UPDLOCK);

UPDATE Inventory
SET CurrentStock = CurrentStock - 100
WHERE ProductName = 'Unga';

COMMIT TRANSACTION;


ALTER TABLE Inventory ADD Version INT DEFAULT 1;

BEGIN TRANSACTION;

DECLARE @CurrentVersion INT;

SELECT @CurrentVersion = Version 
FROM Inventory 
WHERE ProductName = 'Unga';

UPDATE Inventory
SET CurrentStock = CurrentStock - 100, Version = Version + 1
WHERE ProductName = 'Unga' AND Version = @CurrentVersion;

COMMIT TRANSACTION;


CREATE LOGIN DispatchClerkUser WITH PASSWORD = 'Password123!';
CREATE LOGIN FarmManagerUser WITH PASSWORD = 'Password456!';

USE FarmFinanceDB;

CREATE USER DispatchClerkUser FOR LOGIN DispatchClerkUser;
CREATE USER FarmManagerUser FOR LOGIN FarmManagerUser;

GRANT SELECT, INSERT, UPDATE ON SalesOrders TO DispatchClerkUser;
GRANT SELECT, INSERT, UPDATE ON Inventory TO FarmManagerUser;

DENY UPDATE ON OBJECT::Inventory (ValuePerUnit) TO DispatchClerkUser;


BACKUP DATABASE FarmFinanceDB
TO DISK = 'C:\Backups\FarmFinanceDB.bak';


DROP TABLE Inventory;


RESTORE DATABASE FarmFinanceDB
FROM DISK = 'C:\Backups\FarmFinanceDB.bak'
WITH REPLACE;

