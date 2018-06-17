/*	Problem 1.	Create Database */
 
CREATE DATABASE Minions


/* Problem 2.	Create Tables */

USE Minions
GO

CREATE TABLE Minions
(
Id INT NOT NULL,
Name VARCHAR(50) NOT NULL,
Age INT
)

CREATE TABLE Towns
(
Id INT NOT NULL,
Name VARCHAR(50) NOT NULL
)

/* Set Id columns of both tables to be primary key as constraint. */
ALTER TABLE Minions
ADD CONSTRAINT pk_Id_Minions PRIMARY KEY (Id)

ALTER TABLE Towns
ADD CONSTRAINT pk_Id_Towns PRIMARY KEY (Id)


/*	Problem 3.	Alter Minions Table */

/* Add new column TownId */
ALTER TABLE Minions
ADD TownId INT 

/*  Add new constraint that makes TownId foreign key and references to Id column of Towns table. */
ALTER TABLE Minions
ADD CONSTRAINT fk_Minions_Towns FOREIGN KEY (TownId)
REFERENCES Towns (Id)


/*	Problem 4.	Insert Records in Both Tables */

INSERT INTO Towns(Id, Name) VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');
  
INSERT INTO Minions(Id, Name, Age, TownId) VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)


/*	Problem 5.	Truncate Table Minions */

/* Delete all the data from the Minions table using SQL query.*/
TRUNCATE TABLE Minions


/*	Problem 6.	Drop All Tables - Delete all tables from the Minions database using SQL query. */
DROP TABLE Minions
DROP TABLE Towns


