-- Database export via SQLPro (https://www.sqlprostudio.com/allapps.html)
-- Exported by michael at 21-02-2021 12:24.
-- WARNING: This file may contain descructive statements such as DROPs.
-- Please ensure that you are running the script at the proper location.


IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = N'ActivityLogs')
	EXEC sp_executesql N'CREATE SCHEMA [ActivityLogs]';
GO

IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = N'Communications')
	EXEC sp_executesql N'CREATE SCHEMA [Communications]';
GO

IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = N'Customers')
	EXEC sp_executesql N'CREATE SCHEMA [Customers]';
GO

IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = N'Financials')
	EXEC sp_executesql N'CREATE SCHEMA [Financials]';
GO

IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = N'Hotels')
	EXEC sp_executesql N'CREATE SCHEMA [Hotels]';
GO

-- BEGIN TABLE ActivityLogs.CustomerAccountLog
IF OBJECT_ID('ActivityLogs.CustomerAccountLog', 'U') IS NOT NULL
DROP TABLE ActivityLogs.CustomerAccountLog;
GO

CREATE TABLE ActivityLogs.CustomerAccountLog (
	CustomerID int NULL,
	username varchar(50) NULL,
	eventDate date NULL,
	event varchar(30) NULL
);
GO

-- Inserting 2 rows into ActivityLogs.CustomerAccountLog
-- Insert batch #1
INSERT INTO ActivityLogs.CustomerAccountLog (CustomerID, username, eventDate, event) VALUES
(1, 'michael', '2021-02-20 00:00:00', 'Customer deleted'),
(23, 'michael', '2021-02-20 00:00:00', 'Customer created');

-- END TABLE ActivityLogs.CustomerAccountLog

-- BEGIN TABLE Communications.CustomerMessages
IF OBJECT_ID('Communications.CustomerMessages', 'U') IS NOT NULL
DROP TABLE Communications.CustomerMessages;
GO

CREATE TABLE Communications.CustomerMessages (
	messageID int NOT NULL IDENTITY(1,1),
	guestID int NULL,
	reservationID int NULL,
	staffID int NULL,
	guestMessage text NULL,
	replyMessage text NULL,
	messageDate datetime NULL,
	replyDate datetime NULL
);
GO

ALTER TABLE Communications.CustomerMessages ADD CONSTRAINT PK__Customer__4808B8738BDDADBC PRIMARY KEY (messageID);
GO

-- Table Communications.CustomerMessages contains no data. No inserts have been genrated.
-- Inserting 0 rows into Communications.CustomerMessages


-- END TABLE Communications.CustomerMessages

-- BEGIN TABLE Communications.Testimonials
IF OBJECT_ID('Communications.Testimonials', 'U') IS NOT NULL
DROP TABLE Communications.Testimonials;
GO

CREATE TABLE Communications.Testimonials (
	testimonialID int NOT NULL IDENTITY(1,1),
	roomID int NULL,
	guestID int NULL,
	[date] datetime NULL,
	guestComment text NULL,
	guestScore int NULL,
	hotelComment text NULL
);
GO

ALTER TABLE Communications.Testimonials ADD CONSTRAINT PK__Testimon__BB60213F5E5FDBEC PRIMARY KEY (testimonialID);
GO

-- Table Communications.Testimonials contains no data. No inserts have been genrated.
-- Inserting 0 rows into Communications.Testimonials


-- END TABLE Communications.Testimonials

-- BEGIN TABLE Customers.CustomerAccounts
IF OBJECT_ID('Customers.CustomerAccounts', 'U') IS NOT NULL
DROP TABLE Customers.CustomerAccounts;
GO

CREATE TABLE Customers.CustomerAccounts (
	customerID int NOT NULL IDENTITY(1,1),
	guestID int NULL,
	username varchar(50) NULL,
	password varchar(32) NULL,
	accountCreated date NOT NULL,
	latestLogin date NULL
);
GO

ALTER TABLE Customers.CustomerAccounts ADD CONSTRAINT PK__Customer__549F13D0C97B7459 PRIMARY KEY (customerID);
GO

