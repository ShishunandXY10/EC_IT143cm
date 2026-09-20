/*****************************************************************************************************************
NAME:    EC_IT143_W3.4_CM.sql
PURPOSE: Answer 8 Questions

MODIFICATION LOG:
Ver      Date        Author            Description
-----   ----------   ---------------   -------------------------------------------------------------------------------
1.0     09/19/2026   Christian Morse   1. Built this script for IT143


RUNTIME: 
1s

NOTES: 
3.3 https://byupw.instructure.com/courses/58753/discussion_topics/481636?module_item_id=2332227
3.4 https://byupw.instructure.com/courses/58753/discussion_topics/481637?module_item_id=2332228

Sources for help:
https://www.mssqltips.com/tutorial/information-schema-tables/
https://blog.dbdiagram.io/adventure-works-database-schema/
https://medium.com/learning-sql/eadventureworks-database-427e59144bc0
 
******************************************************************************************************************/

--Q1 was written by Eunice Onyebuchi Nwankpa

/*
Q1. Which products currently have a red color?
*/

SELECT * FROM Production.Product
WHERE Color='Red'

-------------------------------------------------------------------------------------------------------------------------

--Q2 was written by Marvens Merisier

/*
Q2. Which product has the highest list price?
*/

--	Answer should be 'Road-150 Red, 62' with ProductID 749 and ListPrice 3578.27

SELECT TOP 1 * FROM Production.Product
ORDER BY ListPrice DESC

-------------------------------------------------------------------------------------------------------------------------

--Q3 was written by Chase Liam Carnahan

/*
Q3. I need to see our highest earning employees and how their revenue relates 
in terms of how many products they have sold.
*/

--	He did not specify which fields to display, but I think these make sense.

SELECT Sales.SalesPerson.BusinessEntityID, SalesQuota, Bonus, SalesYTD,
	SalesLastYear, FirstName, LastName
FROM Sales.SalesPerson, Person.Person
WHERE Sales.SalesPerson.BusinessEntityID=Person.Person.BusinessEntityID
ORDER BY SalesYTD DESC

-------------------------------------------------------------------------------------------------------------------------

--Q4 was written by Stewart Mark Nelson

/*
Q4. What is the total cost for all of the units for product ID 881 within the company’s stockroom?
*/

--	TotalCost should be 324 * 53.99 = [17492.76] in this scenario, but he did not specify if he meant
--	to use ListPrice (Retail sale value) or StandardCost (Our cost to manufacture)

SELECT (Quantity * ListPrice) AS TotalCost
FROM Production.Product, Production.ProductInventory
WHERE Production.Product.ProductID=Production.ProductInventory.ProductID
	AND Production.Product.ProductID=881

-------------------------------------------------------------------------------------------------------------------------

--Q5 was written by me (Christian Morse)

/*
Q5. I need a better idea of how many total items of each type have been scrapped across all Work Orders.
To that end, show me the Product ID, Product Name, how many orders with at least 1 scrapped item that
product appeared in (AS NumProducts), and the combined total of scrapped items for that product across
all orders (AS ScrapTotal). Organize it with the highest ScrapTotals first.
*/

--		Answer's 1st row should be [ProductID 331 NumProducts 51 ScrapTotal 1374]

SELECT Production.WorkOrder.ProductID,
	COUNT(Production.WorkOrder.ProductID) AS NumProducts,
	SUM(ScrappedQty) AS ScrapTotal
FROM Production.WorkOrder
WHERE (ScrappedQty > 0)
GROUP BY Production.WorkOrder.ProductID
ORDER BY ScrapTotal DESC

-------------------------------------------------------------------------------------------------------------------------

--Q6 was written by me (Christian Morse)

/*
Q6. HR needs your help to remind them which of the two current Employees in their list were actually
hired from the Job Candidates list. You will need to combine three different sources to get all the
needed data. Show the Business Entity ID, Job Candidate ID, Job Title, Last Name, First Name, and
Hire Date. Organize it by Business Entity ID
*/

--		Answer should be
--		[212 8 Quality Assurance Supervisor Wu Peng 2008-12-09
--		274 4 North American Sales Manager Jiang Stephen 2011-01-04]

SELECT HumanResources.Employee.BusinessEntityID, JobCandidateID, JobTitle, LastName, FirstName,HireDate
FROM HumanResources.JobCandidate, HumanResources.Employee, Person.Person
WHERE HumanResources.Employee.BusinessEntityID=HumanResources.JobCandidate.BusinessEntityID 
	AND HumanResources.Employee.BusinessEntityID=Person.Person.BusinessEntityID
GROUP BY HumanResources.Employee.BusinessEntityID, JobCandidateID, JobTitle, LastName, FirstName,HireDate

-------------------------------------------------------------------------------------------------------------------------

--Q7 was written by Sebastian Andrew Rojas Jara

/*
Q7. Using INFORMATION_SCHEMA.TABLES, can you list all the tables in the Sales schema
and show their table type?
*/

SELECT * FROM AdventureWorks2022.INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'Sales'

-------------------------------------------------------------------------------------------------------------------------

--Q8 was written by Filipe Latu

/*
Q8. Can you find the AdventureWorks tables that contain a column named CustomerID using the 
INFORMATION_SCHEMA.COLUMNS view?
*/

SELECT * FROM AdventureWorks2022.INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'CustomerID'

-------------------------------------------------------------------------------------------------------------------------

SELECT GETDATE() AS my_date;