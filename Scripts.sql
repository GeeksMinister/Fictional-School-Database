USE [master]
GO
/****** Object:  Database [HappyValleyTestTwo]    Script Date: 2022-02-13 3:31:07 PM ******/
CREATE DATABASE [HappyValleyTestTwo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HappyValleyTestTwo', FILENAME = N'C:\Users\NAYEL\HappyValleyTestTwo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HappyValleyTestTwo_log', FILENAME = N'C:\Users\NAYEL\HappyValleyTestTwo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [HappyValleyTestTwo] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HappyValleyTestTwo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HappyValleyTestTwo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET ARITHABORT OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [HappyValleyTestTwo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HappyValleyTestTwo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HappyValleyTestTwo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HappyValleyTestTwo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HappyValleyTestTwo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HappyValleyTestTwo] SET  MULTI_USER 
GO
ALTER DATABASE [HappyValleyTestTwo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HappyValleyTestTwo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HappyValleyTestTwo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HappyValleyTestTwo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HappyValleyTestTwo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HappyValleyTestTwo] SET QUERY_STORE = OFF
GO
USE [HappyValleyTestTwo]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [HappyValleyTestTwo]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeacherCourse]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeacherCourse](
	[TeacherId] [int] NOT NULL,
	[CourseId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Position] [varchar](50) NOT NULL,
	[EmploymentDate] [varchar](50) NOT NULL,
	[SSN] [char](10) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](320) NULL,
	[Salary] [int] NOT NULL,
 CONSTRAINT [PK__Staff__3213E83FFADAB7BA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Teachers]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Teachers] AS 
