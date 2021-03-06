							/* 2 */   
SELECT id, FirstName, LastName, Position,
 CONVERT(VARCHAR(50),  CAST((CAST(DATEDIFF(MONTH, EmploymentDate, GETDATE()) 
 AS decimal(3,1)) / 12) AS decimal(1,0))) + '  Years'  AS 'Employed Since',
SSN, Phone, Email FROM Staff ;

SELECT * FROM StafF

INSERT INTO Staff
(FirstName, LastName, Position, EmploymentDate, SSN, Phone, Email) VALUES
('Test', 'Testson', 'Maintenance', CAST(CONVERT(DATE, GETDATE()) AS VARCHAR),
'7891471239', '+46 70 111 22 33', 'test.testson@happyvalley.com');

DELETE Staff WHERE FirstName ='Test';
SELECT * FROM Staff;
DBCC CHECKIDENT (staff, reseed, 14); 

SELECT * FROM Student;


							/* 3  */
/* Add a student */
INSERT INTO Student(FirstName, LastName, SSN, Class, Email) VALUES
('Test','Testson', '3697891234', 'Junior year', 'test.testson@happyvalley.com');
/* Set a grade  */
INSERT INTO Programming(StudentId, [Date], TeacherId, Grade, GradeSubmitted) VALUES
(1, '2022-02-01', 8, 'C', CONVERT(DATE, GETDATE()) );

DELETE Student WHERE FirstName ='Test';
DBCC CHECKIDENT (Student, reseed, 13);
DELETE Programming WHERE StudentId = 1;

/* SELECT Students, grades, teacher */
SELECT Grades.Student, Grades.Student, Grades.Class, Grades.Grade,
Grades.[Subject], Grades.[Date], Grades.Teacher FROM Grades;
/*
CREATE VIEW Grades AS 
SELECT Math.StudentId, CONCAT(Student.FirstName,' ' ,Student.LastName) AS 'Student',
Student.Class, Math.Grade, 'Math' AS [Subject], Math.GradeSubmitted AS 'Date',
CONCAT(Staff.FirstName,' ' ,Staff.LastName) AS 'Teacher'
FROM Student, Math, Staff 
WHERE Grade IS NOT NULL
AND Staff.id = TeacherId AND Math.StudentId = Student.id
UNION
SELECT English.StudentId, CONCAT(Student.FirstName,' ' ,Student.LastName) AS 'Student',
Student.Class, English.Grade, 'English' AS [Subject], English.GradeSubmitted AS 'Date',
CONCAT(Staff.FirstName,' ' ,Staff.LastName) AS 'Teacher'
FROM Student, English, Staff 
WHERE Grade IS NOT NULL
AND Staff.id = TeacherId AND English.StudentId = Student.id
UNION
SELECT Programming.StudentId, CONCAT(Student.FirstName,' ' ,Student.LastName) AS 'Student',
Student.Class, Programming.Grade, 'Programming' AS [Subject], Programming.GradeSubmitted AS 'Date',
CONCAT(Staff.FirstName,' ' ,Staff.LastName) AS 'Teacher'
FROM Student, Programming, Staff 
WHERE Grade IS NOT NULL
AND Staff.id = TeacherId AND Programming.StudentId = Student.id;
*/


							/* 7  - Salaries/month for different positions*/
DECLARE @teacher INT = 0, @admin INT = 0, @handyman INT = 0
SELECT 
SUM(CASE WHEN Position ='Teacher' THEN @teacher + Salary END) AS 'Teacher', 
SUM(CASE WHEN Position = 'Principal' THEN @admin + Salary 
		 WHEN Position = 'Vice Principal' THEN @admin + Salary 
  END) AS 'Administration',
  SUM(CASE WHEN Position ='Handyman' THEN @handyman + Salary
  WHEN Position ='Webmaster' THEN @handyman + Salary
  WHEN Position ='Janitor' THEN @handyman + Salary
  END) AS 'Maintenance'  FROM Staff;


						   /* 7  - Salaries/month for different subjects*/
DECLARE @englishSal INT = 0, @mathSal INT = 0, @ProgrammingSal INT = 0
SELECT  
SUM(CASE WHEN Course.[Name] ='English' THEN @englishSal + Staff.Salary END) AS 'English',
SUM(CASE WHEN Course.[Name] ='Math' THEN @mathSal + Staff.Salary END) AS 'Math',
SUM(CASE WHEN Course.[Name] ='Programming' THEN @ProgrammingSal + Staff.Salary END) AS 'Programming'
FROM Staff 
INNER JOIN TeacherCourse ON TeacherCourse.TeacherId = Staff.id 
INNER JOIN Course ON Course.id = TeacherCourse.CourseId;


							/* 8  - Average salary/month for different positions*/   
