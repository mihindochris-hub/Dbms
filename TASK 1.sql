----TASK 1-----

CREATE DATABASE AgriTechDB;
GO
USE AgriTechDB;
GO


CREATE TABLE Fields (
    FieldID INT IDENTITY(1,1) PRIMARY KEY,
    FieldName NVARCHAR(50) NOT NULL,
    Size DECIMAL(10,2) NOT NULL,
    Location NVARCHAR(100) NOT NULL
);

CREATE TABLE Crops (
    CropID INT IDENTITY(1,1) PRIMARY KEY,
    CropName NVARCHAR(50) NOT NULL,
    PlantDate DATE NOT NULL,
    FieldID INT NOT NULL,
    FOREIGN KEY (FieldID) REFERENCES Fields(FieldID)
);


CREATE TABLE HarvestEvents (
    HarvestID INT IDENTITY(1,1) PRIMARY KEY,
    CropID INT NOT NULL,
    HarvestDate DATE NOT NULL,
    YieldKg DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CropID) REFERENCES Crops(CropID)
);

INSERT INTO Fields (FieldName, Size, Location) VALUES
('Field 1', 3.5, 'South'),
('Field 5', 5.0, 'North'),
('Field 7', 2.8, 'West');

INSERT INTO Crops (CropName, PlantDate, FieldID) VALUES
('Tomatoes', '2026-01-10', 2),
('Carrots', '2026-01-15', 1),
('Maize', '2026-01-20', 3);

INSERT INTO HarvestEvents (CropID, HarvestDate, YieldKg) VALUES
(1, '2026-02-25', 1600.50),
(2, '2026-02-26', 1000.00),
(3, '2026-02-27', 850.75);
