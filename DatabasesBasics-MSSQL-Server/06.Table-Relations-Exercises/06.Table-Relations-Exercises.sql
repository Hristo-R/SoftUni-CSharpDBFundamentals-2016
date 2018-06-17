-- Problem 1.	One-To-One Relationship
-- Create two tables as follows. Use appropriate data types.
-- Alter table customers and make PersonID a primary key. 
-- Create a foreign key between Persons and Passports by using PassportID column.

CREATE TABLE Persons
(
PersonID INT NOT NULL,
FirstName VARCHAR(50),
Salary DECIMAL(10, 2),
PassportID INT
)

INSERT INTO Persons (PersonID, FirstName, Salary, PassportID)
VALUES
(1, 'Roberto', 43300.00, 102),
(2, 'Tom', 56100.00, 103),
(3, 'Yana', 60200.00, 101)

CREATE TABLE Passports
(
PassportID INT NOT NULL,
PassportNumber VARCHAR(50)
)

INSERT INTO Passports (PassportID, PassportNumber)
VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2')

ALTER TABLE Persons
ADD CONSTRAINT PK_Person_ID PRIMARY KEY (PersonID)

ALTER TABLE Passports 
ADD CONSTRAINT PK_PassportID PRIMARY KEY (PassportID)

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_Passports FOREIGN KEY (PassportID)
REFERENCES Passports (PassportID)


-- Problem 2.	One-To-Many Relationship
-- Create two tables as follows. Use appropriate data types.
-- Insert the data from the example above. Add primary keys and foreign keys.

CREATE TABLE Manufacturers
(
ManufacturerID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
EstablishedOn DATE NOT NULL
)
 
INSERT INTO Manufacturers (ManufacturerID, Name, EstablishedOn)
VALUES (1, 'BMW', '1916-03-07'),
       (2, 'Tesla', '2003-01-01'),
       (3, 'Lada', '1966-05-01')
 
CREATE TABLE Models
(
ModelID INT PRiMARY KEY,
Name VARCHAR(50) NOT NULL,
ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)
 
INSERT INTO [Models] (ModelID, Name, ManufacturerID)
VALUES (101, 'X1', 1),
	   (102, 'i6', 1),
	   (103, 'Model S', 2),
	   (104, 'Model X', 2),
	   (105, 'Model 3', 2),
	   (106, 'Nova', 3)
	   
	   
-- Problem 3.	Many-To-Many Relationship
-- Create three tables as follows. Use appropriate data types.
-- Insert the data from the example above.
-- Add primary keys and foreign keys. Have in mind that table StudentsExams should have a composite primary key.

CREATE TABLE Students
(
StudentID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL
)
 
INSERT INTO [Students] (StudentID, Name)
     VALUES (1, 'Mila'),
            (2, 'Toni'),
            (3, 'Ron');
 
CREATE TABLE Exams
(
ExamID INT PRIMARY KEY,
Name VARCHAR(50)
)
 
INSERT INTO [Exams] (ExamID, Name)
     VALUES (101, 'Spring MVC'),
            (102, 'Neo4j'),
            (103, 'Oracle 11g');
 
CREATE TABLE StudentsExams
(
StudentID INT NOT NULL,
ExamID INT  NOT NULL
)
 
INSERT INTO StudentsExams (StudentID, ExamID)
     VALUES (1, 101),
            (1, 102),
            (2, 101),
            (3, 103),
            (2, 102),
            (2, 103)

ALTER TABLE StudentsExams
ADD CONSTRAINT PK_StudentID_ExamID PRIMARY KEY (StudentID, ExamID)

ALTER TABLE StudentsExams
ADD CONSTRAINT FK_StudentExams_Students FOREIGN KEY (StudentID)
REFERENCES Students(StudentID)

ALTER TABLE StudentsExams
ADD CONSTRAINT FK_StudentExams_Exams FOREIGN KEY (ExamID) 
REFERENCES Exams(ExamID)