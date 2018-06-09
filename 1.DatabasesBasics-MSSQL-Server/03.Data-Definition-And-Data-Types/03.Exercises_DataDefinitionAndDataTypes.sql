/*Part I – Queries for SoftUni Database
•	Towns (Id, Name)
•	Addresses (Id, AddressText, TownId)
•	Departments (Id, Name)
•	Employees (Id, FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)
*/

/* Problem 2.	Find All Information About Departments
Write a SQL query to find all available information about the Departments. */
SELECT *
  FROM Departments
  
/*	Problem 3.	Find all Department Names
Write SQL query to find all Department names. */
SELECT Name
  FROM Departments
  
/*	Problem 4.	Find Salary of Each Employee
Write SQL query to find the first name, last name and salary of each employee. */
SELECT FirstName, LastName, Salary
  FROM Employees
  
/* Problem 5.	Find Full Name of Each Employee
Write SQL query to find the first, middle and last name of each employee. */
SELECT FirstName AS 'First Name',
       MiddleName AS 'Middle Name',
	   LastName AS 'Last Name'
  FROM Employees

/*	Problem 6.	Find Email Address of Each Employee (select and concat)
Emails should look like “John.Doe@softuni.bg"*/
SELECT (FirstName + '.' + LastName + '@softuni.bg') AS 'Email Address'  
FROM Employees

/*	Problem 7.	Find All Different Employee’s Salaries
Write a SQL query to find all different employee’s salaries. Show only the salaries. */
SELECT DISTINCT Salary
FROM Employees

/*	Problem 8.	Find all Information About Employees
Write a SQL query to find all information about the employees whose job title is “Sales Representative”. */
SELECT *
  FROM Employees
 WHERE JobTitle = 'Sales Representative'
 
/*	Problem 9.	Find Names of All Employees by Salary in Range
Write a SQL query to find the first name, last name and job title of all employees whose salary is in the range [20000, 30000]. */
SELECT FirstName,
	   LastName,
	   JobTitle
  FROM Employees
 WHERE Salary BETWEEN 20000 AND 30000

/*	Problem 10.	 Find Names of All Employees 
Write a SQL query to find the full name of all employees whose salary is 25000, 14000, 12500 or 23600.
Full Name is combination of first, middle and last name (separated with single space) and they should be in one column called “Full Name”.*/
SELECT (FirstName + ' ' + MiddleName + ' ' + LastName) AS 'Full Name'  
  FROM Employees
 WHERE Salary = 25000
    OR Salary = 14000
	OR Salary = 12500
    OR Salary = 23600

/* OR */
SELECT e.FirstName, e.MiddleName, e.LastName
CONCAT (FirstName, ' ', MiddleName, ' ', LastName) AS 'Full Name'  
  FROM Employees AS e
 WHERE Salary IN (25000, 14000, 12500, 23600)
	
	
/*	Problem 11.	 Find All Employees Without Manager
Write a SQL query to find first and last names about those employees that does not have a manager. */
SELECT FirstName,
	   LastName
  FROM Employees
 WHERE ManagerID IS NULL


/*	Problem 12.	 Find All Employees with Salary More Than 50000
Write a SQL query to find first name, last name and salary of those employees who has salary more than 50000.
Order them in decreasing order by salary. */
SELECT FirstName,
	   LastName,
	   Salary
  FROM Employees
 WHERE Salary > 50000
 ORDER BY Salary DESC

/*	Problem 13.	 Find 5 Best Paid Employees.
Write SQL query to find first and last names about 5 best paid Employees ordered descending by their salary.*/
SELECT TOP 5
	FirstName,
	LastName
  FROM Employees
 ORDER BY Salary DESC
 
 /*	Problem 14.	Find All Employees Except Marketing
Write a SQL query to find the first and last names of all employees whose department ID is different from 4. */
SELECT FirstName,
	   LastName
  FROM Employees
 WHERE DepartmentId != 4

