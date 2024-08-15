use Academy;
GO

-- Добавление DayOfWeek в таблицу GroupsLectures 
ALTER TABLE GroupsLectures 
ADD DayOfWeek int CHECK(DayOfWeek BETWEEN 1 AND 7 )
GO

UPDATE GroupsLectures SET DayOfWeek = 5 WHERE Id = 2;
GO


-- 1. Вивести кількість викладачів кафедри «Software Development».
SELECT COUNT (DISTINCT Teachers.Id) as 'Software Teachers'
FROM Teachers
JOIN  Lectures ON Lectures.TeacherId = Teachers.Id
JOIN GroupsLectures ON GroupsLectures.LectureId = Lectures.Id
JOIN Groups ON Groups.Id = GroupsLectures.GroupId
JOIN Departments ON Departments.Id = Groups.DepartmentId
WHERE Departments.Name = 'Software Development';
GO

--2. Вивести кількість лекцій, які читає викладач “Dave McQueen”.
SELECT COUNT (*)
FROM Lectures
JOIN Teachers ON Teachers.Id = Lectures.TeacherId
WHERE Teachers.Name = 'Robert' AND Teachers.Surname = 'Taylor';
GO

--3. Вивести кількість занять, які проводяться в аудиторії “D201”
SELECT COUNT (*)
FROM Lectures
WHERE Lectures.LectureRoom = 'Room A101';
GO

-- 4. Вивести назви аудиторій та кількість лекцій, що проводяться в них.
SELECT Lectures.LectureRoom, COUNT (*) as LecturesCount
FROM Lectures
GROUP BY Lectures.LectureRoom;
GO

--5. Вивести кількість студентів, які відвідують лекції викладача “Jack Underhill”.
SELECT COUNT (DISTINCT Students.Id) as PeterBrownStudentsCount
FROM Students
JOIN Groups ON Groups.Id = Students.GroupId
JOIN GroupsLectures ON GroupsLectures.GroupId = Groups.Id
JOIN Lectures ON Lectures.Id = GroupsLectures.LectureId
JOIN Teachers ON Teachers.Id = Lectures.TeacherId
WHERE Teachers.Name = 'Peter' AND Teachers.Surname = 'Brown'
GO


-- 6. Вивести середню ставку викладачів факультету Computer Science.
SELECT AVG(Salary)
FROM Teachers
JOIN Lectures ON Lectures.TeacherId = Teachers.Id
JOIN GroupsLectures ON GroupsLectures.LectureId = Lectures.Id
JOIN Groups ON Groups.Id = GroupsLectures.GroupId
JOIN Departments ON Departments.Id = Groups.DepartmentId
JOIN Faculties ON Departments.FacultyId = Faculties.Id
WHERE Faculties.Name = 'Computer Science';
GO

-- 7. Вивести мінімальну та максимальну кількість студентів серед усіх груп.

SELECT Students.GroupId, Groups.Name, COUNT(*) as GroupStudentCOunt FROM Students
JOIN Groups ON Groups.Id = Students.GroupId
GROUP BY Students.GroupId,Groups.Name
HAVING MAX()    -- Tyt nado kak-to  HAVING MAX sdelat !?
GO

SELECT COUNT(*) as MaxGroup FROM Students, Groups
WHERE Students.GroupId = Groups.Id  AND Students.GroupId = (SELECT MAX (Students.GroupId) FROM Students)  ;
GO



--8. Вивести середній фонд фінансування кафедр.
SELECT AVG(Financing) as AverageFinancing
FROM Departments;
GO

--9. Вивести повні імена викладачів та кількість читаних ними дисциплін.
SELECT Teachers.Name,Teachers.Surname, COUNT(DISTINCT Subjects.Name) as CountSubjects
FROM Teachers
JOIN Lectures ON Lectures.TeacherId = Teachers.Id
JOIN Subjects ON Lectures.SubjectId = Subjects.Id
GROUP BY Teachers.Name, Teachers.Surname;
GO

-- 10. Вивести кількість лекцій щодня протягом тижня.
SELECT COUNT(GroupsLectures.DayOfWeek), GroupsLectures.DayOfWeek FROM GroupsLectures
JOIN Lectures ON GroupsLectures.LectureId = Lectures.Id
GROUP BY GroupsLectures.DayOfWeek 
GO

--11. Вивести номери аудиторій та кількість кафедр, чиї лекції в них читаються.
SELECT Lectures.LectureRoom, COUNT(DISTINCT Departments.Id)
FROM Lectures
JOIN GroupsLectures ON GroupsLectures.LectureId = Lectures.Id
JOIN Groups ON Groups.Id = GroupsLectures.GroupId
JOIN Departments ON Departments.Id = Groups.DepartmentId
GROUP BY Lectures.LectureRoom;
GO

-- 12.Вивести назви факультетів та кількість дисциплін, які на них читаються.
SELECT Faculties.Name, COUNT(DISTINCT Subjects.Id) as CountSubjects
FROM Faculties
JOIN Departments ON Departments.FacultyId = Faculties.Id
JOIN Groups ON Groups.DepartmentId = Departments.Id
JOIN GroupsLectures ON GroupsLectures.GroupId = Groups.Id
JOIN Lectures ON Lectures.Id = GroupsLectures.LectureId
JOIN Subjects ON Subjects.Id = Lectures.SubjectId
GROUP BY Faculties.Name;
GO

--13. Вивести кількість лекцій для кожної пари викладач-аудиторія. 
SELECT Teachers.Name,Teachers.Surname,Lectures.LectureRoom,COUNT(*)
FROM Lectures
JOIN Teachers ON Teachers.Id = Lectures.TeacherId
GROUP BY Teachers.Name,Teachers.Surname,Lectures.LectureRoom;
GO

--===================================================================

CREATE TABLE Students(
	Id int primary key identity(1,1),
	Name nvarchar(max) NOT NULL CHECK(Name<>N''),
	Surname nvarchar(max) NOT NULL CHECK(Surname<>N''),
	GroupId int NOT NULL FOREIGN KEY REFERENCES Groups(Id)
)
GO

INSERT INTO Students (Name, Surname, GroupId)
VALUES 
    ('Alice', 'Johnson', 1),
    ('Bob', 'Smith', 2),
    ('Charlie', 'Brown', 3),
    ('Diana', 'White', 4),
    ('Eve', 'Black', 1),
    ('Frank', 'Green', 2),
    ('Grace', 'Blue', 3),
    ('Hank', 'Yellow', 4),
    ('Ivy', 'Red', 1),
    ('Jack', 'Orange', 2),
    ('Kara', 'Purple', 3),
    ('Leo', 'Pink', 4),
    ('Mia', 'Gray', 1),
    ('Nina', 'Silver', 2),
    ('Oscar', 'Gold', 3),
    ('Paul', 'Bronze', 4),
    ('Quinn', 'Copper', 4),
    ('Rita', 'Platinum', 2),
    ('Sam', 'Diamond', 3),
    ('Tina', 'Emerald', 4);
GO

--===================================================================