-- Inserting 1 row into Customers.CustomerAccounts
-- Insert batch #1
INSERT INTO Customers.CustomerAccounts (customerID, guestID, username, password, accountCreated, latestLogin) VALUES
(23, 2, 'michael', 'D8578EDF8458CE06FBC5BB76A58C5CA4', '2021-01-01 00:00:00', '2021-01-01 00:00:00');

-- END TABLE Customers.CustomerAccounts

-- BEGIN TABLE Customers.GuestAddresses
IF OBJECT_ID('Customers.GuestAddresses', 'U') IS NOT NULL
DROP TABLE Customers.GuestAddresses;
GO

CREATE TABLE Customers.GuestAddresses (
	addressID int NOT NULL IDENTITY(0,1),
	guestID int NULL,
	addressField varchar(100) NULL,
	addressField_Extra varchar(100) NULL,
	postalCode varchar(100) NULL,
	city varchar(100) NULL,
	country varchar(100) NULL
);
GO

ALTER TABLE Customers.GuestAddresses ADD CONSTRAINT GuestAddresses_PK PRIMARY KEY (addressID);
GO

-- Inserting 1 row into Customers.GuestAddresses
-- Insert batch #1
INSERT INTO Customers.GuestAddresses (addressID, guestID, addressField, addressField_Extra, postalCode, city, country) VALUES
(0, 2, 'Småstugevägen 21', NULL, '41676', 'Göteborg', 'Sverige');

-- END TABLE Customers.GuestAddresses

-- BEGIN TABLE Customers.Guests
IF OBJECT_ID('Customers.Guests', 'U') IS NOT NULL
DROP TABLE Customers.Guests;
GO

CREATE TABLE Customers.Guests (
	guestID int NOT NULL IDENTITY(1,1),
	firstName varchar(50) NOT NULL,
	lastName varchar(50) NOT NULL,
	personalID varchar(256) NULL,
	email varchar(256) NULL DEFAULT (NULL),
	phone varchar(20) NULL
);
GO

ALTER TABLE Customers.Guests ADD CONSTRAINT PK__Guests__8D59CD7C3D1AA2E4 PRIMARY KEY (guestID);
GO

-- Inserting 4 rows into Customers.Guests
-- Insert batch #1
INSERT INTO Customers.Guests (guestID, firstName, lastName, personalID, email, phone) VALUES
(2, 'Michael', 'Hejl', ' åg­iôN¦œ ¦ÉãLÄ   úÞ!$¡KØe¤Cÿ”®­Te÷€ó?L©™ÑgÃXâ,ê•?c@W¶©s ÛcI&)À', ' åg­iôN¦œ ¦ÉãLÄ   ç>lîN¹W¿ì•5›~½,bªâQƒÞl4ÅáÓÎåD’­Iò}&ÍRÚÇÛ}¯­OZƒ®ócKýÙ‰Ã¨Y›Ý	', '0046735103910'),
(3, 'Berra', 'Kurra', ' åg­iôN¦œ ¦ÉãLÄ   óøO®®æ¯¬˜_þ÷küQÁ]ãµÝÆ–Û¦‘3É—¡|Û[€å&N?’OÏ', ' åg­iôN¦œ ¦ÉãLÄ   ?Î†t«”1UT	mt™§Å{é?,°f˜–€DÜ÷õ„sn}—nyn·¨ï©»}–', '0046123456789'),
(9, 'Kurra', 'Gömma', ' åg­iôN¦œ ¦ÉãLÄ   ?«H„?@H?*…ð%^‡úæýè¿ó.!ƒs==#ÏôÛŸïÄšO¡É§?qÇ›®', ' åg­iôN¦œ ¦ÉãLÄ   8š¶úåZË“ ãgwS‹FGFä®CURYð''T¥¡6¤k|®ºÿšo', '0046123456789'),
(11, 'Kenta', 'Kofot', ' åg­iôN¦œ ¦ÉãLÄ   Äˆ  ý=D9¼ž5n„‰‡·Sí{’°Ÿ“BÿNÔÝ>’.•d®_‡½]2«5¬', ' åg­iôN¦œ ¦ÉãLÄ   …)¹‚HéÙ©tV.åû•û¬¾“™õÉ%#ËtÌa$Ôð;^?¥çö?RÉ±ó´', NULL);

