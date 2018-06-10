/* 	Part I – Queries for SoftUni Database */
USE SoftUni 
GO

/*	Problem 1.	Find Names of All Employees by First Name 
Write a SQL query to find first and last names of all employees whose first name starts with “SA”.
Submit your query statements as Prepare DB & run queries.*/
SELECT [FirstName], [LastName] 
  FROM [dbo].[Employees]
 WHERE [FirstName] LIKE 'SA%'

/*	Problem 2.	  Find Names of All employees by Last Name 
Write a SQL query to find first and last names of all employees whose last name contains “ei”. */
SELECT [FirstName], [LastName] 
  FROM [dbo].[Employees]
 WHERE [LastName] LIKE '%ei%'

/* Problem 3.	Find First Names of All Employees
Write a SQL query to find the first names of all employees in the departments with ID 3 or 10
and whose hire year is between 1995 and 2005 inclusive. */
SELECT [FirstName]
  FROM [dbo].[Employees]
 WHERE [DepartmentID] = 3
    OR [DepartmentID] = 10
   AND ([HireDate] BETWEEN '1995-01-01' AND '2005-12-31')

/*	Problem 4.	Find All Employees Except Engineers
Write a SQL query to find the first and last names of all employees whose job titles does not contain “engineer”. */
SELECT [FirstName], [LastName] 
  FROM [dbo].[Employees]
 WHERE [JobTitle] NOT LIKE '%engineer%'

/*	Problem 5.	Find Towns with Name Length
Write a SQL query to find town names that are 5 or 6 symbols long and order them alphabetically by town name. */
SELECT [Name]
  FROM [dbo].[Towns]
 WHERE DATALENGTH([Name]) IN (5, 6)
 ORDER BY [Name] ASC

/*	Problem 6.	 Find Towns Starting With
Write a SQL query to find all towns that start with letters M, K, B or E. Order them alphabetically by town name. */
SELECT [TownID],
	   [Name]
  FROM [dbo].[Towns]
 WHERE [Name] LIKE '[MKBE]_%'
 ORDER BY [Name] ASC

/*	Problem 7.	 Find Towns Not Starting With
Write a SQL query to find all towns that does not start with letters R, B or D. Order them alphabetically by name. */
SELECT [TownID],
	   [Name]
  FROM [dbo].[Towns]
 WHERE [Name] NOT LIKE '[RBD]%'
 ORDER BY [Name] ASC

/*	Problem 8.	Create View Employees Hired After 2000 Year
Write a SQL query to create view V_EmployeesHiredAfter2000 with first and last name to all employees
hired after 2000 year. */
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT [FirstName],
	   [LastName]
  FROM [dbo].[Employees]
 WHERE [HireDate] > '2001-01-01'

/*	Problem 9.	Length of Last Name
Write a SQL query to find the names of all employees whose last name is exactly 5 characters long.*/
SELECT [FirstName],
	   [LastName]
  FROM [dbo].[Employees]
 WHERE DATALENGTH([LastName]) = 5

/*	Part II – Queries for Geography Database */
USE [Geography]
GO

/*	Problem 10.	Countries Holding ‘A’ 3 or More Times
Find all countries that holds the letter 'A' in their name at least 3 times (case insensitively), sorted by ISO code.
Display the country name and ISO code. */
SELECT [CountryName],
       [IsoCode]
  FROM [dbo].[Countries]
 WHERE [CountryName] LIKE '%A%A%a%'
 ORDER BY [IsoCode]

/*	Problem 11.	 Mix of Peak and River Names
Combine all peak names with all river names,
so that the last letter of each peak name is the same like the first letter of its corresponding river name.
Display the peak names, river names, and the obtained mix. Sort the results by the obtained mix. */
SELECT [PeakName],
       [RiverName],
	   CONCAT(LOWER([PeakName]), LOWER(RIGHT([RiverName], LEN([RiverName]) - 1))) AS Mix
  FROM [dbo].[Peaks],
       [dbo].[Rivers]
 WHERE RIGHT([PeakName], 1) = LEFT([RiverName], 1)
 ORDER BY Mix


