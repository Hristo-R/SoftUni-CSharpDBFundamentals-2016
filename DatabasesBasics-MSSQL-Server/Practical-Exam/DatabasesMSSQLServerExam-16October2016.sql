
-- Section1: DDL

CREATE TABLE Flights(
FlightID INT PRIMARY KEY,
DepartureTime DATETIME NOT NULL,
ArrivalTime DATETIME NOT NULL,
[Status] VARCHAR(9)  NOT NULL CHECK ([Status] IN('Departing', 'Delayed', 'Arrived', 'Cancelled')),
OriginAirportID INT NOT NULL,
DestinationAirportID INT NOT NULL,
AirlineID INT NOT NULL
CONSTRAINT FK_Flights_OriginAirportID_Airports FOREIGN KEY(OriginAirportID)
REFERENCES Airports(AirportID),
CONSTRAINT FK_Flights_DestinationAirportID_Airports FOREIGN KEY(DestinationAirportID)
REFERENCES Airports(AirportID),
CONSTRAINT FK_Flights_AirlineID_Airlines FOREIGN KEY(AirlineID)
REFERENCES Airlines(AirlineID)
)

CREATE TABLE Tickets(
TicketID INT PRIMARY KEY,
Price DECIMAL(8, 2) NOT NULL,
Class VARCHAR(6) NOT NULL CHECK (Class IN('First', 'Second', 'Third')),
Seat VARCHAR(5) NOT NULL,
CustomerID INT NOT NULL,
FlightID INT NOT NULL,
CONSTRAINT FK_Tickets_Customers FOREIGN KEY(CustomerID)
REFERENCES Customers(CustomerID),
CONSTRAINT FK_Tickets_Flights FOREIGN KEY(FlightID)
REFERENCES Flights(FlightID)
)



-- Section 2: DML - 01. Data Insertion

INSERT INTO Flights(
FlightID, DepartureTime, ArrivalTime, [Status], OriginAirportID, DestinationAirportID, AirlineID)
VALUES
(1,	CAST('2016-10-13 06:00 AM' AS DateTime), CAST('2016-10-13 10:00 AM' AS DateTime), 'Delayed', 1, 4, 1),
(2,	CAST('2016-10-12 12:00 PM' AS DateTime), CAST('2016-10-12 12:01 PM' AS DateTime), 'Departing', 1, 3, 2),
(3,	CAST('2016-10-14 03:00 PM' AS DateTime), CAST('2016-10-20 04:00 AM' AS DateTime), 'Delayed', 4, 2, 4),
(4,	CAST('2016-10-12 01:24 PM' AS DateTime), CAST('2016-10-12 4:31 PM' AS DateTime), 'Departing', 3, 1, 3),
(5,	CAST('2016-10-12 08:11 AM' AS DateTime), CAST('2016-10-12 11:22 PM' AS DateTime), 'Departing', 4, 1, 1),
(6,	CAST('1995-06-21 12:30 PM' AS DateTime), CAST('1995-06-22 08:30 PM' AS DateTime), 'Arrived', 2, 3, 5),
(7,	CAST('2016-10-12 11:34 PM' AS DateTime), CAST('2016-10-13 03:00 AM' AS DateTime), 'Departing', 2, 4, 2),
(8,	CAST('2016-11-11 01:00 PM' AS DateTime), CAST('2016-11-12 10:00 PM' AS DateTime), 'Delayed', 4, 3, 1),
(9,	CAST('2015-10-01 12:00 PM' AS DateTime), CAST('2015-12-01 01:00 AM' AS DateTime), 'Arrived', 1, 2, 1),
(10, CAST('2016-10-12 07:30 PM' AS DateTime), CAST('2016-10-13 12:30 PM' AS DateTime), 'Departing', 2, 1, 7)

INSERT INTO Tickets(TicketID, Price, Class, Seat, CustomerID, FlightID)
VALUES
(1,	3000.00, 'First','233-A', 3, 8),
(2,	1799.90, 'Second', '123-D', 1, 1),
(3,	1200.50, 'Second', '12-Z', 2, 5),
(4,	410.68, 'Third', '45-Q', 2, 8),
(5,	560.00,	'Third', '201-R', 4, 6),
(6,	2100.00, 'Second', '13-T', 1, 9),
(7,	5500.00, 'First', '98-O', 2, 7)



-- Section 2: DML - 02. Update Arrived Flights

UPDATE [dbo].[Flights]
SET [AirlineID] = 1
WHERE [Status] = 'Arrived'



-- Section 2: DML - 03. Update Tickets

UPDATE [dbo].[Tickets]
   SET [Price] += [Price] * 0.5
WHERE [TicketID] = (SELECT top 1 [AirlineID]
					  FROM [dbo].[Airlines]
					  GROUP BY [AirlineID], [Rating]
					  ORDER BY [Rating])

		
		
-- Section 2: DML - 04. Table Creation

CREATE TABLE CustomerReviews(
ReviewID INT PRIMARY KEY,
ReviewContent VARCHAR(255) NOT NULL,
ReviewGrade INT NOT NULL CHECK (ReviewGrade IN(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)),
AirlineID INT  NOT NULL,
CustomerID INT  NOT NULL

CONSTRAINT FK_CustomerReviews_Airlines FOREIGN KEY(AirlineID)
REFERENCES Airlines(AirlineID),
CONSTRAINT FK_CustomerReviews_Customers FOREIGN KEY(CustomerID)
REFERENCES Customers(CustomerID)
)

CREATE TABLE CustomerBankAccounts(
AccountID INT PRIMARY KEY,
AccountNumber VARCHAR(10) NOT NULL UNIQUE,
Balance DECIMAL(10, 2) NOT NULL,
CustomerID INT NOT NULL

CONSTRAINT FK_CustomerBankAccounts_Customers FOREIGN KEY(CustomerID)
REFERENCES Customers(CustomerID),
)



-- Section 2: DML - 05. Fill the new Tables with Data

INSERT INTO CustomerReviews(ReviewID, ReviewContent, ReviewGrade, AirlineID, CustomerID)
VALUES
(1,	'Me is very happy. Me likey this airline. Me good.', 10, 1, 1),
(2,	'Ja, Ja, Ja... Ja, Gut, Gut, Ja Gut! Sehr Gut!', 10, 1, 4),
(3,	'Meh...',	5, 4, 3),
(4,	'Well Ive seen better, but Ive certainly seen a lot worse...', 7, 3, 5)

INSERT INTO CustomerBankAccounts(AccountID, AccountNumber, Balance, CustomerID)
VALUES
(1,	'123456790', 2569.23, 1),
(2,	'18ABC23672', 14004568.23, 2),
(3,	'F0RG0100N3', 19345.20, 5)



-- Section 3 - Task 01: Extract All Tickets

SELECT [TicketID], [Price], [Class], [Seat]
  FROM [dbo].[Tickets]
 ORDER BY [TicketID]
 
 
 
-- Section 3 - Task 02: Extract All Customers 

SELECT [CustomerID], CONCAT([FirstName], ' ', [LastName]) AS FullName, [Gender]
  FROM [dbo].[Customers]
 ORDER BY FullName ASC, [CustomerID] ASC
 
 
 
-- Section 3 - Task 03: Extract Delayed Flights 

SELECT [FlightID], [DepartureTime], [ArrivalTime]
  FROM [dbo].[Flights]
 WHERE [Status] = 'Delayed'
 ORDER BY [FlightID] ASC
 