DECLARE @teacher INT = 0, @admin INT = 0, @handyman INT = 0
SELECT 
AVG(CASE WHEN Position ='Teacher' THEN @teacher + Salary END) AS 'Teacher', 
AVG(CASE WHEN Position = 'Principal' THEN @admin + Salary 
		 WHEN Position = 'Vice Principal' THEN @admin + Salary 
  END) AS 'Administration',
  AVG(CASE WHEN Position ='Handyman' THEN @handyman + Salary
  WHEN Position ='Webmaster' THEN @handyman + Salary
  WHEN Position ='Janitor' THEN @handyman + Salary
  END) AS 'Maintenance'  FROM Staff;


  							/* 8  - Average salary/month for different subjects*/   
DECLARE @englishSal INT = 0, @mathSal INT = 0, @ProgrammingSal INT = 0
SELECT  
AVG(CASE WHEN Course.[Name] ='English' THEN @englishSal + Staff.Salary END) AS 'English',
AVG(CASE WHEN Course.[Name] ='Math' THEN @mathSal + Staff.Salary END) AS 'Math',
AVG(CASE WHEN Course.[Name] ='Programming' THEN @ProgrammingSal + Staff.Salary END) AS 'Programming'
FROM Staff 
INNER JOIN TeacherCourse ON TeacherCourse.TeacherId = Staff.id 
INNER JOIN Course ON Course.id = TeacherCourse.CourseId;


							/* 9 */
CREATE PROCEDURE spStudent_GetInfo
@i INT 
AS SELECT Student.id, Student.FirstName, Student.LastName, Student.SSN
, Student.Class, Student.Email, English.Grade AS 'English', Math.Grade AS 'Math',
ISNULL(Programming.Grade, '') AS 'Programming' FROM Student
LEFT JOIN English ON English.StudentId = Student.id 
LEFT JOIN Math ON Math.StudentId = Student.id 
LEFT JOIN Programming ON (Programming.StudentId = Student.id AND Programming.Grade IS NOT NULL)
WHERE Student.id = @i

DECLARE @num INT = 1
WHILE @num <= ( SELECT COUNT (Student.FirstName) FROM Student)
	BEGIN
EXEC dbo.spStudent_GetInfo @num;
SET @num = @num + 1
END


							/* 10 */
CREATE PROCEDURE spProgramming_SetGrade
@studentId INT, @date DATE, @grade VARCHAR(2), @teacherId INT AS
    BEGIN TRY
	BEGIN TRANSACTION
	INSERT INTO Programming (StudentId, [Date] ,Grade,  TeacherId, GradeSubmitted) VALUES 
	(@studentId, @date, @grade, @teacherId, CONVERT(DATE, GETDATE()))
	COMMIT 
	PRINT('Grade was submitted successfully !')
END TRY
BEGIN CATCH
	ROLLBACK
	PRINT('En error was occurred !')
END CATCH;
/* --- */
EXEC spProgramming_SetGrade 1, '2022-01-08', 'D',  7;

DELETE Programming WHERE StudentId = 1;
SELECT * FROM Programming;


							/* 11 */
EXEC spStudentTeacher_Getinfo 11;  /* Type in an id to test */

CREATE PROCEDURE spStudentTeacher_Getinfo
@id SMALLINT AS
SELECT Student.id, Student.FirstName, Student.LastName, Student.Class, Student.SSN, 'Programming' AS Subject,
Programming.Grade, Programming.GradeSubmitted, CONCAT(Staff.FirstName, ' ',Staff.LastName)
AS 'Teacher' FROM Student
INNER JOIN Programming ON Programming.StudentId = Student.id
INNER JOIN Staff ON Staff.id = Programming.TeacherId
WHERE Student.id = @id   
UNION
SELECT Student.id, Student.FirstName, Student.LastName, Student.Class, Student.SSN, 'Math' AS Subject,
Math.Grade, Math.GradeSubmitted, CONCAT(Staff.FirstName, ' ',Staff.LastName) 
AS 'Teacher' FROM Student
INNER JOIN Math ON Math.StudentId = Student.id
INNER JOIN Staff ON Staff.id = Math.TeacherId
WHERE Student.id = @id
UNION
SELECT Student.id, Student.FirstName, Student.LastName, Student.Class, Student.SSN, 'English' AS Subject,
English.Grade, English.GradeSubmitted, CONCAT(Staff.FirstName, ' ',Staff.LastName) 
AS 'Teacher' FROM Student
INNER JOIN English ON English.StudentId = Student.id
INNER JOIN Staff ON Staff.id = English.TeacherId
WHERE Student.id = @id;


							/* 12 */
CREATE VIEW Teachers AS 
SELECT Staff.id, Staff.FirstName, Staff.LastName, Course.[Name] FROM Staff
INNER JOIN TeacherCourse ON TeacherCourse.TeacherId = Staff.id 
INNER JOIN Course ON Course.id = TeacherCourse.CourseId;

SELECT Teachers.id, Teachers.FirstName, Teachers.LastName, Teachers.[Name] 
FROM Teachers ORDER BY Teachers.[Name];