-- END TABLE Customers.Guests

-- BEGIN TABLE Financials.Discounts
IF OBJECT_ID('Financials.Discounts', 'U') IS NOT NULL
DROP TABLE Financials.Discounts;
GO

CREATE TABLE Financials.Discounts (
	discountID int NOT NULL IDENTITY(1,1),
	validFrom datetime NULL,
	validTo datetime NULL,
	discountName varchar(50) NULL,
	discountCode varchar(50) NULL
);
GO

ALTER TABLE Financials.Discounts ADD CONSTRAINT PK__Discount__D2130A06756F1C7D PRIMARY KEY (discountID);
GO

-- Inserting 1 row into Financials.Discounts
-- Insert batch #1
INSERT INTO Financials.Discounts (discountID, validFrom, validTo, discountName, discountCode) VALUES
(1, '2021-06-01 00:00:00.000', '2021-09-01 00:00:00.000', 'Sommarkampanj 2021', 'summer2021');

-- END TABLE Financials.Discounts

-- BEGIN TABLE Financials.PaymentCards
IF OBJECT_ID('Financials.PaymentCards', 'U') IS NOT NULL
DROP TABLE Financials.PaymentCards;
GO

CREATE TABLE Financials.PaymentCards (
	cardID int NOT NULL IDENTITY(1,1),
	guestID int NULL,
	cardType varchar(30) NULL,
	cardNumber varchar(16) NULL,
	cardValidMonth smallint NULL,
	cardValidYear smallint NULL,
	cardCVC smallint NULL
);
GO

ALTER TABLE Financials.PaymentCards ADD CONSTRAINT PK__PaymentC__4D5BC4B19F412190 PRIMARY KEY (cardID);
GO

-- Table Financials.PaymentCards contains no data. No inserts have been genrated.
-- Inserting 0 rows into Financials.PaymentCards


-- END TABLE Financials.PaymentCards

-- BEGIN TABLE Financials.Payments
IF OBJECT_ID('Financials.Payments', 'U') IS NOT NULL
DROP TABLE Financials.Payments;
GO

CREATE TABLE Financials.Payments (
	paymentID int NOT NULL IDENTITY(1,1),
	guestID int NULL,
	reservationID int NULL,
	cardID int NULL,
	paymentDate datetime NULL,
	amountPaid decimal(10,2) NULL,
	invoiceSent int NOT NULL DEFAULT ('0')
);
GO

ALTER TABLE Financials.Payments ADD CONSTRAINT PK__Payments__A0D9EFA6B7F104BE PRIMARY KEY (paymentID);
GO

-- Table Financials.Payments contains no data. No inserts have been genrated.
-- Inserting 0 rows into Financials.Payments


-- END TABLE Financials.Payments

-- BEGIN TABLE Hotels.Hotel
IF OBJECT_ID('Hotels.Hotel', 'U') IS NOT NULL
DROP TABLE Hotels.Hotel;
GO

CREATE TABLE Hotels.Hotel (
	hotelID int NOT NULL IDENTITY(1,1),
	name varchar(100) NULL,
	address varchar(100) NULL,
	phone varchar(20) NULL,
	email varchar(50) NULL
);
GO

ALTER TABLE Hotels.Hotel ADD CONSTRAINT PK__Hotel__17ADC49216C76738 PRIMARY KEY (hotelID);
GO

-- Inserting 1 row into Hotels.Hotel
-- Insert batch #1
INSERT INTO Hotels.Hotel (hotelID, name, address, phone, email) VALUES
(1, 'Ocean View Lindholmen', 'Newton Hotel, Ocean View Lindholmen;Lindholmspiren 1;400 00;Göteborg', '004631100100', 'oceanviewlindholmen@newtonhotels.com');

-- END TABLE Hotels.Hotel

-- BEGIN TABLE Hotels.Reservations
IF OBJECT_ID('Hotels.Reservations', 'U') IS NOT NULL
DROP TABLE Hotels.Reservations;
GO

