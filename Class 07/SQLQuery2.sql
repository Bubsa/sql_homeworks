USE SEDC
GO


--                                                                      **********  STORNI PROCEDURI  *************

CREATE OR ALTER PROCEDURE usp_GetAllEmployees
AS 
	BEGIN
	SELECT * FROM dbo.Employee
	END
	
	EXEC [dbo].[usp_GetAllEmployees]


CREATE OR ALTER PROCEDURE usp_GetEmployeeByID
@EmployeeId INT
AS

BEGIN
SELECT * FROM dbo.Employee e WHERE e.Id = @EmployeeId
END

EXEC usp_GetEmployeeByID 10
-- Podobar nachin so imenuvanje na argumentot
EXEC usp_GetEmployeeByID @EmployeeId = 56
-- Ne moze povekje argumenti da se dadat. U smisol najdi mi employees so 1 i 56 taka nesho. Dava greshka taka.


-- NOV PRIMER: Zemi vraboteni po pol i nivniot broj

CREATE OR ALTER PROCEDURE dbo.usp_GenderCount
(@Gender CHAR,
@GenderCount INT OUT
)

AS

	BEGIN
	SELECT * FROM dbo.Employee e WHERE e.Gender = @Gender
	SET @GenderCount = 
	(SELECT COUNT(Id) FROM dbo.Employee e WHERE e.Gender = @Gender)
	END

DECLARE @GenderCountResult INT

EXEC usp_GenderCount
	@Gender = 'M',
	@GenderCount = @GenderCountResult OUT

SELECT @GenderCountResult AS 'GenderCount'