/*Problem 15.	Sort Employees Table
Write a SQL query to sort all records in the Employees table by the following criteria: 
•	First by salary in decreasing order
•	Then by first name alphabetically
•	Then by last name descending
•	Then by middle name alphabetically*/
SELECT *
  FROM Employees
 ORDER BY Salary DESC,
	   FirstName,
	   LastName DESC,
	   MiddleName
	   
/*	Problem 16.	 Create View Employees with Salaries
Write a SQL query to create a view V_EmployeesSalaries with first name, last name and salary for each employee. */
CREATE VIEW V_EmployeesSalaries AS
SELECT FirstName,
	   LastName,
	   Salary
  FROM Employees
  
/* 	Problem 17.	Create View Employees with Job Titles
Write a SQL query to create view V_EmployeeNameJobTitle with full employee name and job title.
When middle name is NULL replace it with empty string (‘’). */
CREATE VIEW V_EmployeeNameJobTitle AS
SELECT CONCAT(FirstName, ' ', ISNULL(MiddleName, ''), ' ', LastName) AS 'Full Name', JobTitle AS 'Job Title'
FROM Employees

/*	Problem 18.	 Distinct Job Titles
Write a SQL query to find all distinct job titles. */
SELECT DISTINCT JobTitle
FROM Employees

/*	Problem 19.	Find First 10 Started Projects
Write a SQL query to find first 10 started projects. Select all information about them and sort them by start date, then by name. */
SELECT TOP 10 *
  FROM Projects
 ORDER BY StartDate,
       Name
	   
/*	Problem 20.	 Last 7 Hired Employees
Write a SQL query to find last 7 hired employees. Select their first, last name and their hire date. */
SELECT TOP 7
       FirstName, LastName, HireDate
  FROM Employees
 ORDER BY HireDate
 
/*	Problem 21.	Increase Salaries
Write a SQL query to increase salaries of all employees that are in the
Engineering, Tool Design, Marketing or Information Services department by 12%. 
Then select Salaries column from the Employees table. 
After that exercise restore your database to revert those changes.  */
UPDATE Employees
   SET Salary *= 1.12
 WHERE DepartmentId IN 
	(SELECT DepartmentId 
	   FROM Departments
	  WHERE Name IN 
		('Engineering', 'Tool Design', 'Marketing', 'Information Services'))
						
SELECT Salary 
  FROM Employees
 
/* OR */
UPDATE Employees
   SET Salary += Salary * 0.12
 WHERE DepartmentId = 1
    OR DepartmentId = 2
	OR DepartmentId = 4
    OR DepartmentId = 11
	
SELECT Salary
  FROM Employees
 
 
/*	Part II – Queries for Geography Database */

/*	Problem 22.	 All Mountain Peaks
Display all mountain peaks in alphabetical order. */
SELECT PeakName
  FROM Peaks
 WHERE MountainId IS NOT NULL
 ORDER BY PeakName
 
/* 	Problem 23.	 Biggest Countries by Population
Find the 30 biggest countries by population from Europe. 
Display the country name and population. 
Sort the results by population (from biggest to smallest), then by country alphabetically. */
SELECT TOP 30 
	   CountryName,
	   Population 
  FROM Countries
 WHERE ContinentCode = 'EU'
 ORDER BY 
	   Population DESC,
       CountryName
	   
/*	Problem 24.	 Countries and Currency (Euro / Not Euro)
Find all countries along with information about their currency.
Display the country code, country name and information about its currency: either "Euro" or "Not Euro".
Sort the results by country name alphabetically. */
SELECT CountryName,
	   CountryCode,
	   CASE
			WHEN CurrencyCode = 'EUR' THEN 'Euro'
			ELSE 'Not Euro'
	   END AS 'Currency'
  FROM Countries
 ORDER BY CountryName
 
 
 
 
 
 
 
 
 
 


