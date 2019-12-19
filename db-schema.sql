USE master;
GO
DROP DATABASE IF EXISTS StudentDatabase;
GO
CREATE DATABASE StudentDatabase;
GO
USE StudentDatabase;
GO 

CREATE SCHEMA StudentDatabase;
GO

--CREATE TABLE
CREATE TABLE StudentDatabase.Students (
	StudentId int constraint PKconstrainrt Primary Key identity(1,1),
	FirstName varchar (50),
	LastName varchar (40),
	Address1 varchar (50),
	City varchar (50),
	Province varchar (50),
	Country varchar (80),
	PhoneNumber varchar(15),
	EmailAddress varchar (70),
	GraduationYear SMALLINT
);
ALTER TABLE StudentDatabase.Students
ADD PostCode varchar(50);
Go

CREATE TABLE StudentDatabase.COURSE
(
	CourseID INT CONSTRAINT PKCourseID PRIMARY KEY IDENTITY (1,1),
	CourseName varchar(30),
	CourseStart DATETIME,
	CourseEnd DATETIME
);

CREATE TABLE StudentDatabase.Student_Course
(
	Attendance DECIMAL(5,2),
	Project DECIMAL(5,2),
	Quiz DECIMAL(5,2),
	FinalExam DECIMAL(5,2),
	StudentID INT,
	CourseID INT,
	FOREIGN KEY (StudentID)REFERENCES  StudentDatabase.Students(StudentID),
	FOREIGN KEY (CourseID)REFERENCES  StudentDatabase.Course(CourseID)
);

CREATE TABLE StudentDatabase.Payment(
	PaymentID INT CONSTRAINT PKPaymentID PRIMARY KEY IDENTITY (1,1),
	AmountDue money,
	AmountPaid money,
	PaymentType varchar(300),
	PaymentDate DATETIME,
	StudentID int,
	FOREIGN KEY (StudentID)REFERENCES  StudentDatabase.Students(StudentID)
);

CREATE TABLE StudentDatabase.Scholarship(
	ScholarshipID INT CONSTRAINT PKScholarship PRIMARY KEY IDENTITY (1,1),
	Description1 Varchar(30),
	Amount money,
	StudentID int,
	FOREIGN KEY (StudentID)REFERENCES  StudentDatabase.Students(StudentID)
);
GO
--procedure for students

CREATE PROCEDURE StudentDatabase.StudentsInsert 
	@FirstName varchar (50),
	@LastName varchar (40),
	@Address1 varchar (50),
	@City varchar (50),
	@Province varchar (50),
	@Country varchar (80),
	@PhoneNumber varchar(15),
	@EmailAddress varchar (70),
	@GraduationYear SMALLINT,
	@PostCode varchar(50)
As 

INSERT INTO StudentDatabase.Students(FirstName, LastName, Address1, City, Province, Country, PhoneNumber, EmailAddress, GraduationYear, PostCode)
VALUES (@FirstName, @LastName, @Address1, @City, @Province, @Country, @PhoneNumber, @EmailAddress, @GraduationYear, @PostCode)
GO

CREATE PROCEDURE StudentDatabase.StudentsUpdate 
	@StudentId int,
	@FirstName varchar (50),
	@LastName varchar (40),
	@Address1 varchar (50),
	@City varchar (50),
	@Province varchar (50),
	@Country varchar (80),
	@PhoneNumber varchar(15),
	@EmailAddress varchar (70),
	@GraduationYear SMALLINT,
	@PostCode varchar(50)
AS
UPDATE StudentDatabase.Students
SET FirstName = @FirstName, LastName = @LastName, Address1 = @Address1, City = @City, Province = @Province, Country = @Country, PhoneNumber = @PhoneNumber, EmailAddress = @EmailAddress, GraduationYear = @GraduationYear, PostCode = @PostCode
WHERE StudentId = @StudentId
GO

CREATE PROCEDURE StudentDatabase.StudentsDelete @StudentId int
AS
DELETE FROM StudentDatabase.Students
WHERE StudentId = @StudentId;
GO

--create procedure for course

CREATE PROCEDURE StudentDatabase.COURSEInsert
	@CourseName varchar(30),
	@CourseStart DATETIME,
	@CourseEnd DATETIME
AS
INSERT INTO StudentDatabase.COURSE (CourseName, CourseStart, CourseEnd)
VALUES(@CourseName, @CourseStart, @CourseEnd)
GO
CREATE PROCEDURE StudentDatabase.COURSEUpdate
    @CourseID INT,
	@CourseName varchar(30),
	@CourseStart DATETIME,
	@CourseEnd DATETIME
AS
UPDATE StudentDatabase.COURSE 
SET CourseName = @CourseName, CourseStart = @CourseStart, CourseEnd = @CourseEnd
WHERE CourseID =@CourseID
GO
CREATE PROCEDURE StudentDatabase.COURSEDelete @CourseId int
AS
DELETE FROM  StudentDatabase.COURSE
WHERE CourseId = @CourseId;
GO


--CREATE INDEX

CREATE INDEX ix_Students_FirstName
ON StudentDatabase.Students(FirstName)
GO

CREATE INDEX ix_Course_CourseName
ON StudentDatabase.Course(CourseName)
GO

CREATE INDEX ix_Scholarship_ScholarshipID
ON StudentDatabase.Scholarship(ScholarshipID)
GO

--CREATE VIEW
CREATE VIEW  StudentDatabase.GraduationStudentList AS
	SELECT * FROM  StudentDatabase.Students
	WHERE GraduationYear = '2019';
GO
CREATE VIEW StudentDatabase.CourseStudentList AS
	SELECT * FROM  StudentDatabase.COURSE
	WHERE CourseID = '2019';

GO

CREATE VIEW StudentDatabase.CoursestartStudentList AS
	SELECT * FROM  StudentDatabase.COURSE
	WHERE CourseStart = '2019';

GO
 CREATE VIEW StudentDatabase.ScholarshipStudentList AS
	SELECT * FROM  StudentDatabase.Scholarship
	WHERE ScholarshipID = '2019';


GO 

--ADD CONSTRAINT DEFAULT

ALTER TABLE StudentDatabase.Course
ADD CONSTRAINT ConsCourseStart
DEFAULT GETDATE() for CourseStart

--ADD CONSTRAINT CHECK

ALTER TABLE StudentDatabase.Students
ADD CONSTRAINT CHK_PostCode CHECK (PostCode LIKE'[a-z][0-9][a-z][0-9][a-z][0-9]');
GO



