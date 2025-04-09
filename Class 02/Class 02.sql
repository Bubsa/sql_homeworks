-- *** UNION ***
-- Vrakja unikatni vrednosti od dve queries.
SELECT [FirstName] FROM dbo.Employee
UNION 
SELECT [Name] FROM dbo.Customer

-- List all unique cities and regions from Customer

SELECT City FROM dbo.Customer
UNION
SELECT RegionName FROM dbo.Customer

-- *** UNION ALL ***


SELECT City FROM dbo.Customer
UNION ALL
SELECT RegionName FROM dbo.Customer

SELECT [FirstName] FROM dbo.Employee
UNION ALL
SELECT [Name] FROM dbo.Customer

-- *** INTERSECT

SELECT Id FROM dbo.Product
INTERSECT
SELECT ProductId FROM dbo.OrderDetails

-- List all regions where we hae BusinessEntities and Customers in the same time

SELECT Region FROM dbo.BusinessEntity
INTERSECT
SELECT RegionName FROM dbo.Customer

CREATE TABLE [ProductTest] (
	[Id] int IDENTITY(1,1) NOT NULL,
	[Code] nvarchar(50) NULL,
	[Name] nvarchar(100) NULL,
	[Description] nvarchar(max) NULL,
	[Weight] decimal(18, 2) NULL,
	[Price] decimal(18,2) NULL,
	[Cost] decimal(18,2) NULL,
	
	CONSTRAINT [PK_ProductTest] PRIMARY KEY (Id)
)

-- *** CONSTRAINTS ***

-- *** NOT NULL ***
-- Osiguruva deka kulona nema da ima NULL vrednosti

ALTER TABLE ProductTest
ALTER COLUMN [Name] NVARCHAR(100) NOT NULL

--INSERT INTO dbo.ProductTest (Code, Description, Weight, Price, Cost)
--VALUES ('P001', 'Laptop', 5.0, 100.00, 50.00)

INSERT INTO dbo.ProductTest (Name, Code, Description, Weight, Price, Cost)
VALUES ('Gaming Laptop', 'P001', 'Laptop', 5.0, 100.00, 50.00)



-- *** UNIQUE CONSTRAINT ***

-- Osiguruva deka site vrednosti vo kolona se unikatni (bez duplkati)

ALTER TABLE ProductTest
ADD CONSTRAINT UQ_ProductTest_Code UNIQUE (Code)

INSERT INTO dbo.ProductTest (Name, Code, Description, Weight, Price, Cost)
VALUES ('LCD Monitor', 'P001', 'Laptop', 5.0, 200.00, 150.00)
-- Ova pogore nema da ni dozvoli da go stavime bidejki go imame istiot P001 ID vo prethodniot entry


-- *** CHECK CONSTRAINT ***
-- Osiguruva deka vrednosti mora da imaat specificen uslov

ALTER TABLE dbo.ProductTest
ADD CONSTRAINT CHK_ProductTest_Weight CHECK (Weight > 0)

INSERT INTO dbo.ProductTest (Name, Code, Description, Weight, Price, Cost)
VALUES ('Speaker', 'P002', 'Bluetooth Speaker', 0, 100.00, 50.00)

SELECT * FROM ProductTest


-- *** DEFAULT ***
-- Avtomatski stava default vrednost ako nikakva vrednost ne e zadadena

ALTER TABLE dbo.ProductTest
ADD CONSTRAINT DF_ProductTest_Cost DEFAULT (1.01) FOR Cost

INSERT INTO dbo.ProductTest (Name, Code, Description, Weight, Price)
VALUES ('Mouse', 'P003', 'Gaming Mouse',45.0, 90.00)



ALTER TABLE dbo.Product
ADD CONSTRAINT CHK_Product_Price CHECK (Price <= Cost * 2)