CREATE TABLE Hotels.Reservations (
	reservationID int NOT NULL IDENTITY(1,1),
	guestID int NULL,
	roomID int NOT NULL,
	checkInDate smalldatetime NOT NULL,
	checkOutDate smalldatetime NOT NULL,
	specialDemands varchar(255) NULL,
	discountCode varchar(50) NULL,
	numberOfGuests int NOT NULL,
	payWithCard int NOT NULL DEFAULT ('0'),
	guestArrived datetime NULL,
	lateCheckOut int NOT NULL DEFAULT ('0')
);
GO

ALTER TABLE Hotels.Reservations ADD CONSTRAINT PK__Reservat__B14BF5A527A65226 PRIMARY KEY (reservationID);
GO

-- Inserting 3 rows into Hotels.Reservations
-- Insert batch #1
INSERT INTO Hotels.Reservations (reservationID, guestID, roomID, checkInDate, checkOutDate, specialDemands, discountCode, numberOfGuests, payWithCard, guestArrived, lateCheckOut) VALUES
(15, 2, 1, '2021-03-01 15:00:00', '2021-03-04 11:00:00', NULL, NULL, 2, 0, NULL, 0),
(16, NULL, 3, '2021-03-01 15:00:00', '2021-03-04 11:00:00', NULL, NULL, 1, 0, NULL, 0),
(17, 2, 4, '2021-03-04 15:00:00', '2021-03-06 14:00:00', NULL, NULL, 2, 0, NULL, 1);

-- END TABLE Hotels.Reservations

-- BEGIN TABLE Hotels.Rooms
IF OBJECT_ID('Hotels.Rooms', 'U') IS NOT NULL
DROP TABLE Hotels.Rooms;
GO

CREATE TABLE Hotels.Rooms (
	roomID int NOT NULL IDENTITY(1,1),
	hotelID int NULL,
	roomNumber varchar(15) NULL,
	roomRate money NULL,
	guestCapacity int NULL,
	extraBedsAllowed int NULL,
	lateCheckOutFee money NULL,
	roomType int NULL
);
GO

ALTER TABLE Hotels.Rooms ADD CONSTRAINT PK__Rooms__B65AD7230F1342CD PRIMARY KEY (roomID);
GO

-- Inserting 6 rows into Hotels.Rooms
-- Insert batch #1
INSERT INTO Hotels.Rooms (roomID, hotelID, roomNumber, roomRate, guestCapacity, extraBedsAllowed, lateCheckOutFee, roomType) VALUES
(1, 1, '100', 1000, 1, 0, 200, 1),
(2, 1, '200', 1200, 1, 0, 200, 2),
(3, 1, '201', 1500, 2, 1, 400, 3),
(4, 1, '202', 1800, 2, 1, 400, 4),
(5, 1, '301', 1500, 2, 1, 400, 3),
(6, 1, '302', 3000, 2, 2, 600, 5);

-- END TABLE Hotels.Rooms

-- BEGIN TABLE Hotels.RoomTypes
IF OBJECT_ID('Hotels.RoomTypes', 'U') IS NOT NULL
DROP TABLE Hotels.RoomTypes;
GO

CREATE TABLE Hotels.RoomTypes (
	typesID int NOT NULL IDENTITY(1,1),
	description varchar(50) NULL
);
GO

ALTER TABLE Hotels.RoomTypes ADD CONSTRAINT PK__RoomType__0E465020D5794AD2 PRIMARY KEY (typesID);
GO

-- Inserting 5 rows into Hotels.RoomTypes
-- Insert batch #1
INSERT INTO Hotels.RoomTypes (typesID, description) VALUES
(1, 'Enkelrum Standard'),
(2, 'Enkelrum Deluxe'),
(3, 'Dubbelrum Standard'),
(4, 'Dubbelrum Deluxe'),
(5, 'Juniorsvit');

-- END TABLE Hotels.RoomTypes

-- BEGIN TABLE Hotels.Staff
IF OBJECT_ID('Hotels.Staff', 'U') IS NOT NULL
DROP TABLE Hotels.Staff;
GO

CREATE TABLE Hotels.Staff (
	staffID int NOT NULL IDENTITY(1,1),
	firstName varchar(50) NULL,
	lastName varchar(50) NULL,
	[position] varchar(50) NULL,
	hotelID int NULL,
	email varchar(100) NULL
);
GO

