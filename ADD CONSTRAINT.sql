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

--ADD CONSTRAINT DEFAULT

ALTER TABLE StudentDatabase.Course
ADD CONSTRAINT ConsCourseStart
DEFAULT GETDATE() for CourseStart

--ADD CONSTRAINT CHECK

ALTER TABLE StudentDatabase.Students
ADD CONSTRAINT CHK_PostCode CHECK (PostCode LIKE'[a-z][0-9][a-z][0-9][a-z][0-9]');
GO

