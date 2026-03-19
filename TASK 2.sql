----TASK 2

CREATE DATABASE FarmMachineryDB;
GO
USE FarmMachineryDB;
GO

CREATE TABLE Equipments (
    AssetID INT IDENTITY(1,1) PRIMARY KEY,
    AssetName NVARCHAR(50) NOT NULL,
    PurchaseDate DATE NOT NULL,
    HoursUsed INT NOT NULL
);

CREATE TABLE Mechanicss (
    MechanicID INT IDENTITY(1,1) PRIMARY KEY,
    MechanicName NVARCHAR(50) NOT NULL,
    Specialty NVARCHAR(50) NOT NULL
);

CREATE TABLE MaintenanceRecordss (
    RecordID INT IDENTITY(1,1) PRIMARY KEY,
    AssetID INT NOT NULL,
    MechanicID INT NOT NULL,
    ServiceDate DATETIME NOT NULL,
    Cost DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (AssetID) REFERENCES Equipments(AssetID),
    FOREIGN KEY (MechanicID) REFERENCES Mechanicss(MechanicID)
);

CREATE INDEX idx_Equipments_HoursUsed ON Equipments(HoursUsed);
CREATE INDEX idx_MaintenanceRecordss_ServiceDate ON MaintenanceRecordss(ServiceDate);
CREATE INDEX idx_Mechanicss_Specialty ON Mechanicss(Specialty);


INSERT INTO Equipments (AssetName, PurchaseDate, HoursUsed) VALUES
('Lister L100', '2020-05-10', 2000),
('Powersaw P200', '2021-03-15', 1500),
('Plough P300', '2022-07-20', 800),
('Seeder S400', '2023-01-05', 600),
('Sprayer SP500', '2023-06-18', 450),
('Combine C600', '2024-02-12', 300),
('Baler B700', '2024-08-25', 700),
('Cultivator CU800', '2025-01-30', 550),
('Planter PL900', '2025-05-14', 400),
('Roller R1000', '2025-09-09', 250);


INSERT INTO Mechanicss (MechanicName, Specialty) VALUES
('Mick Mouse', 'Engine Repair'),
('Scubi Doo', 'Hydraulics'),
('Mzee Mzima', 'Electrical Systems'),
('Pamela Jackson', 'General Service'),
('Mrushia Mkenya', 'Transmission'),
('Abigel Mumo', 'Welding'),
('Mary Chebet', 'Diagnostics'),
('Eunice Njeri', 'Fuel Systems'),
('Tom Jerry', 'Cooling Systems'),
('Bosco Mutina', 'Brake Systems');

INSERT INTO MaintenanceRecordss (AssetID, MechanicID, ServiceDate, Cost) VALUES
(1, 1, '2025-01-10 09:30', 5000.00),
(2, 2, '2025-02-12 14:00', 3500.00),
(3, 3, '2025-03-05 11:15', 4200.00),
(4, 4, '2025-04-20 16:45', 2800.00),
(5, 5, '2025-05-25 10:00', 3100.00),
(6, 6, '2025-06-30 13:20', 2700.00),
(7, 7, '2025-07-15 09:50', 3900.00),
(8, 8, '2025-08-22 15:10', 3300.00),
(9, 9, '2025-09-18 12:40', 2500.00),
(10, 10, '2025-10-05 08:30', 4600.00);

SELECT e.AssetName, e.HoursUsed, m.ServiceDate
FROM Equipments e
JOIN MaintenanceRecordss m ON e.AssetID = m.AssetID
WHERE e.HoursUsed > 50 AND m.ServiceDate > '2025-01-01';

SELECT mech.Specialty, COUNT(mr.RecordID) AS TotalRecords
FROM MaintenanceRecordss mr
JOIN Mechanicss mech ON mr.MechanicID = mech.MechanicID
GROUP BY mech.Specialty;


UPDATE Equipments
SET HoursUsed = HoursUsed + 100
WHERE AssetName = 'Lister L100';


DELETE FROM Equipments
WHERE AssetName = 'Roller R1000';