ALTER TABLE Hotels.Staff ADD CONSTRAINT PK__Staff__6465E19E618E3F85 PRIMARY KEY (staffID);
GO

-- Inserting 1 row into Hotels.Staff
-- Insert batch #1
INSERT INTO Hotels.Staff (staffID, firstName, lastName, [position], hotelID, email) VALUES
(1, 'Gill', 'Bates', 'Hotel Manager', 1, 'gill.bates@newtonhotels.se');

-- END TABLE Hotels.Staff

-- BEGIN TABLE Hotels.StaffLogin
IF OBJECT_ID('Hotels.StaffLogin', 'U') IS NOT NULL
DROP TABLE Hotels.StaffLogin;
GO

CREATE TABLE Hotels.StaffLogin (
	loginID int NOT NULL IDENTITY(1,1),
	staffID int NOT NULL,
	username varchar(100) NULL,
	password varchar(50) NULL
);
GO

ALTER TABLE Hotels.StaffLogin ADD CONSTRAINT PK__StaffLog__1F5EF42F4C22E97E PRIMARY KEY (loginID);
GO

-- Inserting 1 row into Hotels.StaffLogin
-- Insert batch #1
INSERT INTO Hotels.StaffLogin (loginID, staffID, username, password) VALUES
(6, 1, 'demo', 'fe01ce2a7fbac8fafaed7c982a04e229');

-- END TABLE Hotels.StaffLogin

