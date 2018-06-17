USE [Gringotts]
GO

-- Problem 1.	Record's Count
-- Import the database and send the total count of records to Mr. Bodrog. Make sure nothing got lost.*/

SELECT COUNT([Id]) AS Count
FROM [dbo].[WizzardDeposits]

-- Problem 2.	Longest Magic Wand
-- Select the size of the longest magic wand. Rename the new column appropriately.
SELECT MAX([MagicWandSize]) AS LongestMagicWand
  FROM [WizzardDeposits]

-- Problem 3.	Longest Magic Wand per Deposit Groups
-- For wizards in each deposit group show the longest magic wand. Rename the new column appropriately.
SELECT [DepositGroup], MAX([MagicWandSize]) AS 'LongestMagicWand'
  FROM [WizzardDeposits] 
 GROUP BY [DepositGroup]

-- Problem 4.	* Smallest Deposit Group per Magic Wand Size
-- Select the deposit group with the lowest average wand size.
 SELECT [DepositGroup] FROM
(SELECT [DepositGroup], AVG([MagicWandSize]) AS AverageMagicWandSize
   FROM [dbo].[WizzardDeposits]
  GROUP BY [DepositGroup]) AS a
  WHERE AverageMagicWandSize = ( SELECT MIN(AverageMagicWandSize) AS MinAverageMagicWandSize
								   FROM
								(SELECT [DepositGroup], AVG([MagicWandSize]) AS AverageMagicWandSize
								   FROM [dbo].[WizzardDeposits]
								  GROUP BY [DepositGroup]) AS av)
-- OR
  SELECT [DepositGroup]
    FROM (SELECT AVG([MagicWandSize]) AS 'MagicWandSizes'
            FROM [WizzardDeposits]
           GROUP BY [DepositGroup])
	  AS a, [WizzardDeposits]
GROUP BY [DepositGroup]
  HAVING AVG([MagicWandSize]) = MIN(a.[MagicWandSizes]);

