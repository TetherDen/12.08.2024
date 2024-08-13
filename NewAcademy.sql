USE Academy;
GO

CREATE TABLE Curators(
	Id int primary key identity(1,1),
	Name nvarchar(max) NOT NULL CHECK(Name<>N''),
	Surname nvarchar(max) NOT NULL CHECK(Surname<>N'')
)
GO

CREATE TABLE Faculties(
	Id int primary key identity(1,1),
	Financing money NOT NULL CHECK(Financing>=0) DEFAULT 0,
	Name nvarchar(100) NOT NULL CHECK(Name<>N'') UNIQUE
)
GO

CREATE TABLE Departments(
	Id int primary key identity(1,1),
	Financing money NOT NULL CHECK(Financing>=0) DEFAULT 0,
	Name nvarchar(100) NOT NULL CHECK(Name<>N'') UNIQUE,
	FacultyId int NOT NULL foreign key references Faculties(Id)
)
GO

CREATE TABLE Groups(
	Id int primary key identity(1,1),
	Name nvarchar(10) NOT NULL CHECK(Name<>N'') UNIQUE,
	Year int NOT NULL CHECK(Year BETWEEN 1 AND 5),
	DepartmentId int NOT NULL foreign key references Departments(Id)
)
GO


CREATE TABLE GroupsCurators(
	Id int primary key identity(1,1),
	CuratorId int NOT NULL foreign key references Curators(Id),
	GroupId int NOT NULL foreign key references Groups(Id)
)
GO

CREATE TABLE Subjects(
	Id int primary key identity(1,1),
	Name nvarchar(100) NOT NULL CHECK(Name<>N'') UNIQUE
)
GO

CREATE TABLE Teachers(
	Id int primary key identity(1,1),
	Name nvarchar(max) NOT NULL CHECK(Name<>N''),
	Salary money NOT NULL CHECK(Salary>0),
	Surname nvarchar(max) NOT NULL CHECK(Surname<>N'')
)
GO

CREATE TABLE Lectures(
	Id int primary key identity(1,1),
	LectureRoom nvarchar(max) NOT NULL CHECK(LectureRoom<>N''),
	SubjectId int NOT NULL foreign key references Subjects(Id),
	TeacherId int NOT NULL foreign key references Teachers(Id)
)
GO

CREATE TABLE GroupsLectures(
	Id int primary key identity(1,1),
	GroupId int NOT NULL foreign key references Groups(Id),
	LectureId int NOT NULL foreign key references Lectures(Id)
)
GO


INSERT INTO Curators (Name, Surname)
VALUES ('John', 'Doe'),
       ('Jane', 'Smith'),
       ('Michael', 'Johnson');
GO

INSERT INTO Faculties (Name)
VALUES ('Engineering'),
       ('Computer Science'),
       ('Business Administration');
GO

INSERT INTO Departments (Name, FacultyId)
VALUES ('Mechanical Engineering', 1),
       ('Software Engineering', 1),
       ('Computer Networks', 2),
       ('Software Development', 2),
       ('Finance', 3);
GO

INSERT INTO Groups (Name, Year, DepartmentId)
VALUES ('ME-1', 1, 1),
       ('SE-1', 1, 2),
       ('CN-2', 2, 4),
       ('SD-3', 3, 5);
GO

INSERT INTO GroupsCurators (CuratorId, GroupId)
VALUES (1, 1),
       (2, 2),
       (1, 3);
GO

INSERT INTO Subjects (Name)
VALUES ('Mathematics'),
       ('Physics'),
       ('Programming'),
       ('Marketing Strategies');
GO

INSERT INTO Teachers (Name, Surname, Salary)
VALUES ('Peter', 'Brown', 45000),
       ('Emily', 'Davis', 50000),
       ('Robert', 'Taylor', 48000);
GO

INSERT INTO Lectures (LectureRoom, SubjectId, TeacherId)
VALUES ('Room A101', 1, 1),
       ('Room B202', 2, 2),
       ('Room C303', 3, 3);
GO

INSERT INTO GroupsLectures (GroupId, LectureId)
VALUES (1, 1),
       (2, 2),
       (3, 3);
GO

--==================================================================================

SELECT * FROM Curators;
SELECT * FROM Faculties;
SELECT * FROM Departments;
SELECT * FROM Groups;
SELECT * FROM GroupsCurators;
SELECT * FROM Subjects;
SELECT * FROM Teachers;
SELECT * FROM Lectures;
SELECT * FROM GroupsLectures;

--==================================================================================