IF EXISTS ( SELECT * FROM sysobjects WHERE  id = object_id(N'dbo.AddReservation') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
	DROP PROCEDURE dbo.AddReservation
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE AddReservation @guestID int, @roomID int, @checkInDate smalldatetime, @checkOutDate smalldatetime, @specialDemands varchar(255), @discountCode varchar(50), @numberOfGuests int
AS

BEGIN TRANSACTION
INSERT INTO Hotels.Reservations (guestID, roomID, checkInDate, checkOutDate, specialDemands, discountCode, numberOfGuests)
VALUES (@guestID, @roomID, @checkInDate, @checkOutDate, @specialDemands, @discountCode, @numberOfGuests);

DECLARE @roomFree int;
SET @roomFree = 0;

SELECT @roomFree = COUNT(*) FROM Hotels.Reservations
      WHERE roomID = @roomID
         AND checkInDate < @checkOutDate
         AND checkOutDate >= @checkInDate

IF @roomFree > 1
    BEGIN
    ROLLBACK TRANSACTION
    PRINT 'Room already booked.'
    END

ELSE
    BEGIN
    COMMIT TRANSACTION
    PRINT 'Booking complete.'
    END
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE  id = object_id(N'dbo.BookedRooms') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
	DROP PROCEDURE dbo.BookedRooms
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE BookedRooms @from date, @to date
AS
SELECT R.roomNumber Rum FROM Hotels.Rooms R
WHERE EXISTS 
     (SELECT * FROM Hotels.Reservations 
      WHERE roomID = R.roomID
         AND checkInDate < @to
         And checkOutDate >= @from)
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE  id = object_id(N'dbo.CheckAvailableRooms') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
	DROP PROCEDURE dbo.CheckAvailableRooms
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- Kontrollera alla lediga rum för ett visst datum och antal nätter -- 
CREATE PROCEDURE CheckAvailableRooms @from date, @nights int
AS
SELECT R.roomNumber Rum, R.roomRate Pris, RT.description Rumstyp FROM Hotels.Rooms R
INNER JOIN Hotels.RoomTypes RT ON R.roomType = RT.typesID
WHERE NOT EXISTS 
     (SELECT * FROM Hotels.Reservations 
      WHERE roomID = R.roomID
         AND checkInDate < DateAdd(DAY,+@nights,@from) -- @nights parametern: antal nätter
         AND checkOutDate >= @from) -- @from parametern: önskat ankomstdatum
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE  id = object_id(N'dbo.CleanUpAccounts') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
	DROP PROCEDURE dbo.CleanUpAccounts
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE CleanUpAccounts
AS
DELETE FROM Customers.CustomerAccounts
WHERE latestLogin < DateAdd(Year,-2,GetDate());
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE  id = object_id(N'dbo.FetchStaffData') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
	DROP PROCEDURE dbo.FetchStaffData
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE FetchStaffData @staffid int
AS
SELECT concat(a.firstName,' ', a.lastName) name, a.position pos, a.email mail FROM Hotels.Staff a
INNER JOIN Hotels.StaffLogin b ON b.staffID = a.staffID
WHERE a.staffID = @staffid
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE  id = object_id(N'dbo.GetCustomerPersonalID') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
	DROP PROCEDURE dbo.GetCustomerPersonalID
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE GetCustomerPersonalID @guestid int
AS
OPEN SYMMETRIC KEY GDPRSymKey
DECRYPTION BY CERTIFICATE GDPRCert with password = 'OneFierceBeerCoaster2021!'
SELECT convert(varchar, DecryptByKey(personalID)), convert(varchar, DecryptByKey(email)) from Customers.Guests
WHERE guestID = @guestid
close symmetric key GDPRSymKey
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE  id = object_id(N'dbo.GetReservation') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
	DROP PROCEDURE dbo.GetReservation
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- Sök reservation på efternamn och från-datum
CREATE PROCEDURE GetReservation @lname nvarchar(50), @date date
AS
SELECT a.checkInDate AS Incheckning, a.checkOutDate AS Utcheckning, c.roomNumber AS Rum, concat(b.firstName,' ',b.lastName) AS Gäst FROM Hotels.Reservations a
INNER JOIN Customers.Guests b ON a.guestID = b.guestID 
INNER JOIN Hotels.Rooms c ON a.roomID = c.roomID
WHERE b.lastName = @lname -- @lname parametern: Gästens efternamn
AND convert(DATE, a.checkInDate, 112) = @date -- @date parametern: Från vilket datum sökning skall utföras
GO

IF OBJECT_ID('Communications.CustomerMessages', 'U') IS NOT NULL AND OBJECT_ID('Hotels.Staff', 'U') IS NOT NULL
	ALTER TABLE Communications.CustomerMessages
	ADD CONSTRAINT FK__CustomerM__staff__7C1A6C5A
	FOREIGN KEY (staffID)
	REFERENCES Hotels.Staff (staffID);

IF OBJECT_ID('Communications.CustomerMessages', 'U') IS NOT NULL AND OBJECT_ID('Customers.Guests', 'U') IS NOT NULL
	ALTER TABLE Communications.CustomerMessages
	ADD CONSTRAINT FK__CustomerM__guest__6B24EA82
	FOREIGN KEY (guestID)
	REFERENCES Customers.Guests (guestID);

IF OBJECT_ID('Communications.CustomerMessages', 'U') IS NOT NULL AND OBJECT_ID('Hotels.Reservations', 'U') IS NOT NULL
	ALTER TABLE Communications.CustomerMessages
	ADD CONSTRAINT FK__CustomerM__reser__6C190EBB
	FOREIGN KEY (reservationID)
	REFERENCES Hotels.Reservations (reservationID);

IF OBJECT_ID('Communications.Testimonials', 'U') IS NOT NULL AND OBJECT_ID('Hotels.Rooms', 'U') IS NOT NULL
	ALTER TABLE Communications.Testimonials
	ADD CONSTRAINT FK__Testimoni__roomI__6E01572D
	FOREIGN KEY (roomID)
	REFERENCES Hotels.Rooms (roomID);

IF OBJECT_ID('Communications.Testimonials', 'U') IS NOT NULL AND OBJECT_ID('Customers.Guests', 'U') IS NOT NULL
	ALTER TABLE Communications.Testimonials
	ADD CONSTRAINT FK__Testimoni__guest__6477ECF3
	FOREIGN KEY (guestID)
	REFERENCES Customers.Guests (guestID);

IF OBJECT_ID('Customers.GuestAddresses', 'U') IS NOT NULL AND OBJECT_ID('Customers.Guests', 'U') IS NOT NULL
	ALTER TABLE Customers.GuestAddresses
	ADD CONSTRAINT GuestAddresses_FK
	FOREIGN KEY (guestID)
	REFERENCES Customers.Guests (guestID);

IF OBJECT_ID('Financials.PaymentCards', 'U') IS NOT NULL AND OBJECT_ID('Customers.Guests', 'U') IS NOT NULL
	ALTER TABLE Financials.PaymentCards
	ADD CONSTRAINT FK__PaymentCa__guest__66603565
	FOREIGN KEY (guestID)
	REFERENCES Customers.Guests (guestID);

IF OBJECT_ID('Financials.Payments', 'U') IS NOT NULL AND OBJECT_ID('Customers.Guests', 'U') IS NOT NULL
	ALTER TABLE Financials.Payments
	ADD CONSTRAINT FK__Payments__guestI__6A30C649
	FOREIGN KEY (guestID)
	REFERENCES Customers.Guests (guestID);

IF OBJECT_ID('Financials.Payments', 'U') IS NOT NULL AND OBJECT_ID('Financials.PaymentCards', 'U') IS NOT NULL
	ALTER TABLE Financials.Payments
	ADD CONSTRAINT FK__Payments__cardID__68487DD7
	FOREIGN KEY (cardID)
	REFERENCES Financials.PaymentCards (cardID);

IF OBJECT_ID('Financials.Payments', 'U') IS NOT NULL AND OBJECT_ID('Hotels.Reservations', 'U') IS NOT NULL
	ALTER TABLE Financials.Payments
	ADD CONSTRAINT FK__Payments__reserv__693CA210
	FOREIGN KEY (reservationID)
	REFERENCES Hotels.Reservations (reservationID);

IF OBJECT_ID('Hotels.Reservations', 'U') IS NOT NULL AND OBJECT_ID('Customers.Guests', 'U') IS NOT NULL
	ALTER TABLE Hotels.Reservations
	ADD CONSTRAINT FK__Reservati__guest__6383C8BA
	FOREIGN KEY (guestID)
	REFERENCES Customers.Guests (guestID);

IF OBJECT_ID('Hotels.Reservations', 'U') IS NOT NULL AND OBJECT_ID('Financials.Discounts', 'U') IS NOT NULL
	ALTER TABLE Hotels.Reservations
	ADD CONSTRAINT FK__Reservati__disco__3E1D39E1
	FOREIGN KEY (discountCode)
	REFERENCES Financials.Discounts (discountCode);

IF OBJECT_ID('Hotels.Reservations', 'U') IS NOT NULL AND OBJECT_ID('Hotels.Rooms', 'U') IS NOT NULL
	ALTER TABLE Hotels.Reservations
	ADD CONSTRAINT FK__Reservati__roomI__6754599E
	FOREIGN KEY (roomID)
	REFERENCES Hotels.Rooms (roomID);

IF OBJECT_ID('Hotels.Rooms', 'U') IS NOT NULL AND OBJECT_ID('Hotels.RoomTypes', 'U') IS NOT NULL
	ALTER TABLE Hotels.Rooms
	ADD CONSTRAINT FK__Rooms__roomType__4F47C5E3
	FOREIGN KEY (roomType)
	REFERENCES Hotels.RoomTypes (typesID);

IF OBJECT_ID('Hotels.Rooms', 'U') IS NOT NULL AND OBJECT_ID('Hotels.Hotel', 'U') IS NOT NULL
	ALTER TABLE Hotels.Rooms
	ADD CONSTRAINT FK__Rooms__hotelID__656C112C
	FOREIGN KEY (hotelID)
	REFERENCES Hotels.Hotel (hotelID);

IF OBJECT_ID('Hotels.Staff', 'U') IS NOT NULL AND OBJECT_ID('Hotels.Hotel', 'U') IS NOT NULL
	ALTER TABLE Hotels.Staff
	ADD CONSTRAINT FK__Staff__hotelID__7B264821
	FOREIGN KEY (hotelID)
	REFERENCES Hotels.Hotel (hotelID);

IF OBJECT_ID('Hotels.StaffLogin', 'U') IS NOT NULL AND OBJECT_ID('Hotels.Staff', 'U') IS NOT NULL
	ALTER TABLE Hotels.StaffLogin
	ADD CONSTRAINT FK__StaffLogi__staff__7FEAFD3E
	FOREIGN KEY (staffID)
	REFERENCES Hotels.Staff (staffID);

