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