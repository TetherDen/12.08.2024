use Academy;
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
--  TODO: THere is no Student count in DB
--  TODO: Добавить таблицу студентов

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
-- TODO: STUDENTS
--SELECT MAX(StudentsInGroup)
--FROM Groups



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

--10. Вивести кількість лекцій щодня протягом тижня
-- TODO:   кількість лекцій щодня протягом тижня ?

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