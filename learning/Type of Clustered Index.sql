--------------------------------------------------------------------
/*
SQL Server دوره آموزشی کوئری‌نویسی در 
Email:       hossein.khajvand1994@gmail.com
LinkedIn:	 https://www.linkedin.com/in/hossein-khajvand/
Created By:  Hossein Khajvand
*/
--------------------------------------------------------------------

/*
CLUSTERED INDEX
*/

USE Index_DB;
GO

DROP TABLE IF EXISTS ClusteredTable
GO

-- Heap ایجاد یک جدول از نوع
CREATE TABLE ClusteredTable
(
	ID INT,
	FirstName NCHAR(2000),
	LastName NCHAR(2000)
);
GO

-- بررسی ایندکس های جدول
SP_HELPINDEX ClusteredTable;
GO

-- درج تعدادی رکورد تستی
INSERT INTO ClusteredTable
VALUES
	(1, N'حمید', N'سعادت‌نژاد'),
	(5, N'پریسا', N'یزدانیان'),
	(3, N'علی', N'تقوی'),
	(4, N'مجید', N'پاکروان'),
	(2, N'فرهاد', N'رضایی'),
	(1, N'زهرا', N'غفاری'),
	(8, N'مهدی', N'پوینده'),
	(9, N'سمانه', N'اکبری'),
	(1, N'بیژن', N'تولایی'),
	(6, N'فاطمه', N'شریفی');
GO

/*
نکته مهم
ایجاد کنیم CLUSTERED INDEX اگر بر روی جدولی ایندکسی از نوع
آن‌گاه مقادیر کلید ایندکس می‌تواند تکراری باشد
.ولی به‌ازای هر مقدار تکراری به‌میزان 4 بایت فضای اضافی تخصیص داده می‌شود
*/
CREATE CLUSTERED INDEX IX_Clustered ON ClusteredTable(ID);
GO

SELECT * FROM ClusteredTable;
GO

INSERT INTO ClusteredTable
VALUES
	(1, N'مهدی', N'تقوی‌');
GO

SELECT * FROM ClusteredTable;
GO
--------------------------------------------------------------------
--------------------------------------------------------------------

/*
Primary Key
*/

--بررسی وجود جدول
DROP TABLE IF EXISTS Students;
GO

-- Heap ایجاد یک جدول از نوع
CREATE TABLE Students
(
	ID INT NOT NULL ,
	FirstName NCHAR(2000),
	LastName NCHAR(2000)
);
GO

--بررسی ایندکس های جدول
SP_HELPINDEX Students;
GO

--درج تعدادی رکورد تستی
INSERT INTO Students
VALUES
	(1, N'حمید', N'سعادت‌نژاد'),
	(5, N'پریسا', N'یزدانیان'),
	(3, N'علی', N'تقوی'),
	(4, N'مجید', N'پاکروان'),
	(2, N'فرهاد', N'رضایی'),
	(10, N'زهرا', N'غفاری'),
	(8, N'مهدی', N'پوینده'),
	(9, N'سمانه', N'اکبری'),
	(7, N'بیژن', N'تولایی'),
	(6, N'فاطمه', N'شریفی');
GO

-- .فاقد نظم و ترتیب هستند Students رکوردهای موجود در جدول
SELECT * FROM Students;
GO

-- Students بر روی جدول Priamry Key اعمال
ALTER TABLE Students ADD CONSTRAINT PK_Students PRIMARY KEY (ID);
GO

-- Students بررسی وضعیت مرتب سازی رکوردهای جدول
SELECT * FROM Students;
GO

-- عدم درج مقدار تکراری به‌ازای فیلد کلید
INSERT INTO Students
VALUES
	(3, N'فریبا', N'زمانی');
GO
--------------------------------------------------------------------

/*
به جداول Primary Key بررسی انواع حالت های مربوط به اضافه کردن

باشند!!! : نکته مهم Not Null باید Primary Key فیلد یا فیلدهای کاندید برای
*/

DROP TABLE IF EXISTS Persons;
GO
-- Primary Key ساخت جدول به‌همراه 
CREATE TABLE Persons 
(
    ID INT NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    PRIMARY KEY (ID)
);
GO

DROP TABLE IF EXISTS Persons;
GO
-- Primary Key ساخت جدول به‌همراه 
CREATE TABLE Persons 
(
    ID INT NOT NULL PRIMARY KEY,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT
);
GO

DROP TABLE IF EXISTS Persons;
GO
-- Primary Key ساخت جدول به‌همراه 
CREATE TABLE Persons 
(
    ID INT NOT NULL CONSTRAINT PK_ID PRIMARY KEY,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT
);
GO
--------------------------------------------------------------------

-- ترکیبی Primary Key ساخت جدول به همراه
DROP TABLE IF EXISTS Students;
GO

