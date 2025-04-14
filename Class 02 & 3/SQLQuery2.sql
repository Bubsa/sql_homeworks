CREATE DATABASE [SEDC_DEMO]

USE [SEDC_DEMO]



-- *** ONE TO ONE (1:1) *** 

CREATE TABLE [Person](
Id INT PRIMARY KEY,
[Name] NVARCHAR(100) NOT NULL,

)

CREATE TABLE Passport(
Id INT PRIMARY KEY,
PassportNumber NVARCHAR(50) NOT NULL,
PersonId INT UNIQUE,
CONSTRAINT FK_Passport_Person FOREIGN KEY (PersonId) REFERENCES Person(Id) -- Se pisuva constraintot dole. FK za foreign key, od passport do person, pa pak Foreign Key (koja kolona)
-- pa se pishuva references Tabelata od kaj sho povrzuvame (Kolonata sho ja stavame)

)


-- *** ONE TO MANY (1:M)

CREATE TABLE Department(
Id INT PRIMARY KEY,
Name NVARCHAR(100) NOT NULL
)

CREATE TABLE Employee(
Id INT PRIMARY KEY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
DepartmentId INT NOT NULL,
CONSTRAINT FK_Employee_Department FOREIGN KEY (DepartmentId) REFERENCES Department(Id)
)


-- *** MANY TO MANY (M:M) ***

CREATE TABLE Student(
Id INT PRIMARY KEY,
FullName NVARCHAR(100) NOT NULL
)

CREATE TABLE Course(
Id INT PRIMARY KEY,
[Name] NVARCHAR(100) NOT NULL
)

CREATE TABLE StudentCourse(
Id INT PRIMARY KEY,
StudentId INT,
CourseId INT,
)

ALTER TABLE StudentCourse
ADD CONSTRAINT FK_StudentCourse_Student FOREIGN KEY (StudentId) REFERENCES Student(Id);

ALTER TABLE StudentCourse
ADD CONSTRAINT FK_StudentCourse_Course FOREIGN KEY (CourseId) REFERENCES Course(Id);
