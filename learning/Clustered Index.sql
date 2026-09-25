--------------------------------------------------------------------
/*
SQL Server دوره آموزشی کوئری‌نویسی در 
Email:       hossein.khajvand1994@gmail.com
LinkedIn:	 https://www.linkedin.com/in/hossein-khajvand/
Created By:  Hossein Khajvand
*/
--------------------------------------------------------------------

DROP DATABASE IF EXISTS Index_DB;
GO

CREATE DATABASE Index_DB;
GO

USE Index_DB;
GO

DROP TABLE IF EXISTS ClusteredTable;
GO

-- Heap ایجاد یک جدول از نوع
CREATE TABLE ClusteredTable
(
	ID INT,
	FirstName NCHAR(2000),
	LastName NCHAR(2000)
);
GO

--بررسی ایندکس های جدول
SP_HELPINDEX ClusteredTable;
GO

-- درج تعدادی رکورد تستی
INSERT INTO ClusteredTable
VALUES
	(1, N'رضا', N'افخم نیا'),
	(5, N'فرزاد', N'ملکی'),
	(3, N'کیانا', N'صداقت کیش'),
	(4, N'علی', N'صداقت کیش'),
	(2, N'سام', N'کرمی'),
	(10, N'سعید', N'صادقی'),
	(8, N'کیوان', N'اولیایی'),
	(9, N'حسن', N'رنجبریان'),
	(7, N'بهروز', N'دباشی'),
	(6, N'امیر', N'تفرشی');
GO

-- .فاقد هرگونه نظم و ترتیبی هستند ClusteredTable رکوردهای موجود در جدول 
SELECT * FROM ClusteredTable;
GO

SP_SPACEUSED ClusteredTable;
GO
--------------------------------------------------------------------

-- ClusteredTable بر روی جدول CLUSTERED ساخت ایندکس
CREATE CLUSTERED INDEX Clustered_IX ON ClusteredTable(ID);
GO

SELECT * FROM ClusteredTable;
GO

SP_SPACEUSED ClusteredTable;
GO

