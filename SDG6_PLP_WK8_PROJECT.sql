-- Create the database
CREATE DATABASE IF NOT EXISTS RURALAREACHALLENGES;

-- Use the newly created database
USE RURALAREACHALLENGES;

-- Schema (SQL Statements)

-- Create Regions Table
CREATE TABLE IF NOT EXISTS Regions (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(100),
    Population INT
);

-- Create WaterSources Table
CREATE TABLE IF NOT EXISTS WaterSources (
    SourceID INT PRIMARY KEY,
    SourceType VARCHAR(100),
    QualityRating INT
);

-- Create Access Table
CREATE TABLE IF NOT EXISTS Access (
    AccessID INT PRIMARY KEY,
    RegionID INT,
    SourceID INT,
    PercentageAccess FLOAT,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID) ON DELETE CASCADE,
    FOREIGN KEY (SourceID) REFERENCES WaterSources(SourceID) ON DELETE CASCADE
);

-- Sample Data (Populating the Database)
-- Clear the Access table first to avoid foreign key constraint errors
DELETE FROM Access;

-- Clear the WaterSources table before inserting new records
DELETE FROM WaterSources;

-- Clear the Regions table before inserting new records
DELETE FROM Regions;

-- Insert Sample Data into Regions
INSERT INTO Regions (RegionID, RegionName, Population) VALUES
(1, 'Ganze', 15000),
(2, 'Bamba', 23000),
(3, 'Shakahola', 12000),
(4, 'Konjora', 18000),
(5, 'Majajani', 21000),
(6, 'Langobaya', 19000);

-- Insert Sample Data into WaterSources
INSERT INTO WaterSources (SourceID, SourceType, QualityRating) VALUES
(1, 'River', 2),
(2, 'Well', 4),
(3, 'Rainwater Harvesting', 3);

-- Insert Sample Data into Access
INSERT INTO Access (AccessID, RegionID, SourceID, PercentageAccess) VALUES
(1, 1, 1, 40),
(2, 1, 2, 60),
(3, 2, 2, 70),
(4, 2, 3, 30),
(5, 3, 1, 50),
(6, 3, 3, 50),
(7, 4, 1, 35),
(8, 4, 3, 65),
(9, 5, 2, 45),
(10, 5, 3, 55),
(11, 6, 1, 25),
(12, 6, 2, 75);

-- Data Retrieval Queries

-- Query 1: Retrieve all regions and their respective water sources
SELECT Regions.RegionName, WaterSources.SourceType, Access.PercentageAccess
FROM Regions
JOIN Access ON Regions.RegionID = Access.RegionID
JOIN WaterSources ON Access.SourceID = WaterSources.SourceID;

-- Query 2: Find regions with the lowest access to clean water sources (Quality Rating >= 3)
SELECT Regions.RegionName, SUM(Access.PercentageAccess) AS TotalAccess
FROM Regions
JOIN Access ON Regions.RegionID = Access.RegionID
JOIN WaterSources ON Access.SourceID = WaterSources.SourceID
WHERE WaterSources.QualityRating >= 3
GROUP BY Regions.RegionName
ORDER BY TotalAccess ASC;