--1. ¬ивести вс≥ можлив≥ пари р€дк≥в викладач≥в та груп.
--SELECT Teachers.Name,Teachers.Surname, Groups.Name as GroupName, Groups.Year, Groups.DepartmentId
--FROM Teachers, Lectures, GroupsLectures, Groups
--WHERE Lectures.TeacherId = Teachers.Id AND GroupsLectures.LectureId = Lectures.Id AND GroupsLectures.GroupId = Groups.Id;
--GO

SELECT Teachers.*, Groups.*
FROM Teachers,Groups;

--2. ¬ивести назви факультет≥в, фонд ф≥нансуванн€ кафедр €ких перевищуЇ фонд ф≥нансуванн€ факультету.
SELECT Faculties.Name
FROM Departments
JOIN Faculties ON Departments.FacultyId = Faculties.Id
WHERE Departments.Financing >= Faculties.Financing;
GO

--3. ¬ивести пр≥звища куратор≥в груп та назви груп, €к≥ вони курирують.
SELECt Curators.Surname, Groups.Name
FROM Curators,Groups,GroupsCurators
WHERE GroupsCurators.GroupId = Groups.Id AND GroupsCurators.CuratorId=Curators.Id;
GO

--4. ¬ивести ≥мена та пр≥звища викладач≥в, €к≥ читають лекц≥њ у груп≥ УME-1Ф
SELECT Teachers.Name,Teachers.Surname
FROM Teachers
JOIN Lectures ON Teachers.Id = Lectures.TeacherId
JOIN GroupsLectures ON Lectures.Id = GroupsLectures.LectureId
JOIN Groups ON GroupsLectures.GroupId = Groups.Id
WHERE Groups.Name = 'ME-1';
GO

-- 5. ¬ивести пр≥звища викладач≥в та назви факультет≥в, на €ких вони читають лекц≥њ.
SELECT Teachers.Name,Teachers.Surname, Faculties.Name
FROM Teachers
JOIN Lectures ON Teachers.Id = Lectures.TeacherId
JOIN GroupsLectures ON Lectures.Id = GroupsLectures.LectureId
JOIN Groups ON GroupsLectures.GroupId = Groups.Id
JOIN Departments ON Departments.Id = Groups.DepartmentId
JOIN Faculties ON Departments.FacultyId = Faculties.Id;
GO

--6. ¬ивести назви кафедр та назви груп, €к≥ до них належать.
SELECT Departments.Name, Groups.Name
FROM Groups
JOIN Departments ON Groups.DepartmentId = Departments.Id;
GO



--7. ¬ивести назви дисципл≥н, €к≥ читаЇ викладач УSamantha AdamsФ.
SELECT Subjects.Name
FROM Subjects
JOIN Lectures ON Subjects.Id = Lectures.SubjectId
JOIN Teachers ON Teachers.Id = Lectures.TeacherId
WHERE Teachers.Name = 'Emily' AND Teachers.Surname = 'Davis';
GO

--8. ¬ивести назви кафедр, де читаЇтьс€ дисципл≥на УDatabase TheoryФ.
SELECT Departments.Name
FROM Departments
JOIN Groups ON Groups.DepartmentId = Departments.Id
JOIN GroupsLectures ON GroupsLectures.GroupId = Groups.Id
JOIN Lectures ON Lectures.Id = GroupsLectures.LectureId
JOIN Subjects ON Subjects.Id = Lectures.SubjectId
WHERE Subjects.Name = 'Programming';
GO

-- 9. ¬ивести назви груп, що належать до факультету Computer Science.
SELECT Groups.Name
FROM Groups
JOIN Departments ON Departments.Id = Groups.DepartmentId
JOIN Faculties ON Faculties.Id = Departments.FacultyId
WHERE Faculties.Name = 'Computer Science';
GO

-- 10. ¬ивести назви груп 5-го курсу, а також назву факультет≥в, до €ких вони належать.
SELECT Groups.Name, Groups.Year, Faculties.Name
FROM Groups
JOIN Departments ON Departments.Id = Groups.DepartmentId
JOIN Faculties ON Departments.FacultyId = Faculties.Id
WHERE Groups.Year = 5;

--11. ¬ивести повн≥ ≥мена викладач≥в та лекц≥њ, €к≥ вони читають (назви дисципл≥н та груп), причому в≥д≥брати лише т≥
--лекц≥њ, що читаютьс€ в аудитор≥њ УB103Ф. 

SELECT Teachers.Name,Teachers.Surname, Subjects.Name as SubjectName, Groups.Name as GroupName, Lectures.LectureRoom
FROM Teachers
JOIN Lectures ON Lectures.TeacherId = Teachers.Id
JOIN Subjects ON Subjects.Id = Lectures.SubjectId
JOIN GroupsLectures ON GroupsLectures.LectureId = Lectures.Id
JOIN Groups ON Groups.Id = GroupsLectures.GroupId
WHERE Lectures.LectureRoom = 'Room C303';
GO