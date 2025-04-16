

-- DEKLARIRANJE NA VARIJABLI

DECLARE @FirstName NVARCHAR(50);
DECLARE @LastName NVARCHAR(50) = 'Bobsky'
SET @FirstName = 'Bob'

SELECT @FirstName + ' ' + @LastName AS [Employee Full Name] -- Ili samo so obichni navodnici aka 'Employee Full Name'

-- Za da se prikaze dole vo tabela mora da bide celosno selektirano a ne oddelno. Zaedno so declare i selectot


-- Primer: Celosni narachki

DECLARE @TotalOrders INT;
SET @TotalOrders = (SELECT COUNT(Id) FROM dbo.[Order])
SELECT @TotalOrders AS TotalOrders



-- ***************** TABELARNI VARIJABLI *******************


-- Primer: Zachuvaj gi site mashki rabotnici vo tabelarna varijabla

DECLARE @MaleEmployees TABLE (
Id INT,
FirstName NVARCHAR(100),
LastName NVARCHAR(100)
);

INSERT INTO @MaleEmployees (Id, FirstName, LastName)
VALUES
(1, 'Jon', 'Smith'),
(2, 'Jane', 'Smith')

SELECT * FROM @MaleEmployees

-- Stavanje existing male employees od Employee
INSERT INTO @MaleEmployees (Id, FirstName, LastName)
-- Vrednostite
SELECT e.Id, e.FirstName, e.LastName
FROM dbo.Employee e
WHERE LOWER(e.Gender) = 'm'
SELECT * FROM @MaleEmployees





-- *************************** TEMPORARY TABLE *********************************

CREATE TABLE #FemaleEmployeesTemp (
Id INT,
FirstName NVARCHAR(100),
LastName NVARCHAR(100)
)

INSERT INTO #FemaleEmployeesTemp (Id, FirstName, LastName)
VALUES
(1, 'Jane', 'Doe'),
(2, 'Zaneta', 'Estetik')

SELECT * FROM #FemaleEmployeesTemp

-- Se dodeka ne izgasis SSMS togas ovaa privremena tabela ke ti sedi celo vreme. Chim izgasis, gore levo vo System Databases/Tempdb/TemporaryTables/femaleemployeestemp



-- ************************ SWITCH CASE // IF ELSE'S    ILI     FLOW CONTROL *****************************

--******* IF ELSE'OVI *********

DECLARE @IsActive BIT = 0;

IF @IsActive = 1
	PRINT 'Customer is active'
ELSE
	PRINT 'Customer is not active'


-- ***** CASE ILI SWITCH ******

-- Primer: Stavanje Gender code vo text. T.e M ili F da pishuva Male ili Female

SELECT
Id,
FirstName,
LastName,
Gender,
CASE Gender
	WHEN 'M' THEN 'MALE'
	WHEN 'F' THEN 'FEMALE'
	END AS GenderText
FROM dbo.Employee



-- Primer: Proveri status na Order

SELECT 
o.Id, 
o.[Status],
CASE o.[Status]
	WHEN 0 THEN 'Pending'
	WHEN 1 THEN 'Shipping'
	WHEN 2 THEN 'Delivered'
	WHEN 3 THEN 'Canceled'
	ELSE 'Unknown'
	END AS StatusText
FROM [Order] o





-- ******************************************* BUILT IN FUNCTIONS ************************************************


-- Mozat da se najdat vo Programmability/Functions folderot od levo

-- *** CAST *** - Konvertira izraz od eden data tip vo drug

-- Decimalka vo Integer
SELECT CAST(140.533 AS INT) AS RoundedNumber


-- Datum vo String
SELECT CAST(GETDATE() AS NVARCHAR(20)) AS DateAsText



-- ********  STRING FUNCTIONS **********

-- 1. **** LEN() ****

SELECT e.FirstName, LEN(e.FirstName) AS FirstNameLength FROM dbo.Employee e


-- 2. ***** UPPER () / LOWER () *******

SELECT
	Name,
	UPPER(Name) as UpperCased,
	LOWER(Name) as LowerCased
FROM dbo.BusinessEntity


-- 3. **** SUBSTRING() ****

SELECT
	FirstName, SUBSTRING(FirstName, 1,2) AS FirstTwoLetters
FROM dbo.Employee


-- 4. ****** LEFT() / RIGHT() ******

SELECT 
	AccountNumber,
	LEFT(AccountNumber, 2) AS AccountPrefix,
	RIGHT(AccountNumber, 2) AS AccountSuffix
FROM Customer


-- 5. ****** REPLACE() ******
SELECT c.PhoneNumber, REPLACE(c.PhoneNumber, '070', '+38970') AS AddedPrefix FROM Customer c




-- *********** DATE FUNCTIONS *************

-- 1. *** GETDATE () ***

SELECT GETDATE() AS CurrentDateTime
SELECT GETUTCDATE() AS CurrentDateTime


-- 2. *** DATEDIFF() ***
SELECT
	FirstName,
	LastName,
	DateOfBirth,
	DATEDIFF(YEAR, DateOfBirth, GETUTCDATE()) AS Age
FROM Employee




-- ********** NUMERIC FUNCTIONS *************


-- 1. *** ROUND *** - Zaokruzuva brojki

SELECT Name, Price, ROUND(Price, 0) AS RoundedPrice FROM dbo.[Product]

-- 2. *** ISNULL() ***

SELECT Name, ISNULL(PhoneNumber, 'N/A') AS DisplayPhoneNumber FROM Customer





-- ******** SCALAR FUNCTIONS *********

CREATE FUNCTION fn_GetEmployeeFullName (@EmployeeId INT)
	RETURNS NVARCHAR(200)
AS
	BEGIN 
	DECLARE @Result NVARCHAR(200);
	SET @Result = 
	(SELECT e.FirstName + ' ' + e.LastName
	FROM dbo.Employee e
	WHERE e.Id = @EmployeeId)

	RETURN @Result
	END


SELECT [dbo].[fn_GetEmployeeFullName](50)