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