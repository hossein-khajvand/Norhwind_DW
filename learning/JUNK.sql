-- 1. Order Priority
CREATE TABLE dbo.DimOrderPriority (
    OrderPriorityID INT PRIMARY KEY,
    OrderPriorityName NVARCHAR(20)
);

INSERT INTO dbo.DimOrderPriority VALUES
(1, 'Low'), (2, 'Medium'), (3, 'High');

-- 2. Payment Method
CREATE TABLE dbo.DimPaymentMethod (
    PaymentMethodID INT PRIMARY KEY,
    PaymentMethodName NVARCHAR(20)
);

INSERT INTO dbo.DimPaymentMethod VALUES
(1, 'Cash'), (2, 'Credit Card'), (3, 'Bank Transfer');

-- 3. Shipment Status
CREATE TABLE dbo.DimShipmentStatus (
    ShipmentStatusID INT PRIMARY KEY,
    ShipmentStatusName NVARCHAR(20)
);

INSERT INTO dbo.DimShipmentStatus VALUES
(1, 'Pending'), (2, 'Shipped'), (3, 'Delivered'), (4, 'Returned');

-- 4. Gift Wrap Flag
CREATE TABLE dbo.DimGiftWrap (
    GiftWrapID INT PRIMARY KEY,
    GiftWrapFlag BIT,
    GiftWrapDescription NVARCHAR(10)
);

INSERT INTO dbo.DimGiftWrap VALUES
(1, 0, 'No'), (2, 1, 'Yes');
--**************************************************
SELECT * FROM dbo.DimOrderPriority
SELECT * FROM dbo.DimPaymentMethod
SELECT * FROM dbo.DimShipmentStatus
SELECT * FROM dbo.DimGiftWrap
--**************************************************
DROP TABLE IF EXISTS dbo.DimOrderJunk
CREATE TABLE dbo.DimOrderJunk (
    JunkKey INT IDENTITY(1,1) PRIMARY KEY,
    OrderPriorityID INT,
	OrderPriorityName NVARCHAR(20),
    PaymentMethodID INT,
	PaymentMethodName NVARCHAR(20),
    ShipmentStatusID INT,
	ShipmentStatusName NVARCHAR(20),
    GiftWrapID INT,
	GiftWrapFlag BIT
);

INSERT INTO dbo.DimOrderJunk (OrderPriorityID, PaymentMethodID, ShipmentStatusID, GiftWrapID,OrderPriorityName,
PaymentMethodName,ShipmentStatusName,GiftWrapFlag)
SELECT 
    p.OrderPriorityID,
    pm.PaymentMethodID,
    s.ShipmentStatusID,
    g.GiftWrapID,
	OrderPriorityName,
	PaymentMethodName,
	ShipmentStatusName,
	GiftWrapFlag
FROM dbo.DimOrderPriority p
CROSS JOIN dbo.DimPaymentMethod pm
CROSS JOIN dbo.DimShipmentStatus s
CROSS JOIN dbo.DimGiftWrap g;
--*************************************************
CREATE TABLE dbo.FactOrders2 (
    OrderID INT PRIMARY KEY,
    CustomerID NVARCHAR(5),
    OrderDate DATE,
    Freight MONEY,
    JunkKey INT FOREIGN KEY REFERENCES dbo.DimOrderJunk(JunkKey)
);
--*******************************
INSERT INTO dbo.FactOrders2(OrderID, CustomerID, OrderDate, Freight/*, JunkKey*/)
SELECT 
    o.OrderID,
    o.CustomerID,
    o.OrderDate,
    o.Freight
FROM Northwind.dbo.Orders o;

SELECT * FROM dbo.FactOrders2
SELECT * FROM dbo.DimOrderJunk
DROP TABLE IF EXISTS dbo.FactOrders2,dbo.DimOrderPriority
									,dbo.DimPaymentMethod
									,dbo.DimShipmentStatus
									,dbo.DimGiftWrap
									,dbo.DimOrderJunk