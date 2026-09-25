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

-- بررسی وجود جدول و حذف آن
DROP TABLE IF EXISTS SalesOrderDetail2;
GO
-- Sales.SalesOrderDetail تهیه کپی از جدول
DROP TABLE IF EXISTS SalesOrderDetail2;
GO

SELECT * INTO SalesOrderDetail2 FROM Sales.SalesOrderDetail;
GO

/*
ProductID اعمال جستجو بر روی فیدل 
 Execution Plan بررسی 
*/

SELECT * FROM SalesOrderDetail2
	WHERE ProductID = 900;
GO
--------------------------------------------------------------------

-- SalesOrderDetail2 بر روی جدول NONCLUSTERED INDEX ایجاد
CREATE NONCLUSTERED INDEX IX_ProductID ON SalesOrderDetail2(ProductID);
GO

-- مشاهده ایندکس
SP_HELPINDEX SalesOrderDetail2;
GO

-- Execution Plan بررسی 
SELECT * FROM SalesOrderDetail2
	WHERE ProductID = 900;
GO