SELECT Staff.id, Staff.FirstName, Staff.LastName, Course.[Name] FROM Staff
INNER JOIN TeacherCourse ON TeacherCourse.TeacherId = Staff.id 
INNER JOIN Course ON Course.id = TeacherCourse.CourseId;
GO
/****** Object:  Table [dbo].[Student]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[SSN] [char](10) NOT NULL,
	[Class] [varchar](50) NULL,
	[Email] [varchar](320) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Programming]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Programming](
	[StudentId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[TeacherId] [int] NULL,
	[Grade] [char](2) NULL,
	[GradeSubmitted] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[English]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[English](
	[StudentId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[TeacherId] [int] NULL,
	[Grade] [char](2) NULL,
	[GradeSubmitted] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Math]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Math](
	[StudentId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[TeacherId] [int] NULL,
	[Grade] [char](2) NULL,
	[GradeSubmitted] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Recent Grades]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Recent Grades] AS 
SELECT Math.StudentId, CONCAT(Student.FirstName,' ' ,Student.LastName) AS 'Student',
Math.Grade, 'Math' AS [Subject], Math.GradeSubmitted AS 'Date',
CONCAT(Staff.FirstName,' ' ,Staff.LastName) AS 'Teacher'
FROM Student, Math, Staff 
WHERE DATEDIFF(MONTH, [Date], GETDATE()) <= 1 AND Grade IS NOT NULL
AND Staff.id = TeacherId AND Math.StudentId = Student.id
UNION
SELECT English.StudentId, CONCAT(Student.FirstName,' ' ,Student.LastName) AS 'Student',
English.Grade, 'English' AS [Subject], English.GradeSubmitted AS 'Date',
CONCAT(Staff.FirstName,' ' ,Staff.LastName) AS 'Teacher'
FROM Student, English, Staff 
WHERE DATEDIFF(MONTH, [Date], GETDATE()) <= 1 AND Grade IS NOT NULL
AND Staff.id = TeacherId AND English.StudentId = Student.id
UNION
SELECT Programming.StudentId, CONCAT(Student.FirstName,' ' ,Student.LastName) AS 'Student',
Programming.Grade, 'Programming' AS [Subject], Programming.GradeSubmitted AS 'Date',
CONCAT(Staff.FirstName,' ' ,Staff.LastName) AS 'Teacher'
FROM Student, Programming, Staff 
WHERE DATEDIFF(MONTH, [Date], GETDATE()) <= 1 AND Grade IS NOT NULL
AND Staff.id = TeacherId AND Programming.StudentId = Student.id;
GO
/****** Object:  View [dbo].[Grades]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Grades] AS 
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
GO
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([id], [Name]) VALUES (1, N'Programming')
INSERT [dbo].[Course] ([id], [Name]) VALUES (2, N'English')
INSERT [dbo].[Course] ([id], [Name]) VALUES (3, N'Math')
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (9, CAST(N'2020-03-06' AS Date), 10, N'A ', CAST(N'2020-04-06' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (10, CAST(N'2020-03-06' AS Date), 10, N'B ', CAST(N'2020-04-06' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (11, CAST(N'2020-03-06' AS Date), 10, N'F ', CAST(N'2020-04-06' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (12, CAST(N'2021-10-06' AS Date), 10, N'B ', CAST(N'2021-11-06' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (13, CAST(N'2020-03-06' AS Date), 10, N'A ', CAST(N'2020-04-06' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (5, CAST(N'2020-09-06' AS Date), 10, N'C ', CAST(N'2020-10-06' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (6, CAST(N'2020-09-06' AS Date), 10, N'B ', CAST(N'2020-10-06' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (7, CAST(N'2020-09-06' AS Date), 10, N'C ', CAST(N'2020-10-06' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (8, CAST(N'2020-09-06' AS Date), 10, N'A ', CAST(N'2020-10-06' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (1, CAST(N'2022-01-08' AS Date), 10, N'A ', CAST(N'2022-01-28' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (2, CAST(N'2022-01-08' AS Date), 10, N'B ', CAST(N'2022-01-28' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (3, CAST(N'2022-01-08' AS Date), 10, N'C ', CAST(N'2022-01-28' AS Date))
INSERT [dbo].[English] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (4, CAST(N'2022-01-08' AS Date), 10, N'A ', CAST(N'2022-01-28' AS Date))
GO
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (1, CAST(N'2021-09-06' AS Date), 2, N'B ', CAST(N'2021-10-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (2, CAST(N'2021-09-06' AS Date), 2, N'D ', CAST(N'2021-10-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (3, CAST(N'2021-09-06' AS Date), 2, N'C ', CAST(N'2021-09-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (4, CAST(N'2021-09-06' AS Date), 2, N'A ', CAST(N'2021-09-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (5, CAST(N'2020-09-06' AS Date), 2, N'B ', CAST(N'2020-10-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (6, CAST(N'2020-09-06' AS Date), 2, N'A ', CAST(N'2020-10-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (7, CAST(N'2020-09-06' AS Date), 2, N'D ', CAST(N'2020-10-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (8, CAST(N'2020-09-06' AS Date), 2, N'E ', CAST(N'2020-10-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (9, CAST(N'2020-03-08' AS Date), 2, N'C ', CAST(N'2020-04-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (10, CAST(N'2020-03-08' AS Date), 2, N'B ', CAST(N'2020-04-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (11, CAST(N'2020-03-08' AS Date), 2, N'D ', CAST(N'2020-04-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (12, CAST(N'2020-03-08' AS Date), 2, N'B ', CAST(N'2020-04-06' AS Date))
INSERT [dbo].[Math] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (13, CAST(N'2020-03-08' AS Date), 2, N'A ', CAST(N'2020-04-06' AS Date))
GO
INSERT [dbo].[Programming] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (9, CAST(N'2022-01-08' AS Date), 7, N'B ', CAST(N'2022-01-28' AS Date))
INSERT [dbo].[Programming] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (10, CAST(N'2022-01-08' AS Date), 8, N'C ', CAST(N'2022-01-28' AS Date))
INSERT [dbo].[Programming] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (11, CAST(N'2022-01-08' AS Date), 9, N'B ', CAST(N'2022-01-28' AS Date))
INSERT [dbo].[Programming] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (12, CAST(N'2021-09-06' AS Date), 8, N'A ', CAST(N'2021-10-06' AS Date))
INSERT [dbo].[Programming] ([StudentId], [Date], [TeacherId], [Grade], [GradeSubmitted]) VALUES (13, CAST(N'2021-09-06' AS Date), 7, N'B ', CAST(N'2021-10-06' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (1, N'Justin', N'Adams', N'Principal', N'2016-09-12', N'1980000011', N'+46 70 000 00 01', N'justin.adams@happyvalley.com', 48000)
INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (2, N'Maria', N'Brandi', N'Teacher', N'2018-01-12', N'1976000002', N'+46 70 000 00 02', N'maria.brandi@happyvalley.com', 34000)
INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (3, N'Amy', N'Robertson', N'Vice Principal', N'2014-01-12', N'1989000003', N'+46 70 000 00 03', N'amy.robertson@happyvalley.com', 38500)
INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (4, N'Nael', N'Sharabi', N'Webmaster', N'2022-01-05', N'1993000014', N'+46 70 000 00 04', N'nael.sharabi@happyvalley.com', 39000)
INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (5, N'Ralph', N'Blalock', N'Handyman', N'2019-04-10', N'1992000015', N'+46 70 000 00 05', N'ralph.blalock@happyvalley.com', 33000)
INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (6, N'Gerald', N'Barefoot', N'Janitor', N'2015-03-12', N'1983000016', N'+46 70 000 00 06', N'gerald.barefoot@happyvalley.com', 29000)
INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (7, N'Tobias', N'Landeen', N'Teacher', N'2021-09-06', N'1986000017', N'+46 70 000 00 07', N'tobias.landeen@happyvalley.com', 38000)
INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (8, N'Anas', N'Alhussain', N'Teacher', N'2021-09-06', N'1991000018', N'+46 70 000 00 08', N'anas.alhussain@happyvalley.com', 38000)
INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (9, N'Reidar', N'Nilsen', N'Teacher', N'2022-01-03', N'1972000019', N'+46 70 000 00 09', N'reidar.nilsen@happyvalley.com', 35000)
INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (10, N'Gillian', N'Brown', N'Teacher', N'2019-10-04', N'1998000009', N'+46 70 000 00 10', N'gillian.brown@happyvalley.com', 34000)
INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (13, N'Chris', N'Hansen', N'Teacher', N'2015-02-14', N'1979000019', N'+46 70 000 00 11', N'chris.hansen@happyvalley.com', 36000)
INSERT [dbo].[Staff] ([id], [FirstName], [LastName], [Position], [EmploymentDate], [SSN], [Phone], [Email], [Salary]) VALUES (14, N'Nora', N'Fateh', N'Teacher', N'2020-04-20', N'1990000043', N'+46 70 000 00 33', N'nora.fateh@happyvalley.com', 29000)
SET IDENTITY_INSERT [dbo].[Staff] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (1, N'Adele', N'Müller', N'2007000001', N'Sophomore year', N'adele.muller@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (2, N'Alfred', N'Kaiser', N'2007000412', N'Sophomore year', N'alfred.kaiser@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (3, N'Martin', N'Wilson', N'2007000113', N'Sophomore year', N'martin.wilson@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (4, N'Alice', N'Jackson', N'2007000004', N'Sophomore year', N'alice.jackson@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (5, N'Madeline', N'Storm', N'2006000005', N'Junior year', N'madeline.storm@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (6, N'Emma', N'Lewis', N'2006000006', N'Junior year', N'emma.Lewis@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (7, N'Jonas', N'Robinson', N'2006000037', N'Junior year', N'jonas.robinson@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (8, N'David', N'Nelson', N'2006000038', N'Junior year', N'david.nelson@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (9, N'Johanna', N'Baker', N'2005000009', N'Senior year', N'johanna.baker@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (10, N'Amanda', N'Carter', N'2005000180', N'Senior year', N'amanda.carter@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (11, N'Mike', N'Osback', N'2005000011', N'Senior year', N'mike.phillips@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (12, N'Alex', N'Parker', N'2004000032', N'Senior year', N'alex.parker@happyvalley.com')
INSERT [dbo].[Student] ([id], [FirstName], [LastName], [SSN], [Class], [Email]) VALUES (13, N'Caroline', N'Smith', N'2006000040', N'Senior year', N'caroline.smith@happyvalley.com')
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
INSERT [dbo].[TeacherCourse] ([TeacherId], [CourseId]) VALUES (7, 1)
INSERT [dbo].[TeacherCourse] ([TeacherId], [CourseId]) VALUES (8, 1)
INSERT [dbo].[TeacherCourse] ([TeacherId], [CourseId]) VALUES (9, 1)
INSERT [dbo].[TeacherCourse] ([TeacherId], [CourseId]) VALUES (10, 2)
INSERT [dbo].[TeacherCourse] ([TeacherId], [CourseId]) VALUES (2, 3)
INSERT [dbo].[TeacherCourse] ([TeacherId], [CourseId]) VALUES (14, 3)
INSERT [dbo].[TeacherCourse] ([TeacherId], [CourseId]) VALUES (13, 2)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Staff__5C7E359EF86D3A3B]    Script Date: 2022-02-13 3:31:07 PM ******/
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [UQ__Staff__5C7E359EF86D3A3B] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Staff__A9D10534C58AF8E9]    Script Date: 2022-02-13 3:31:07 PM ******/
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [UQ__Staff__A9D10534C58AF8E9] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Staff__CA1E8E3C28F421E2]    Script Date: 2022-02-13 3:31:07 PM ******/
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [UQ__Staff__CA1E8E3C28F421E2] UNIQUE NONCLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Student__A9D10534D411B6C8]    Script Date: 2022-02-13 3:31:07 PM ******/
ALTER TABLE [dbo].[Student] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Student__CA1E8E3CF468F203]    Script Date: 2022-02-13 3:31:07 PM ******/
ALTER TABLE [dbo].[Student] ADD UNIQUE NONCLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TeacherCourse]  WITH CHECK ADD FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([id])
GO
ALTER TABLE [dbo].[TeacherCourse]  WITH CHECK ADD  CONSTRAINT [FK__TeacherCo__Teach__3C69FB99] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Staff] ([id])
GO
ALTER TABLE [dbo].[TeacherCourse] CHECK CONSTRAINT [FK__TeacherCo__Teach__3C69FB99]
GO
/****** Object:  StoredProcedure [dbo].[spProgramming_SetGrade]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spProgramming_SetGrade]
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
	PRINT('En error was occurred')
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[spStudent_GetInfo]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spStudent_GetInfo]
@i INT 
AS SELECT Student.id, Student.FirstName, Student.LastName, Student.SSN
, Student.Class, Student.Email, English.Grade AS 'English', Math.Grade AS 'Math',
ISNULL(Programming.Grade, '') AS 'Programming' FROM Student
LEFT JOIN English ON English.StudentId = Student.id 
LEFT JOIN Math ON Math.StudentId = Student.id 
LEFT JOIN Programming ON (Programming.StudentId = Student.id AND Programming.Grade IS NOT NULL)
WHERE Student.id = @i
GO
/****** Object:  StoredProcedure [dbo].[spStudentTeacher_Getinfo]    Script Date: 2022-02-13 3:31:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spStudentTeacher_Getinfo]
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
GO
USE [master]
GO
ALTER DATABASE [HappyValleyTestTwo] SET  READ_WRITE 
GO
