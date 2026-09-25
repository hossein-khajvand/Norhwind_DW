--------------------------------------------------------------------
/*
SQL Server دوره آموزشی کوئری‌نویسی در 
Email:       hossein.khajvand1994@gmail.com
LinkedIn:	 https://www.linkedin.com/in/hossein-khajvand/
Created By:  Hossein Khajvand
*/
--------------------------------------------------------------------
-- Heap بررسی معایب 

USE TehranDataAd;
GO

DBCC DROPCLEANBUFFERS;
CHECKPOINT;
GO

-- Clustered و Heap مربوط به Executio Plan مقایسه
SELECT * FROM SalesOrderDetail_Heap
	WHERE SalesOrderID = 72855;
SELECT * FROM SalesOrderDetail_Clustered
	WHERE SalesOrderID = 72855;
GO