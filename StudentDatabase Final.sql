CREATE DATABASE StudentDatabase;
GO
CREATE SCHEMA StudentDatabase;
GO

CREATE TABLE StudentDatabase.Payment(
	PaymentID INT CONSTRAINT PKPaymentID PRIMARY KEY IDENTITY (1,1),
	StudentID int, FK
	AmountDue money,
	AmountPaid money,
	PaymentType varchar(300),
	PaymentDate DATETIME
);

CREATE TABLE StudentDatabase.Scholarship(
	ScholarshipID INT CONSTRAINT PKScholarship PRIMARY KEY IDENTITY (1,1),
	StudentID int, FK
	Description1 Varchar(30),
	Amount money,
);
