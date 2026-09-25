--------------------------------------------------------------------
/*
SQL Server دوره آموزشی کوئری‌نویسی در 
Email:       hossein.khajvand1994@gmail.com
LinkedIn:	 https://www.linkedin.com/in/hossein-khajvand/
Created By:  Hossein Khajvand
*/
--------------------------------------------------------------------
--Heap Table بررسی محاسن 

USE TehranDataAd;
GO

--Heap ایجاد یک جدول از نوع 
DROP TABLE IF EXISTS SalesOrderDetail_Heap;
GO

CREATE TABLE SalesOrderDetail_Heap
(
	SalesOrderID INT NOT NULL,
	SalesOrderDetailID INT,
	CarrierTrackingNumber NVARCHAR(25) NULL,
	OrderQty SMALLINT NULL,
	ProductID INT NULL,
	SpecialOfferID INT NULL,
	UnitPrice MONEY  NULL,
	UnitPriceDiscount MONEY,
	LineTotal  MONEY,
	rowguid UNIQUEIDENTIFIER,
	ModifiedDate DATETIME 
);
GO

--Clustered ایجاد یک جدول از نوع 
DROP TABLE IF EXISTS SalesOrderDetail_Clustered;
GO

CREATE TABLE SalesOrderDetail_Clustered
(
	SalesOrderID INT NOT NULL,
	SalesOrderDetailID INT,
	CarrierTrackingNumber NVARCHAR(25) NULL,
	OrderQty SMALLINT NULL,
	ProductID INT NULL,
	SpecialOfferID INT NULL,
	UnitPrice MONEY  NULL,
	UnitPriceDiscount MONEY,
	LineTotal  MONEY,
	rowguid UNIQUEIDENTIFIER,
	ModifiedDate DATETIME 
);
GO

--ایجاد کلاستر ایندکس به ازای جدول
CREATE CLUSTERED INDEX IX_Clustered 
ON SalesOrderDetail_Clustered (SalesOrderID,SalesOrderDetailID);
GO
--------------------------------------------------------------------

SELECT
	SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber
    ,OrderQty ,ProductID, SpecialOfferID, UnitPrice,
	UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM AdventureWorks2019.Sales.SalesOrderDetail;
GO

--Heap درج دیتا در جدول 
INSERT INTO SalesOrderDetail_Heap
(
	SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber,
	OrderQty, ProductID, SpecialOfferID, UnitPrice,
	UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
)
SELECT  
	SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber
    ,OrderQty ,ProductID, SpecialOfferID, UnitPrice,
	UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM AdventureWorks2019.Sales.SalesOrderDetail;
GO 10

--Clustered درج دیتا در جدول 
INSERT INTO SalesOrderDetail_Clustered
(
	SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber,
	OrderQty, ProductID, SpecialOfferID, UnitPrice,
	UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
)
SELECT
	SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber
    ,OrderQty ,ProductID, SpecialOfferID, UnitPrice,
	UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM AdventureWorks2019.Sales.SalesOrderDetail;
GO 10
--------------------------------------------------------------------

--مشاهده فضای تخصیص یافته به جداول
SP_SPACEUSED SalesOrderDetail_Heap;
GO

SP_SPACEUSED SalesOrderDetail_Clustered;
GO
