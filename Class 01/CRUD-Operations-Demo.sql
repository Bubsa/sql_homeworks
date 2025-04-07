USE master
CREATE DATABASE SEDC  -- Se pishuva kluchniot zbor Create, pa Database, pa imeto na databazata.
USE SEDC -- Vaka pishuvame deka sakame da ja iskoristime samata databaza

-- ***Kluchen zbor CREATE***

CREATE TABLE Customer (
Id INT NOT NULL,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
City NVARCHAR(20) NULL
)
GO

SELECT * FROM dbo.Customer

-- *** Kluchen zbor INSERT***
INSERT INTO dbo.Customer (Id, FirstName, LastName, City)
VALUES (1, 'Bob', 'Bobsky', 'Skopje')

INSERT INTO dbo.Customer (Id, FirstName, LastName, City)
VALUES (2, 'Jon', 'Doe', 'Veles')


-- ***Kluchen zbor DROP*** -- Toa ja brishe celata tabela

DROP TABLE dbo.Customer

CREATE TABLE Customer (
Id INT IDENTITY(1, 1) NOT NULL,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
City NVARCHAR(20) NULL,
CONSTRAINT PK_Customer_Id PRIMARY KEY CLUSTERED (Id)
)

INSERT INTO dbo.Customer (FirstName, LastName, City)
VALUES ('Bob', 'Bobsky', 'Skopje'),
		('Petko', 'Petkovski', 'Tetovo'),
		('Jon', 'Doe', 'Veles')


--***Kluchen zbor ALTER*** -- Tuka se dodavaat koloni na tabelata od koga ke bide napravena. Vo primerot podole stavivme nova kolona Age
ALTER TABLE dbo.Customer
ALTER COLUMN FirstName NVARCHAR(100) NOT NULL

ALTER TABLE dbo.Customer
ADD Age INT NULL

--*** Kluchen zbor SELECT***

SELECT * FROM dbo.Customer

SELECT FirstName, LastName, City 
FROM dbo.Customer
WHERE City = 'Skopje'


--***Kluchen zbor UPDATE***
UPDATE dbo.Customer
SET FirstName = 'Gregory', City = 'Bitola' -- Tuka ke gi smeni site prvi iminja vo Gregory i site gradovi vo Bitola (bez ova dole)
WHERE FirstName = 'Greg'
-- Ako vishe zaebesh da gi pishes informaciite kako ova pogore togas sledi delete

--***Kluchen zbor DELETE***

DELETE FROM dbo.Customer
WHERE FirstName = 'Gregory'


INSERT INTO dbo.Customer (FirstName, LastName, City)
VALUES ('Bob', 'Bobsky', 'Skopje'),
		('Petko', 'Petkovski', 'Tetovo'),
		('Greg', 'Gregsky', 'Veles')