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



-- PRIMARY KEY e glavniot identifikator na eden rekord vo tabela

-- FOREIGN KEY sluzhat kako pokazateli do nekoj rekord od druga tabela. 

SELECT * FROM [dbo].[BusinessEntity]
SELECT * FROM [dbo].[Customer]
SELECT * FROM [dbo].[Product]
SELECT * FROM [dbo].[Employee]
SELECT * FROM [dbo].[Order]
SELECT * FROM [dbo].[OrderDetails]

-- *** Foreign keys of ORDER table ***

ALTER TABLE [dbo].[Order]
ADD CONSTRAINT FK_Order_BusinessEntity FOREIGN KEY (BusinessEntityId) REFERENCES BusinessEntity(Id)

-- *** FK: Order => Customer
-- One to Many Relationship
-- One customer can place many Orders

ALTER TABLE [dbo].[Order]
ADD CONSTRAINT FK_Order_Customer FOREIGN KEY (CustomerId) REFERENCES Customer(Id)











-- *************************** JOINS ******************************

CREATE TABLE TableA (idA INT NOT NULL);
CREATE TABLE TableB (idB INT NOT NULL);

INSERT INTO TableA VALUES (1), (2), (3)
INSERT INTO TableB VALUES (2), (3), (4)

SELECT * FROM TableA
SELECT * FROM TableB


-- **** Cross Join ****
SELECT * FROM TableA
CROSS JOIN TableB



-- *** Inner Join ***
SELECT * FROM TableA
INNER JOIN TableB ON idA = idB



-- *** Left Join ***
SELECT * FROM TableA
LEFT JOIN TableB ON idA = idB



-- *** Right Join ***
SELECT * FROM TableA
RIGHT JOIN TableB ON idA = idB



-- *** Full Join ***
SELECT * FROM TableA
FULL JOIN TableB ON idA = idB





-- **** WORKSHOP 6 ****
SELECT * FROM [dbo].[BusinessEntity]
SELECT * FROM [dbo].[Customer]
SELECT * FROM [dbo].[Product]
SELECT * FROM [dbo].[Employee]
SELECT * FROM [dbo].[BusinessEntity]
SELECT * FROM [dbo].[OrderDetails]
SELECT * FROM [dbo].[Order]


SELECT c.Name AS [Customer Name], p.Name AS [Product Name] FROM Customer c
CROSS JOIN Product p



-- *** List all Business Entities That have any Order
SELECT * FROM [dbo].[BusinessEntity]
SELECT * FROM [dbo].[Order]


SELECT DISTINCT be.* FROM dbo.BusinessEntity be
JOIN dbo.[Order] o ON o.BusinessEntityId = be.Id










-- ************************************************************************ A  G  R  E  G  A  T  I  O  N  S *******************************************************************************

-- PRIMER: Totalna suma na narachki od Business Entity

SELECT be.Name, SUM (o.TotalPrice) FROM dbo.[Order] o
JOIN dbo.BusinessEntity be ON be.Id = o.BusinessEntityId
GROUP BY be.Name


-- PRIMER: Brojka na vraboteni spored rod

SELECT e.Gender, COUNT(Id) AS GenderCount FROM dbo.Employee e
GROUP BY e.Gender


-- PRIMER: Brojka na Customer, naracka po REGION

SELECT c.RegionName, COUNT(c.Id) FROM dbo.Customer c
INNER JOIN dbo.[Order] o ON c.Id = o.CustomerId
GROUP BY c.RegionName


-- PRIMER: Totalna cena na naracki spored Busines Entity so totalna cena nad 1 million

SELECT be.Name as BusinessEntityName, SUM(o.TotalPrice) FROM dbo.BusinessEntity be
INNER JOIN dbo.[Order] o ON be.Id = o.BusinessEntityId
GROUP BY be.Name
HAVING SUM(o.TotalPrice) > 1000000