/*	Part III – Queries for Diablo Database */
USE Diablo
GO

/*	Problem 12.	Games from 2011 and 2012 year
Find the top 50 games ordered by start date, then by name of the game.
Display only games from 2011 and 2012 year. Display start date in the format “YYYY-MM-DD”. */
SELECT TOP 50 [Name] AS Game,
	   CONVERT(DATE, [Start]) AS Start
  FROM [dbo].[Games] 
 WHERE [Start] BETWEEN '2011-01-01 00:00:00' AND '2012-12-31 23:59:59'
 ORDER BY [Start], [Name]
/* OR */
SELECT TOP 50 Name AS Game,
       CONVERT(varchar(10), Start, 120)
  FROM Games
 WHERE YEAR(Start) BETWEEN '2011' AND '2012'
 ORDER BY Start, Name

 /*	Problem 13.	 User Email Providers
Find all users along with information about their email providers.
Display the username and email provider.
Sort the results by email provider alphabetically, then by username. */
SELECT [Username],
       REPLACE(SUBSTRING([Email], CHARINDEX('@', [Email]), LEN([Email])), '@', '') AS 'Email Provider'
  FROM [Users]
 ORDER BY [Email Provider],
       [Username]

/*	Problem 14.	 Get Users with IPAdress Like Pattern
Find all users along with their IP addresses sorted by username alphabetically. Display only rows that IP address matches the pattern: “***.1^.^.***”. Submit your query statements as Prepare DB & run queries.
Legend: * - one symbol, ^ - one or more symbols */
SELECT [Username],
       [IpAddress] AS 'Ip Address'
  FROM [dbo].[Users]
 WHERE [IpAddress] LIKE '___.1%.%.___'
 ORDER BY [Username]

/*	Problem 15.	 Show All Games with Duration and Part of the Day
Find all games with part of the day and duration sorted by game name alphabetically
then by duration and part of the day. Parts of the day should be Morning (time is >= 0 and < 12),
Afternoon (time is >= 12 and < 18), Evening (time is >= 18 and < 24).
Duration should be Extra Short (smaller or equal to 3), Short (between 4 and 6 including),
Long (greater than 6) and Extra Long (without duration). */
SELECT [Name] AS 'Game', 'Part of the Day' = CASE
  WHEN CONVERT(VARCHAR(8), [Start], 8) BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
  WHEN CONVERT(VARCHAR(8), [Start], 8) BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
  ELSE 'Evening'
   END,'Duration' = CASE
  WHEN [Duration] <= 3 THEN 'Extra Short'
  WHEN [Duration] BETWEEN 4 AND 6 THEN 'Short'
  WHEN [Duration] > 6 THEN 'Long'
  ELSE 'Extra Long'
   END
  FROM [Games]
 ORDER BY [Name], [Duration], [Start]


/*	Part IV – Date Functions Queries*/
/* Problem 16.	 Orders Table
You are given a table Orders(Id, ProductName, OrderDate) filled with data.
Consider that the payment for that order must be accomplished within 3 days after the order date.
Also the delivery date is up to 1 month. Write a query to show each product’s name, order date, pay
and deliver due dates. */
CREATE DATABASE DateFunctionsQueries;
GO
 
USE DateFunctionsQueries;
GO
 
CREATE TABLE Orders
(
Id INT,
ProductName VARCHAR(50),
OrderDate DATETIME
CONSTRAINT PK_Order_Id PRIMARY KEY (Id)
);
 
INSERT INTO [Orders] (Id, ProductName, OrderDate)
VALUES (1, 'Butter', '2016-09-19 00:00:00.000'),
(2, 'Milk', '2016-09-30 00:00:00.000'),
(3, 'Cheese', '2016-09-04 00:00:00.000'),
(4, 'Bread', '2015-12-20 00:00:00.000'),
(5, 'Tomatoes', '2015-12-30 00:00:00.000');
 
SELECT [ProductName],
       [OrderDate],
	   DATEADD(DAY, 3, [OrderDate]) AS 'Pay Due',
	   DATEADD(MONTH, 1, [OrderDate]) AS 'Deliver Due'
  FROM [Orders]