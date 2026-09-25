--------------------------------------------------------------------
/*
SQL Server دوره آموزشی کوئری‌نویسی در 
Email:       hossein.khajvand1994@gmail.com
LinkedIn:	 https://www.linkedin.com/in/hossein-khajvand/
Created By:  Hossein Khajvand
*/
--------------------------------------------------------------------

USE TehranDataAd;
GO

DROP TABLE IF EXISTS HeapTable;
GO

--Heap ایجاد یک جدول از نوع
CREATE TABLE HeapTable
(
	ID INT,
	FirstName CHAR(3000),
	LastName CHAR(3000)
);
GO

--بررسی ایندکس های جدول
SP_HELPINDEX HeapTable;
GO


--درج تعدادی رکورد تستی
INSERT INTO HeapTable(ID,FirstName,LastName)
values
	(1,N'سهیلا', N'تقوی'),
	(2,N'احمد', N'شریفی'),
	(3,N'رضا', N'کرمی'),
	(4,N'پریسا', N'سعادت'),
	(5,N'سهیل', N'عباس‌پور');
GO


SELECT * FROM HeapTable