/* 	Problem 7.	Create Table People
•	Id – unique number for every person there will be no more than 231-1 people. (Auto incremented)
•	Name – full name of the person will be no more than 200 Unicode characters. (Not null)
•	Picture – image with size up to 2 MB. (Allow nulls)
•	Height –  In meters. Real number precise up to 2 digits after floating point. (Allow nulls)
•	Weight –  In kilograms. Real number precise up to 2 digits after floating point. (Allow nulls)
•	Gender – Possible states are m or f. (Not null)
•	Birthdate – (Not null)
•	Biography – detailed biography of the person it can contain max allowed Unicode characters. (Allow nulls)
*/
CREATE TABLE People
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(200) NOT NULL,
	Picture VARBINARY(max),
	Height FLOAT(2),
	Weight FLOAT(2),
	Gender NCHAR(1) NOT NULL CHECK (Gender IN('f', 'm')),
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(max)
)
/*  Populate the table with 5 records. */
INSERT INTO People (Name, Picture, Height, Weight, Gender, Birthdate, Biography)
VALUES
('John', NULL, 170.5, 75.5, 'm', '1982-01-02', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ...'),
('Ben', NULL, 185.5, 92.5, 'm', '1962-03-05', '... sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
('Ivan', NULL, 180, 85.5, 'm', '1977-01-09', '... Ut enim ad minim veniam, quis nostrud exercitation ullamco ...'),
('Maria', NULL, 165, 55.5, 'f', '1982-11-10', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ...'),
('Eva', NULL, 160, 65.5, 'm', '1985-12-02', '... laboris nisi ut aliquip ex ea commodo consequat...')


/* Problem 8.	Create Table Users
Using SQL query create table Users with columns:
•	Id – unique number for every user. There will be no more than 263-1 users. (Auto incremented)
•	Username – unique identifier of the user will be no more than 30 characters (non Unicode). (Required)
•	Password – password will be no longer than 26 characters (non Unicode). (Required)
•	ProfilePicture – image with size up to 900 KB. 
•	LastLoginTime
•	IsDeleted – shows if the user deleted his/her profile. Possible states are true or false.
Make Id primary key. Populate the table with 5 records. Submit your CREATE and INSERT statements as Run queries & check DB.
*/
 CREATE TABLE Users
(
	Id BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Username VARCHAR(30) UNIQUE,
	Password VARCHAR(26),
	ProfilePicture VARBINARY(max),
	LastLoginTime DATE,
	IsDeleted BIT
)
/* Populate the table with 5 records. */
INSERT INTO Users (Username, Password, ProfilePicture, LastLoginTime, IsDeleted)
VALUES
('John', '123bc', 170, '1982-01-02', 'true'),
('Ben', '21331vb', 185, '1962-03-05', 'true'),
('Ivan', 'vbvc', 180, '1977-01-09', 'true'),
('Maria', 'NUbcbvcLL', 165, '1982-11-10', 'true'),
('Eva', 'cbvb2254', 160, '1985-12-02', 'false')


/*	Problem 9.	Change Primary Key
Remove current primary key */
ALTER TABLE Users 
DROP CONSTRAINT PK__Users__3214EC0780FAAA40

/* create new primary key that would be combination of fields Id and Username */
ALTER TABLE Users 
ALTER COLUMN Username varchar(30) NOT NULL

ALTER TABLE Users 
ADD PRIMARY KEY (Id, Username);


/*	Problem 10.	Add Check Constraint
Using SQL queries modify table Users. Add check constraint to ensure that the values in the Password field are at least 5 symbols long. 
*/

ALTER TABLE Users 
ALTER COLUMN Password varchar(26) NOT NULL

ALTER TABLE Users
ADD CONSTRAINT MinLengthConstraint CHECK (DATALENGTH(Password) >= 5)

ADD CONSTRAINT CK_PasswordMinLength CHECK ( LEN([Password]) >= 5 )


/*	Problem 11.	Set Default Value of a Field
Using SQL queries modify table Users. Make the default value of LastLoginTime field to be the current time. */
ALTER TABLE Users
ADD CONSTRAINT DF_data DEFAULT GETDATE() FOR LastLoginTime

/* Problem 12.	Set Unique Field
Remove Username field from the primary key so only the field Id would be primary key. */
ALTER TABLE Users 
DROP CONSTRAINT PK__Users__77222459786AFEA7;

ALTER TABLE Users 
ADD CONSTRAINT PK_Id_Users PRIMARY KEY (Id)

/* Add unique constraint to the Username field to ensure that the values there are at least 3 symbols long. */
ALTER TABLE Users
ALTER COLUMN Username VARCHAR(30) NOT NULL CHECK (DATALENGTH(Password) >= 5) UNIQUE 


/*	Problem 13.	Movies Database
Using SQL queries create Movies database ... */
CREATE DATABASE Movies
GO

USE Movies
GO

/*with the following entities:
•	Directors (Id, DirectorName, Notes)*/
CREATE TABLE Directors
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	DirectorName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO Directors (DirectorName, Notes)
VALUES
('John', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ...'),
('Ben', NULL),
('Ivan', '... Ut enim ad minim veniam, quis nostrud exercitation ullamco ...'),
('Maria', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ...'),
('Eva', '... laboris nisi ut aliquip ex ea commodo consequat...')
 
/*•	Genres (Id, GenreName, Notes) */
CREATE TABLE Genres
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	GenreName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO Genres (GenreName, Notes)
VALUES
('Action', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ...'),
('Comedy', NULL),
('Thriller', NULL),
('Comedy', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ...'),
('Comedy', '... laboris nisi ut aliquip ex ea commodo consequat...')

/*•	Categories (Id, CategoryName, Notes) */
CREATE TABLE Categories
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	CategoryName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO Categories (CategoryName, Notes)
VALUES
('Action', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ...'),
('Comedy', NULL),
('Thriller', NULL),
('Comedy', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ...'),
('Comedy', '... laboris nisi ut aliquip ex ea commodo consequat...')

/*•	Movies (Id, Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes) */
CREATE TABLE Movies
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Title NVARCHAR(200) NOT NULL,
	DirectorId INT NOT NULL,
	CopyrightYear NVARCHAR(4) NOT NULL,
	Length INT NOT NULL,
	GenreId INT NOT NULL,
	CategoryId INT NOT NULL,
	Rating INT NOT NULL,	
	Notes NVARCHAR(max)
)

INSERT INTO Movies (Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
VALUES
('John', 5, 1995, 170, 1, 2, 9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ...'),
('Ben', 4, 2012, 185, 5, 3, 8, '... sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
('Ivan', 3, 1980, 180, 3, 4, 5, '... Ut enim ad minim veniam, quis nostrud exercitation ullamco ...'),
('Maria', 2, 1950, 165, 2, 5, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit ...'),
('Eva', 1, 1990, 160, 4, 1, 1, NULL)


/*	Problem 14.	Car Rental Database
Create CarRental database with the following entities: */
CREATE DATABASE CarRental
GO

USE CarRental
GO

/*•	Categories (Id, Category, DailyRate, WeeklyRate, MonthlyRate, WeekendRate) */
CREATE TABLE Categories
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Category NVARCHAR(200) NOT NULL,
	DailyRate INT NOT NULL,
	WeeklyRate INT NOT NULL,
	MonthlyRate INT NOT NULL,
	WeekendRate INT NOT NULL
)

INSERT INTO Categories (Category, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES
('John', 5, 2, 170, 1),
('Ben', 4, 2, 185, 5),
('Ivan', 3, 1, 180, 3)

/*•	Cars (Id, PlateNumber, Make, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)*/
CREATE TABLE Cars
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	PlateNumber NVARCHAR(50) NOT NULL,
	Make INT NOT NULL,
	Model NVARCHAR(50) NOT NULL,
	CarYear INT NOT NULL,
	CategoryId INT NOT NULL,
	Doors INT NOT NULL,
	Picture VARBINARY(max),
	Condition NVARCHAR(50) NOT NULL,
	Available NVARCHAR(10) NOT NULL
)

INSERT INTO Cars (PlateNumber, Make, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
VALUES
('C2555HM', 1999, 'Ford', 1900, 1, 5, 155, 'Yes', 'Yes'),
('CA1234BT', 2016, 'Opel', 2016, 1, 5, 160, 'Yes', 'Yes'),
('CB6598HM', 2001, 'VW', 2010, 1, 4, 140, 'No', 'Yes')

/*•	Employees (Id, FirstName, LastName, Title, Notes) */
CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,	
	Title NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES
('Jony', 'Ford', 'bos', 'Big boss'),
('Moni', 'Popova', 'chef', 'Big shef'),
('Ivan', 'Ivanob', 'operator', NULL)

/*• Customers (Id, DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes) */
CREATE TABLE Customers
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,	
	DriverLicenceNumber INT NOT NULL,
	FullName NVARCHAR(50) NOT NULL,
	Address NVARCHAR(50) NOT NULL,
	City NVARCHAR(50) NOT NULL,
	ZIPCode NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO Customers (DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
VALUES
(123, 'Misho Fogata', 'Ul. Nezabravka 1', 'Vratsa', 'PL11', NULL),
(124, 'Ivo Mishev', 'bl.2', 'Popovo', 'PL11', NULL),
(125, 'Mima Fileva', 'Ul. 101', 'Sofia', '35R11', NULL)

/*•	RentalOrders (Id, EmployeeId, CustomerId, CarId, CarCondition, TankLevel, 
KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes) */
CREATE TABLE RentalOrders
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,	
	EmployeeId INT NOT NULL,
	CustomerId INT NOT NULL,
	CarId INT NOT NULL,
	CarCondition NVARCHAR(50) NOT NULL,
	TankLevel INT NOT NULL,
	KilometrageStart INT NOT NULL,
	KilometrageEnd INT NOT NULL,
	TotalKilometrage INT NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	TotalDays INT NOT NULL,		
	RateApplied INT NOT NULL,
	TaxRate INT NOT NULL,
	OrderStatus INT NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, CarCondition, TankLevel, 
KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
VALUES
(23, 22, 32, 'Yes', 50, 25000, 25500, 500, '2015-01-02', '2015-01-03', 12, 13, 1, 5, NULL),
(24, 2, 3, 'Yes', 50, 125000, 125500, 500, '2016-01-02', '2016-01-09', 12, 2, 1, 6, NULL),
(25, 222, 321, 'Yes', 60, 2000, 5500, 3500, '2015-10-02', '2015-10-03', 12, 13, 1, 7, NULL)


/*	Problem 15.	Hotel Database
Using SQL queries create Hotel database with the following entities: */
CREATE DATABASE Hotel
GO

USE Hotel
GO

/*•	Employees (Id, FirstName, LastName, Title, Notes) */
CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,	
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES
('Misho', 'Fogata', 'shef', NULL),
('Ivo', 'Mishev', 'boss', NULL),
('Mima', 'Fileva', 'operator', NULL)

/*•	Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)*/
CREATE TABLE Customers
(
	AccountNumber INT PRIMARY KEY IDENTITY(1,1) NOT NULL,	
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(50) NOT NULL,
	EmergencyName NVARCHAR(50) NOT NULL,
	EmergencyNumber INT NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO Customers (FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
VALUES
('Misho', 'Fogata', '08888888', 'Pirogov', 1, NULL),
('Ivo', 'Mishev', '088888', 'Treta', 2, NULL),
('Mima', 'Fileva', '0888', 'Okr', 3, NULL)

/*• RoomStatus (RoomStatus, Notes) */
CREATE TABLE RoomStatus
(
	RoomStatus INT PRIMARY KEY IDENTITY(1,1) NOT NULL,	
	Notes NVARCHAR(max)
)

INSERT INTO RoomStatus (Notes)
VALUES
(NULL),
(NULL),
(NULL)


/*•	RoomTypes (RoomType, Notes)*/
CREATE TABLE RoomTypes
(
	RoomType INT PRIMARY KEY IDENTITY(1,1) NOT NULL,	
	Notes NVARCHAR(max)
)

INSERT INTO RoomTypes (Notes)
VALUES
(NULL),
(NULL),
(NULL)

/*•	BedTypes (BedType, Notes) */
CREATE TABLE BedTypes
(
	BedType INT PRIMARY KEY IDENTITY(1,1) NOT NULL,	
	Notes NVARCHAR(max)
)

INSERT INTO BedTypes (Notes)
VALUES
(NULL),
(NULL),
(NULL)

/*• Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes) */
CREATE TABLE Rooms
(
	RoomNumber INT PRIMARY KEY IDENTITY(1,1) NOT NULL,	
	RoomType NVARCHAR(50) NOT NULL,
	BedType NVARCHAR(50) NOT NULL,
	Rate INT NOT NULL,
	RoomStatus NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO Rooms (RoomType, BedType, Rate, RoomStatus, Notes)
VALUES
('single', 'single', 1, 'free', NULL),
('double', 'double', 2, 'free', NULL),
('double', 'double', 3, 'free', NULL)

/*•	Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied,
TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes) */
CREATE TABLE Payments
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,	
	EmployeeId INT NOT NULL,
	PaymentDate DATE NOT NULL,	
	AccountNumber INT NOT NULL,	
	FirstDateOccupied DATE NOT NULL,
	LastDateOccupied DATE NOT NULL,
	TotalDays INT NOT NULL,		
	AmountCharged FLOAT(2) NOT NULL,
	TaxRate FLOAT(2) NOT NULL,
	TaxAmount FLOAT(2) NOT NULL,
	PaymentTotal FLOAT(2) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied,
TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
VALUES
(23, '2015-01-02', 4, '2015-01-02', '2015-01-03', 1, 100, 5, 5, 105, NULL),
(24, '2015-01-02', 4, '2016-01-02', '2016-01-04', 2, 200, 5, 10, 210, NULL),
(25, '2015-01-02', 4, '2014-01-02', '2014-01-03', 1, 1000, 5, 50, 1050, NULL)

/* •	Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)*/
CREATE TABLE Occupancies
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,	
	EmployeeId INT NOT NULL,
	DateOccupied DATE NOT NULL,	
	AccountNumber INT NOT NULL,	
	RoomNumber INT NOT NULL,
	RateApplied INT NOT NULL,
	PhoneCharge FLOAT(2) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
VALUES
(23, '2015-01-02', 4, 1, 100, 5.5, NULL),
(24, '2015-01-02', 2, 2, 200, 2.10, NULL),
(25, '2015-01-02', 1, 3, 1000, 10.50, NULL)

/* Problem 16.	Create SoftUni Database
Now create bigger database called SoftUni. You will use database in the future tasks. It should hold information about */
CREATE DATABASE SoftUni 
GO

USE SoftUni 
GO

/* Create tables:*/
/*  • Towns (Id, Name) */
CREATE TABLE Towns
(
	Id INT  IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(50) NOT NULL
)

/*  • Addresses (Id, AddressText, TownId) */
CREATE TABLE Addresses
(
	Id INT  IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	TownId INT  NOT NULL
)

/*  • Departments (Id, Name) */
CREATE TABLE Departments 
(
	Id INT  IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(50) NOT NULL
)

/*  • Employees (Id, FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId) */
CREATE TABLE Employees 
(
	Id INT  IDENTITY(1,1) NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(50) NOT NULL,
	DepartmentId INT NOT NULL,
	HireDate DATE NOT NULL,
	Salary FLOAT(2) NOT NULL,
	AddressId INT NULL
)

/*  Add primary and foreign keys as constraints for each table. */
ALTER TABLE Towns
ADD CONSTRAINT PK_Id_Towns PRIMARY KEY (Id)

ALTER TABLE Addresses
ADD CONSTRAINT PK_Id_Addresses PRIMARY KEY (Id)

ALTER TABLE Departments
ADD CONSTRAINT PK_Id_Departments PRIMARY KEY (Id)

ALTER TABLE Employees
ADD CONSTRAINT PK_Id_Employees PRIMARY KEY (Id)

ALTER TABLE Addresses
ADD CONSTRAINT FK_Addresses_Towns FOREIGN KEY (TownId)
REFERENCES Towns (Id)

ALTER TABLE Employees
ADD CONSTRAINT fk_Employees_Department FOREIGN KEY (DepartmentId)
REFERENCES Departments (Id)

ALTER TABLE Employees
ADD CONSTRAINT fk_Employees_Address FOREIGN KEY (AddressId)
REFERENCES Addresses (Id)


/* 	Problem 17.	Backup Database
Backup the database SoftUni from the previous tasks into a file named “softuni-backup.bak”. */
BACKUP DATABASE SoftUni 
TO DISK = 'C:\ICO\SoftUni\Databases-Basics\02.Data-Definition-And-Datatypes\softuni-backup.bak'
GO

/* Delete your database from SQL Server Management Studio. */
USE master;  
GO  
DROP DATABASE SoftUni;
GO 

/* Restore the database from the created backup.*/
RESTORE DATABASE SoftUni
FROM DISK = 'C:\ICO\SoftUni\Databases-Basics\02.Data-Definition-And-Datatypes\softuni-backup.bak'
GO

USE SoftUni
GO

/* 	Problem 18.	Basic Insert 
• Towns: Sofia, Plovdiv, Varna, Burgas*/
INSERT INTO Towns (Name)
VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

/*• Departments: Engineering, Sales, Marketing, Software Development, Quality Assurance */
INSERT INTO Departments (Name)
VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

/*•	Employees: 
NOT NULL to NULL:
ALTER TABLE Employees
ALTER COLUMN AddressId INT NULL */
INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88)


/* 	Problem 19.	Basic Select All Fields
Use the SoftUni database and first select all records from the Towns, then from Departments and finally from Employees table. */
SELECT *
  FROM Towns
  
SELECT *
  FROM Departments
  
SELECT *
  FROM Employees
  
  
/*	Problem 20.	Basic Select All Fields and Order Them
Modify queries from previous problem by sorting:
•	Towns - alphabetically by name
•	Departments - alphabetically by name
•	Employees - descending by salary
Submit your query statements as Prepare DB & Run queries.  */
SELECT *
  FROM Towns
 ORDER BY Name
  
SELECT *
  FROM Departments
 ORDER BY Name
  
SELECT *
  FROM Employees
 ORDER BY Salary DESC
 
/*	Problem 21.	Basic Select Some Fields
Modify queries from previous problem to show only some of the columns. For table:
•	Towns – Name
•	Departments – Name
•	Employees – FirstName, LastName, JobTitle, Salary */
SELECT Name
  FROM Towns
 ORDER BY Name
  
SELECT Name
  FROM Departments
 ORDER BY Name
  
SELECT FirstName, LastName, JobTitle, Salary
  FROM Employees
 ORDER BY Salary DESC


/*	Problem 22.	Increase Employees Salary
Use SoftUni database and increase the salary of all employees by 10%. Select only Salary column from the Employees table */
UPDATE Employees
SET Salary += Salary * 0.1

SELECT Salary
  FROM Employees
  
  
/*	Problem 23.	Decrease Tax Rate
Use Hotel database and decrease tax rate by 3% to all payments. Select only TaxRate column from the Payments table. */
UPDATE Payments
SET TaxRate -= TaxRate * 0.03

SELECT TaxRate
  FROM Payments


/*	Problem 24.	Delete All Records
Use Hotel database and delete all records from the Occupancies table.  */
TRUNCATE TABLE Occupancies

