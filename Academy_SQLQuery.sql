CREATE DATABASE Academy;
GO

USE Academy;
GO

CREATE TABLE Groups(
	Id int primary key identity(1,1),
	Name nvarchar(10) NOT NULL CHECK (Name != '') UNIQUE,
	Rating int CHECK(Rating BETWEEN 0 AND 5) NOT NULL,
	Year int CHECK(Year BETWEEN 1 AND 5) NOT NULL
)
GO

CREATE TABLE Departments(
	Id int primary key identity(1,1),
	Financing money DEFAULT 0 CHECK(Financing >= 0)  NOT NULL,
	Name nvarchar(100) UNIQUE CHECK(Name != '') NOT NULL,
)
GO

CREATE TABLE Faculties(
	Id int primary key identity(1,1),
	Dean nvarchar(max) CHECK(Dean != '' AND Dean != NULL),
	Name nvarchar(100) UNIQUE CHECK(Name != '') NOT NULL
)
GO

--CREATE TABLE Teachers(
--	Id int primary key identity(1,1),
--	EmploymentDate date CHECK(EmploymentDate >= '01.01.1990') NOT NULL,
--	Name nvarchar(max) CHECK(Name != '') NOT NULL,
--	Premium money DEFAULT 0 CHECK(Premium >=0) NOT NULL,
--	Salary money CHECK(Salary >0) NOT NULL,
--	Surname nvarchar(max) CHECK(Surname !='') NOT NULL
--)
--GO

create table [Teachers]
(
	[Id] int not null identity(1, 1) primary key,
	[EmploymentDate] date not null check ([EmploymentDate] >= '1990-01-01'),
	[IsAssistant] bit not null default 0,
	[IsProfessor] bit not null default 0,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Position] nvarchar(max) not null check ([Position] <> N''),
	[Premium] money not null check ([Premium] >= 0.0) default 0.0,
	[Salary] money not null check ([Salary] > 0.0),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
);
go

-- Заполнение таблицы Groups
INSERT INTO Groups (Name, Rating, Year)
VALUES
('Group A', 3, 1),
('Group B', 4, 2),
('Group C', 5, 3),
('Group D', 2, 1),
('Group E', 1, 2);
GO

-- Заполнение таблицы Departments
INSERT INTO Departments (Financing, Name)
VALUES
(500000, 'Science Department'),
(250000, 'Math Department'),
(300000, 'Literature Department'),
(100000, 'Art Department'),
(150000, 'History Department');
GO

-- Заполнение таблицы Faculties
INSERT INTO Faculties (Dean, Name)
VALUES
('John Doe', 'Science'),
('Jane Smith', 'Mathematics'),
('Alice Johnson', 'Literature'),
('Robert Williams', 'Arts'),
('Emily Brown', 'History');
GO

-- Заполнение таблицы Teachers
INSERT INTO Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname)
VALUES
('1995-09-01', 0, 1, 'John', 'Professor', 5000, 60000, 'Doe'),
('2000-01-15', 0, 0, 'Jane', 'Lecturer', 3000, 55000, 'Smith'),
('2010-05-20', 1, 0, 'Alice', 'Assistant', 2000, 50000, 'Johnson'),
('2005-11-30', 0, 1, 'Robert', 'Professor', 4000, 58000, 'Williams'),
('2012-08-25', 1, 0, 'Emily', 'Assistant', 2500, 51000, 'Brown');
GO





SELECT * FROM Departments ORDER BY Id DESC;

SELECT Name as 'Group Name', Rating as 'Group Rating'
FROM Groups;

SELECT Surname, Salary,Premium 
FROM  Teachers;

SELECT  'The dean of faculty ' + Name + ' is ' + Dean + '.'
FROM  Faculties;

SELECT Surname 
FROM Teachers
WHERE IsProfessor=1 AND Salary>1050;

SELECT Name 
FROM Departments
WHERE Financing< 11000 OR Financing>25000;

SELECT Name
FROM Faculties
WHERE Name != 'Computer Science';

SELECT Surname, Position
FROM Teachers
WHERE IsProfessor = 0;

SELECT Surname,Position,Salary,Premium
FROM Teachers
WHERE IsAssistant=1 AND Premium BETWEEN 160 AND 550;

SELECT Surname,Salary
FROM Teachers
WHERE IsAssistant=1;

SELECT Surname,Position
FROM Teachers
WHERE EmploymentDate<'01.01.2000';

SELECT Name AS 'Name of Department'
FROM Departments
WHERE Name < 'Software Development'
ORDER BY Name ASC;

SELECT Surname
FROM Teachers
WHERE IsAssistant=1 AND (Salary+Premium)<=1200;

SELECT Name
FROM Groups
WHERE Rating BETWEEN 2 AND 4 AND Year=5;

SELECT Surname
FROM Teachers
WHERE IsAssistant=1 AND SALARY<=550 OR Premium<200;