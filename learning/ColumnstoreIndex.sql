--------------------------------------------------------------------
/*
SQL Server دوره آموزشی کوئری‌نویسی در 
Email:       hossein.khajvand1994@gmail.com
LinkedIn:	 https://www.linkedin.com/in/hossein-khajvand/
Created By:  Hossein Khajvand
*/
--------------------------------------------------------------------
/*
مقایسه حالت های ذخیره سازی
Heap,Clustered,Columnstore
*/
USE master
GO
IF DB_ID('ColumnStoreIndex')>0
BEGIN
	ALTER DATABASE ColumnStoreIndex SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE ColumnStoreIndex
END
GO
RESTORE FILELISTONLY FROM DISK ='D:\TehranUniversity\BI\03-DW\BK\ColumnStoreIndex.bak'
GO
RESTORE DATABASE ColumnStoreIndex FROM DISK ='D:\TehranUniversity\BI\03-DW\BK\ColumnStoreIndex.bak' WITH 
	MOVE 'ColumnStoreIndex' TO 'D:\TehranUniversity\BI\03-DW\BK\ColumnStoreIndex.mdf',
	MOVE 'DemoPageOrganization_log' TO 'D:\TehranUniversity\BI\03-DW\BK\DemoPageOrganization_log.lmdf',
	STATS=1
GO
--------------------------------------------------------------------
--بررسی جدول و نمایش ایندکس ها
--Object Explorer در 
GO
--------------------------------------------------------------------
USE ColumnStoreIndex
GO
--بررسی حجم و تعداد رکوردهای هر کدام از جداول
SP_SPACEUSED ColumnstoreTable
GO
SP_SPACEUSED ClusteredTable
GO
SP_SPACEUSED HeapTable
GO
--------------------------------------------------------------------
/*
اجرای کوئری های تحلیلی مشاهده 
*/

--ColumnstoreTable اجرای کوئری برای جدول 
SELECT  
	OrderDateKey/100,ProductKey,
	COUNT(OrderQuantity) AS COUNT_OrderQuantity,
	SUM(SalesAmount) AS SUM_SalesAmount
FROM ColumnstoreTable
WHERE OrderDateKey BETWEEN 20020701 AND 20030701
GROUP BY (OrderDateKey/100),ProductKey
GO
--ClusteredTable اجرای کوئری برای جدول 
SELECT  
	OrderDateKey/100,ProductKey,
	COUNT(OrderQuantity) AS COUNT_OrderQuantity,
	SUM(SalesAmount) AS SUM_SalesAmount
FROM ClusteredTable
WHERE OrderDateKey BETWEEN 20020701 AND 20030701
GROUP BY (OrderDateKey/100),ProductKey
GO
--HeapTable اجرای کوئری برای جدول 
SELECT  
	OrderDateKey/100,ProductKey,
	COUNT(OrderQuantity) AS COUNT_OrderQuantity,
	SUM(SalesAmount) AS SUM_SalesAmount
FROM HeapTable
WHERE OrderDateKey BETWEEN 20020701 AND 20030701
GROUP BY (OrderDateKey/100),ProductKey
GO
--------------------------------------------------------------------
USE ColumnStoreIndex
GO
--بررسی حجم و تعداد رکوردهای هر کدام از جداول
SP_SPACEUSED ColumnstoreTable
GO
SP_SPACEUSED ClusteredTable
GO
SP_SPACEUSED HeapTable
GO
--------------------------------------------------------------------
/*
Clustered Columnstore Index بررسی ساخت 
*/
USE ColumnStoreIndex
GO
--بر روی یک ایندکس کلاستر Clustered Columnstore Index ساخت 
CREATE CLUSTERED COLUMNSTORE INDEX IX_CCI ON ClusteredTable
GO
--بر روی جدول هیپ Clustered Columnstore Index ساخت 
CREATE CLUSTERED COLUMNSTORE INDEX IX_CCI ON HeapTable
GO
--------------------------------------------------------------------
USE ColumnStoreIndex
GO
--بررسی حجم و تعداد رکوردهای هر کدام از جداول
SP_SPACEUSED ColumnstoreTable
GO
SP_SPACEUSED ClusteredTable
GO
SP_SPACEUSED HeapTable
GO