CREATE TABLE Students 
(
    ID INT NOT NULL,
    FirstName NVARCHAR(255) NOT NULL,
    LastName NVARCHAR(255),
    CONSTRAINT PK_Students PRIMARY KEY (ID,LastName)
);
GO

INSERT INTO Students
VALUES
	(1, N'حمید', N'سعادت‌نژاد'),
	(5, N'پریسا', N'یزدانیان'),
	(3, N'علی', N'تقوی'),
	(4, N'مجید', N'پاکروان'),
	(2, N'فرهاد', N'رضایی'),
	(10, N'زهرا', N'غفاری'),
	(8, N'مهدی', N'پوینده'),
	(9, N'سمانه', N'اکبری'),
	(7, N'بیژن', N'تولایی'),
	(6, N'فاطمه', N'شریفی');
GO

SELECT * FROM Students;
GO

DROP TABLE IF EXISTS Students;
GO

CREATE TABLE Students 
(
    ID INT NOT NULL,
    FirstName NVARCHAR(255) NOT NULL,
    LastName NVARCHAR(255),
    CONSTRAINT PK_Students PRIMARY KEY (LastName,ID)
);
GO

INSERT INTO Students
VALUES
	(1, N'حمید', N'سعادت‌نژاد'),
	(5, N'پریسا', N'یزدانیان'),
	(3, N'علی', N'تقوی'),
	(4, N'مجید', N'پاکروان'),
	(2, N'فرهاد', N'رضایی'),
	(10, N'زهرا', N'غفاری'),
	(8, N'مهدی', N'پوینده'),
	(9, N'سمانه', N'اکبری'),
	(7, N'بیژن', N'تولایی'),
	(6, N'فاطمه', N'شریفی');
GO

SELECT * FROM Students;
GO
--------------------------------------------------------------------

-- .به جدول هایی که از قبل ایجاد شده‌اند Primary Key اضافه کردن 
DROP TABLE IF EXISTS Persons;
GO

CREATE TABLE Persons 
(
    ID INT NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT
);
GO

ALTER TABLE Persons ADD CONSTRAINT PK_Person PRIMARY KEY (ID,LastName);
GO
-- .این دستور معادل دستور بالا است
ALTER TABLE Persons ADD PRIMARY KEY (ID);
GO

-- از جدول Primary Key حذف
ALTER TABLE Persons DROP CONSTRAINT PK_Person;
GO
--------------------------------------------------------------------

/*
?ایجاد کرد Primary Key در چه صورت می‌توان برای جدولی که حاوی رکورد است
*/
DROP TABLE IF EXISTS Students;
GO

CREATE TABLE Students
(
	ID INT NOT NULL ,
	FirstName CHAR(2000),
	LastName CHAR(2000)
);
INSERT INTO Students
VALUES
	(1, N'حمید', N'سعادت‌نژاد'),
	(1, N'پریسا', N'یزدانیان'),
	(3, N'علی', N'تقوی'),
	(4, N'مجید', N'پاکروان'),
	(2, N'فرهاد', N'رضایی'),
	(10, N'زهرا', N'غفاری'),
	(8, N'مهدی', N'پوینده'),
	(9, N'سمانه', N'اکبری'),
	(7, N'بیژن', N'تولایی'),
	(6, N'فاطمه', N'شریفی');
GO

ALTER TABLE Students ADD CONSTRAINT PK_Students PRIMARY KEY (ID);
GO

--------------------------------------------------------------------
--------------------------------------------------------------------

/*
UNIQUE CLUSTERED INDEX
*/

DROP TABLE IF EXISTS Students;
GO

CREATE TABLE Students
(
	ID INT,
	FirstName NCHAR(2000),
	LastName NCHAR(2000)
);
GO

-- بررسی ایندکس های جدول
SP_HELPINDEX Students;
GO

-- درج تعدادی رکورد تستی
INSERT INTO Students
VALUES
	(1, N'حمید', N'سعادت‌نژاد'),
	(5, N'پریسا', N'یزدانیان'),
	(3, N'علی', N'تقوی'),
	(4, N'مجید', N'پاکروان'),
	(7, N'فرهاد', N'رضایی'),
	(10, N'زهرا', N'غفاری'),
	(8, N'مهدی', N'پوینده'),
	(9, N'سمانه', N'اکبری'),
	(2, N'بیژن', N'تولایی'),
	(6, N'فاطمه', N'شریفی');
GO

SELECT * FROM Students;
GO

CREATE UNIQUE CLUSTERED INDEX IX_U_Clustered ON Students(ID);
GO

-- بررسی ایندکس های جدول
SP_HELPINDEX Students;
GO

SELECT * FROM Students;
GO

INSERT INTO Students
VALUES
		(NULL, N'سعید', N'صفایی‌');
GO

SELECT * FROM Students;
GO

INSERT INTO Students
VALUES
		(NULL, N'ندا', N'کریمی‌');
GO
--------------------------------------------------------------------