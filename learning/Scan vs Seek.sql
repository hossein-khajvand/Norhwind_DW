--------------------------------------------------------------------
/*
SQL Server دوره آموزشی کوئری‌نویسی در 
Email:       hossein.khajvand1994@gmail.com
LinkedIn:	 https://www.linkedin.com/in/hossein-khajvand/
Created By:  Hossein Khajvand
*/
--------------------------------------------------------------------

USE AdventureWorks2019;
GO

DROP TABLE IF EXISTS SalesOrderDetail2;
GO

-- Sales.SalesOrderDetail ساخت یک نمونه کپی از جدول
SELECT * INTO SalesOrderDetail2 FROM Sales.SalesOrderDetail;
GO

SP_HELPINDEX SalesOrderDetail2;
GO

SP_SPACEUSED SalesOrderDetail2;
GO
--------------------------------------------------------------------

/*
Seek و Scan بررسی مفهوم
*/

-- Scan بررسی عملیات 
SELECT * FROM SalesOrderDetail2
	WHERE SalesOrderID = 75000;
GO

SP_HELPINDEX 'Sales.SalesOrderDetail';
GO

-- Seek بررسی عملیات 
SELECT * FROM Sales.SalesOrderDetail
	WHERE SalesOrderID = 75000;
GO

--Clustered Index Scan بررسی عملیات 
SELECT * FROM Sales.SalesOrderDetail
	WHERE OrderQty = 1;
GO
--------------------------------------------------------------------

-- Scan بررسی عملیات
SELECT * FROM SalesOrderDetail2
	WHERE SalesOrderID = 75000;
GO

-- Seek بررسی عملیات 
SELECT * FROM Sales.SalesOrderDetail
	WHERE SalesOrderID = 75000;
GO

