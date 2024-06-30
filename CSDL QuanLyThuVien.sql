CREATE DATABASE CSDLQuanLyThuVien
GO

USE CSDLQuanLyThuVien
GO
--- Create table DocumentStatus---
CREATE TABLE DocumentStatus (
    StatusID INTEGER PRIMARY KEY,
    StatusName VARCHAR(20) NOT NULL,
    Description VARCHAR(100)
);
GO
--- Create table Documents---
CREATE TABLE Documents (
    DocumentID INTEGER PRIMARY KEY,
    Title VARCHAR(50) NOT NULL,
    Author VARCHAR(40) NOT NULL,
    PublicationYear INTEGER,
    DoCode VARCHAR(10),
    Location VARCHAR(100) NOT NULL,
    QuantityInStock INTEGER,
    DocumentType VARCHAR(30),
    Rate DECIMAL(3,2),
	StatusID INTEGER, 
    Description VARCHAR(100),
    FOREIGN KEY (StatusID) REFERENCES DocumentStatus (StatusID) 
);
GO
--- Create table Users---
CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    PhoneNumber VARCHAR(12) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    LibraryCardNumber VARCHAR(20),
    UserType VARCHAR(25)
);
GO
--- Create table LibraryCards---
CREATE TABLE LibraryCards (
    CardID INTEGER PRIMARY KEY,
    UserID INTEGER NOT NULL,
    ExpirationDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users (UserID)
);
GO
--- Create table Statistic---
CREATE TABLE Statistic (
    StatisticID INTEGER PRIMARY KEY,
    UserID INTEGER NOT NULL,
    StatisticType VARCHAR(50) NOT NULL,
    StatisticDate DATE NOT NULL,
    StatisticValue INTEGER,
    FOREIGN KEY (UserID) REFERENCES Users (UserID)
);
GO
--- Create table Reports---
CREATE TABLE Reports (
    ReportID INTEGER PRIMARY KEY,
    UserID INTEGER NOT NULL,
    ReportType VARCHAR(50) NOT NULL,
    ReportDate DATE NOT NULL,
    ReportContent VARCHAR(200),
    FOREIGN KEY (UserID) REFERENCES Users (UserID)
);
GO
--- Create table BookReviews---
CREATE TABLE BookReviews (
    ReviewID INTEGER PRIMARY KEY,
    DocumentID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,
    Rate DECIMAL(3,2),
    ReviewText VARCHAR(500),
    FOREIGN KEY (DocumentID) REFERENCES Documents (DocumentID),
    FOREIGN KEY (UserID) REFERENCES Users (UserID)
);
GO
--- Create table LoanHistory---
CREATE TABLE LoanHistory (
    HistoryID INTEGER PRIMARY KEY,
    DocumentID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,
    LoanDate DATE NOT NULL,
    ReturnDate DATE NOT NULL,
    LateFee DECIMAL(5,2),
    FOREIGN KEY (DocumentID) REFERENCES Documents (DocumentID),
    FOREIGN KEY (UserID) REFERENCES Users (UserID)
);
GO
--- Create table Reservations---
CREATE TABLE Reservations (
    ReservationID INTEGER PRIMARY KEY,
    DocumentID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,
    ReservationDate DATE NOT NULL,
    StatusReservations VARCHAR(30),
    FOREIGN KEY (DocumentID) REFERENCES Documents (DocumentID),
    FOREIGN KEY (UserID) REFERENCES Users (UserID)
);
GO
--- Create table Loans---
CREATE TABLE Loans (
    LoanID INTEGER PRIMARY KEY,
    DocumentID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    LateFee DECIMAL(5,2),
    FOREIGN KEY (DocumentID) REFERENCES Documents (DocumentID),
    FOREIGN KEY (UserID) REFERENCES Users (UserID)
);
GO

INSERT INTO DocumentStatus (StatusID, StatusName, Description)
VALUES
    ( 1, 'Available', 'The document is available for borrowing.'),
    ( 2 , 'Checked Out', 'The document is currently checked out.'),
    ( 3, 'Reserved', 'The document is reserved and not available.'),
    ( 4, 'Lost', 'The document has been reported lost.'),
    ( 5, 'Damaged', 'The document is damaged and unavailable.'),
    ( 6, 'On Hold', 'The document is on hold for a user.'),
    ( 7, 'In Processing', 'The document is being processed.'),
    ( 8, 'Archived', 'The document is archived and not available for circulation.'),
    ( 9, 'Pending Review', 'The document is pending review.'),
    ( 10, 'Unavailable', 'The document is temporarily unavailable.');

--- Select DocumentStatus---
SELECT * FROM DocumentStatus;


INSERT INTO Documents (DocumentID, Title, Author, PublicationYear, DoCode, Location, QuantityInStock, DocumentType, Rate, StatusID, Description)
VALUES
(1, 'Truyen Kieu', 'Nguyen Du', 1820, 'TK001', 'A1', 5, 'Novel', 4.5, 1, 'A classic Vietnamese poem'),
(2, 'Doan truong tan thanh', 'Nguyen Du', 1820, 'DTTT002', 'A2', 3, 'Novel', 4.7, 1, 'A classic Vietnamese novel'),
(3, 'To Tam', 'Hoang Ngoc Phach', 1917, 'TT003', 'B1', 2, 'Novel', 4.2, 6,'A classical Chinese-Vietnamese novel'),
(4, 'Nam Cao', 'Nam Cao', 1943, 'NC004', 'C1', 1, 'Novel', 4.8,  5, 'Collection of short stories'),
(5, 'So do', 'Vu Trong Phung', 1936, 'SD005', 'D1', 2, 'Novel', 4.5, 9, 'Satirical novel set in colonial Vietnam'),
(6, 'Giong to', 'Nguyen Tuan', 1940, 'GT006', 'E1', 1, 'Novel', 4.2, 4, 'Novel set in 1930s Hanoi' ),
(7, 'Chi Pheo', 'Nam Cao', 1941, 'CP007', 'F1', 3, 'Short story', 4.6, 3, 'Famous short story about a poor rickshaw driver'),
(8, 'Lao Hac', 'Nam Cao', 1942, 'LH008', 'G1', 2, 'Short story', 4.3, 6, 'Short story depicting rural poverty'),
(9, 'Vo nhat', 'Kim Lan', 1969, 'VN009', 'H1', 2, 'Novel', 3.9, 3, 'Tragic story of an abandoned woman'),
(10, 'Gia tu vu khi ', ' Hemingway', 1940, 'GTV010', 'I1', 1, 'Novel', 4.1, 2,'Anti-war novel'),
(11, 'One Hundred Years of Solitude', 'Gabriel Garcia Marquez', 1967, 'OHYOS011', 'J1', 5, 'Novel', 4.8,8, 'Magical realism novel from Colombia'),
(12, 'The Old Man and the Sea', 'Ernest Hemingway', 1952, 'TOMATS012', 'J2', 4, 'Novel', 4.5, 10 , 'Pulitzer Prize winning novella' ),
(13, 'The Diary of a Young Girl', 'Anne Frank', 1947, 'TDOAG013', 'J3', 3, 'Autobiography', 4.7, 5, 'The writings of Anne Frank during WWII'),
(14, 'The Little Prince', 'Antoine de Saint-Exupéry', 1943, 'TLP014', 'J4', 2, 'Novella', 4.6, 1, 'French classic novella' ),
(15, 'The Kite Runner', 'Khaled Hosseini', 2003, 'TKR015', 'J5', 2, 'Novel', 4.5,  4, 'Story of friendship set in Afghanistan'),
(16, 'Dumb Luck', 'Vu Trong Phung', 1936, 'DL016', 'K1', 1, 'Satire', 4.3,9,'Major satirical novel from Vietnam'  ),
(17, 'The Industry of Marrying Europeans', 'Vu Trong Phung', 1937, 'TIME017', 'K2', 3, 'Satire', 4.7, 8, 'Satirical short stories about Vietnamese society'),
(18, 'The Sorrow of War', 'Bao Ninh', 1991, 'TSOW018', 'K3', 2, 'Novel', 4.4,7, 'Famous Vietnam War novel' ),
(19, 'Ba chang linh ngu lam ', 'Nguyen Nhat Anh', 1991, 'BCLNL019', 'K4', 5, 'Children''s book', 4.2, 1, 'Popular children''s novel'),
(20, 'De Men phieu luu ky', 'To Hoai', 1941, 'DMPKL020', 'K5', 4, 'Children''s book', 4.3, 6, 'Classic Vietnamese children''s story'),
(21, 'To Kill a Mockingbird', 'Harper Lee', 1960, 'TKM021', 'L1', 6, 'Novel', 4.7, 3, 'Pulitzer Prize winning American classic'),
(22, '1984', 'George Orwell', 1949, '1984022', 'L2', 5, 'Dystopian novel', 4.6, 8, 'Dystopian classic set in future totalitarian state'),
(23, 'The Grapes of Wrath', 'John Steinbeck', 1939, 'TGOW023', 'L3', 4, 'Novel', 4.5,2, 'Great Depression era novel, Pulitzer Prize winner' ),
(24, 'The Catcher in the Rye', 'J.D. Salinger', 1951, 'TCITR025', 'M2', 6, 'Novel', 4.3, 9, 'Coming of age story of teenage angst'),
(25, 'The Chronicles of Narnia', 'C.S. Lewis', 1950, 'TCON026', 'N1', 8, 'Fantasy novel', 4.8, 6, 'Beloved children''s fantasy series');

--- Select Documents---
SELECT *FROM Documents;


INSERT INTO Users (UserID, FullName, Address, PhoneNumber, Email, LibraryCardNumber, UserType)
VALUES
(1, 'Nguyen Van A', '12 Nguyen Du, Ha Noi', '0987654321', 'nguyenA@example.com', '1234ABC', 'Regular Reader'),
(2, 'Tran Thi B', '34 Le Loi, TP HCM', '0912345678', 'tranB@example.com', '2345BCD', 'Regular Reader'),
(3, 'Le Van C', '56 Tran Hung Dao, Hue', '0989123456', 'leC@example.com', '3456CDE', 'Regular Reader'),
(4, 'Pham Thi D', '78 Ly Thuong Kiet, Da Nang', '0981987654', 'phamD@example.com', '4567DEF', 'Regular Reader'),
(5, 'Nguyen Minh E', '90 Tran Quoc Toan, Can Tho', '0982987654', 'nguyenE@example.com', '5678EFG', 'Regular Reader'),
(6, 'Hoang Van F', '34 Ly Thai To, Hai Phong', '0989219876', 'hoangF@example.com', '6789FGH', 'Library Staff'),
(7, 'Luu Thi G', '56 Tran Nhan Tong, Da Nang', '0986543219', 'luuG@example.com', '7891GHI', 'Library Staff'),
(8, 'Ngo Van H', '78 Nguyen Thi Minh Khai, Nha Trang', '0987123654', 'ngoH@example.com', '8912HIJ', 'Library Staff'),
(9, 'Vu Thi I', '90 Le Loi, Quy Nhon', '0983219876', 'vuI@example.com', '9123IJK', 'Library Staff'),
(10, 'Trinh Van J', '12 Tran Hung Dao, Binh Dương', '0988765432', 'trinhJ@example.com', '1234JKL', 'Library Staff'),
(11, 'Tran Van K','56 Nguyen Thai Hoc, Nha Trang','0981234567','tranK@example.com','1234KLM','Regular Reader'),
(12, 'Nguyen Thi L','78 Tran Hung Dao, Da Lat','0988765432','nguyenL@example.com','2345LMN','Regular Reader'),
(13, 'Le Thi M','90 Ly Thuong Kiet, Buon Ma Thuot','0986754321','leM@example.com','3456MNO','Library Staff'),
(14, 'Pham Van N','34 Nguyen Du, Vung Tau','0981234765','phamN@example.com','4567NOP','Library Staff'),
(15, 'Hoang Thi O','56 Hung Vuong, Phan Thiet','0981238576','hoangO@example.com','5678OPQ','Regular Reader'),
(16, 'Lam Thi P', '67 Cach Mang Thang 8, Can Tho', '0907654321', 'lamP@example.com', '1234PQR', 'Regular Reader'),
(17, 'Tran Van Q', '89 Nguyen Hue, Vinh Long', '0981234765', 'tranQ@example.com', '2345QRS', 'Library Staff'),
(18, 'Huynh Thi R', '12 Cong Hoa, Bien Hoa', '0988765432', 'huynhR@example.com', '1234RST', 'Regular Reader'),
(19, 'Ngo Van S', '34 Phan Đinh Phung, Thu Dau Mot', '0907654321', 'ngoS@example.com', '2345STU', 'Regular Reader'),
(20, 'Lê Thi T', '56 Ly Thuong Kiet, My Tho', '0985471236', 'leT@example.com', '1234TUV', 'Library Staff');

--- Select Users---
SELECT * FROM Users;


INSERT INTO LibraryCards (CardID, UserID, ExpirationDate)
VALUES
    (1, 1, '2024-12-31'),
    (2, 2, '2024-12-31'),
    (3, 3, '2024-12-31'),
    (4, 4, '2024-12-31'),
    (5, 5, '2024-12-31'),
    (6, 6, '2024-12-31'),
    (7, 7, '2024-12-31'),
    (8, 8, '2024-12-31'),
    (9, 9, '2024-12-31'),
    (10, 10, '2024-12-31'),
	(11, 11, '2025-12-31'),
	(12, 12, '2024-12-31'),
	(13, 13, '2024-12-31'),
	(14, 14, '2024-12-31'),
	(15, 15, '2024-12-31'),
	(16, 16, '2024-12-31'),
	(17, 17, '2024-12-31'),
	(18, 18, '2024-12-31'),
	(19, 19, '2024-12-31'),
	(20, 20, '2024-12-31');

--- Select LibraryCards---
SELECT * FROM LibraryCards;



INSERT INTO Statistic (StatisticID, UserID, StatisticType, StatisticDate, StatisticValue)
VALUES
(1, 9, 'Monthly loans', '2023-03-01', 35),
(2, 10, 'Yearly visitors', '2023-01-01', 2356),
(3, 6, 'Daily website hits', '2023-10-01', 452),
(4, 13, 'Daily visitors', '2023-10-02', 156),
(5, 14, 'Monthly checkouts', '2023-10-01', 127),
(6, 16, 'Daily website hits', '2023-10-03', 521),
(7, 17, 'Monthly renewals', '2023-10-01', 282),
(8, 19, 'Daily checkouts', '2023-10-05', 293),
(9, 20, 'Monthly renewals', '2023-11-01', 772),
(10, 11, 'Daily checkouts', '2023-09-22', 135),
(11, 15, 'Monthly loans', '2023-10-15', 235),
(12, 1, 'Yearly visitors', '2023-06-19', 335),
(13, 3, 'Monthly checkouts', '2023-04-01', 535),
(14, 5, 'Monthly loans', '2023-07-07', 15),
(15, 7, 'Daily website hits', '2023-09-30', 95),
(16, 18, 'Monthly renewals', '2023-02-08', 99),
(17, 12, 'Monthly checkouts', '2023-11-11', 12),
(18, 8, 'Monthly renewals', '2023-02-28', 22),
(19, 2, 'Daily visitors', '2023-01-01', 19),
(20, 4, 'Daily website hits', '2023-09-24', 06);

--- Select Statistic---
SELECT * FROM Statistic;



INSERT INTO Reports (ReportID, UserID, ReportType, ReportDate, ReportContent)
VALUES
(1, 6, 'Monthly', '2023-03-01', 'Checked documents and loans for February 2023'),
(2, 7, 'Annual', '2023-01-01', 'Yearly inventory completed for 2022'),
(3, 8, 'Incident', '2023-02-15', 'User reported missing book from shelf B2'),
(4, 14, 'Monthly', '2023-04-01', 'Monthly report for March 2023'),
(5, 15, 'Annual', '2023-01-01', 'Yearly report for 2022'),
(6, 17, 'Monthly', '2023-05-01', 'Monthly report for April 2023'),
(7, 18, 'Incident', '2023-04-15', 'Patron reported damaged book in section A3'),
(8, 20, 'Monthly', '2023-06-01', 'Monthly report for May 2023');

--- Select Reports---
SELECT * FROM Reports;


INSERT INTO BookReviews (ReviewID, DocumentID, UserID, Rate, ReviewText)
VALUES
(1, 1, 1, 5, 'An immortal classic of Vietnamese literature'),
(2, 2, 2, 4.5, 'A wonderful depiction of 18th century Vietnam'),
(3, 5, 3, 4, 'An insightful political satire'),
(4, 16, 11, 4, 'A profound satire of colonial Vietnam'),
(5, 20, 12, 5, 'A favorite children''s story in Vietnam'),
(6, 12, 13, 4, 'A moving classic about perseverance'),
(7, 21, 16, 5, 'A masterful portrayal of justice and prejudice'),
(8, 23, 17, 4.5, 'A powerful portrait of the effects of the Great Depression'),
(9, 24, 18, 5, 'A beautifully written life-changing book'),
(10, 25, 19, 3.5, 'Captures the rebellious spirit of disaffected youth'),
(11, 19, 20, 5, 'A magical fantasy world for children of all ages'),
(12, 22, 8, 4.8, 'Christie at her twisted and clever best');

--- Select BookReviews---
SELECT * FROM BookReviews;


INSERT INTO LoanHistory (HistoryID, UserID, DocumentID, LoanDate, ReturnDate, LateFee)
VALUES
(1, 1, 1, '2022-12-15', '2023-01-15', 0),
(2, 2, 2, '2022-11-05', '2022-12-05', 0),
(3, 3, 5, '2022-10-01', '2022-11-01', 2.5),
(4, 11, 6, '2022-10-15', '2022-11-15', 0),
(5, 12, 3, '2022-09-10', '2022-10-10', 1.5),
(6, 13, 7, '2022-08-20', '2022-09-20', 0),
(7, 16, 4, '2022-08-01', '2022-09-01', 0),
(8, 17, 9, '2022-07-15', '2022-08-15', 1),
(9, 18, 17, '2022-06-20', '2022-07-20', 0),
(10, 19, 8, '2022-05-10', '2022-06-10', 0.5),
(11, 20, 22, '2022-04-15', '2022-05-15', 0),
(12, 7, 10, '2022-03-20', '2022-04-20', 0.5);

--- Select LoanHistory---
SELECT * FROM LoanHistory;


INSERT INTO Reservations (ReservationID, DocumentID, UserID, ReservationDate, StatusReservations)
VALUES
(1, 3, 4, '2023-02-25', 'Pending'),
(2, 6, 5, '2023-03-10', 'Ready'),
(3, 14, 14, '2023-03-12', 'Pending'),
(4, 19, 15, '2023-03-20', 'Ready'),
(5, 22, 16, '2023-03-25', 'Pending'),
(6, 25, 18, '2023-04-10', 'Pending'),
(7, 23, 20, '2023-05-01', 'Pending');

--- Select Reservations---
SELECT * FROM Reservations;


INSERT INTO Loans (LoanID, DocumentID, UserID, LoanDate, DueDate, ReturnDate, LateFee)
VALUES
(1, 4, 1, '2023-02-15', '2023-03-15', '2023-03-18', 0),
(2, 6, 2, '2023-01-05', '2023-02-05', '2023-02-10', 1.5),
(3, 10, 3, '2023-03-01', '2023-04-01', NULL, NULL),
(4, 11, 11, '2023-02-01', '2023-03-01', NULL, NULL),
(5, 15, 12, '2023-02-15', '2023-03-15', NULL, NULL),
(6, 18, 13, '2023-03-05', '2023-04-05', NULL, NULL),
(7, 21, 16, '2023-03-15', '2023-04-15', NULL, NULL),
(8, 12, 17, '2023-03-20', '2023-04-20', NULL, NULL),
(9, 24, 18, '2023-04-01', '2023-05-01', NULL, NULL),
(10, 25, 19, '2023-04-05', '2023-05-05', NULL, NULL),
(11, 20, 20, '2023-04-20', '2023-05-20', NULL, NULL),
(12, 22, 10, '2023-04-25', '2023-05-25', NULL, NULL);

--- Select Loans---
SELECT * FROM Loans;

---Get all information of documents whose names start with 'The'---
SELECT * FROM Documents
WHERE Title LIKE 'The%';

---Count the number of documents by each category---
SELECT DocumentType, COUNT(*) AS NumOfDocs
FROM Documents
GROUP BY DocumentType;

---Get the 5 documents with the highest ratings---
SELECT TOP 5 * FROM Documents
ORDER BY Rate DESC;

---Get information for users whose emails end with @example.com and UserType is Library Staff---
SELECT * FROM Users
WHERE Email LIKE '%@example.com' AND UserType = 'Library Staff';

---Count the number of book borrowings by month---
SELECT DATEPART(month, LoanDate) AS Month, COUNT(*) AS TotalLoans
FROM LoanHistory
GROUP BY DATEPART(month, LoanDate);

---Get the documents on loan---
SELECT d.*
FROM Documents d
JOIN Loans l ON d.DocumentID = l.DocumentID
WHERE l.ReturnDate IS NULL;

---Get documents that haven't been reviewed yet---
SELECT * FROM Documents
WHERE DocumentID NOT IN (SELECT DocumentID FROM BookReviews);

---Get book borrowing registration information for March 2023---
SELECT * FROM Loans
WHERE LoanDate BETWEEN '2023-03-01' AND '2023-03-31';

---Get the 5 users who borrowed the most books---
SELECT TOP 5 u.UserID, u.FullName, COUNT(l.LoanID) AS TotalLoans
FROM Users u
JOIN Loans l ON u.UserID = l.UserID
GROUP BY u.UserID, u.FullName
ORDER BY TotalLoans DESC;

---Get a list of documents that are overdue---
SELECT d.*
FROM Documents d
JOIN Loans l ON d.DocumentID = l.DocumentID
WHERE l.DueDate < GETDATE() AND l.ReturnDate IS NULL;

---Get the top 3 document genres with the most books---
SELECT TOP 3 DocumentType, COUNT(*) AS NumOfDocs
FROM Documents
GROUP BY DocumentType
ORDER BY NumOfDocs DESC;

---Get documents with an average rating above 4.5---
SELECT *
FROM Documents
WHERE DocumentID IN (
SELECT DocumentID
FROM BookReviews
GROUP BY DocumentID
HAVING AVG(Rate) > 4.5
);

---Pick up materials that have been reserved but are not yet available for loan---
SELECT d.*
FROM Documents d
JOIN Reservations r ON d.DocumentID = r.DocumentID
WHERE r.StatusReservations = 'Pending';

---Get the top 5 users with the most book reservations---
SELECT TOP 5 u.UserID, u.FullName, COUNT(r.ReservationID) AS TotalReservations
FROM Users u
JOIN Reservations r ON u.UserID = r.UserID
GROUP BY u.UserID, u.FullName
ORDER BY TotalReservations DESC;

---Get the total number of daily website visits in October 2023---
SELECT SUM(StatisticValue) AS TotalHits
FROM Statistic
WHERE StatisticType = 'Daily website hits'
AND StatisticDate BETWEEN '2023-10-01' AND '2023-10-31';

---Get the total number of valid library card registrations---
SELECT COUNT(*) AS TotalActiveCards
FROM LibraryCards
WHERE GETDATE() < ExpirationDate;

---Take the 5 documents with the most reservations---
SELECT TOP 5 d.DocumentID, d.Title, COUNT(r.ReservationID) AS TotalReservations
FROM Documents d
JOIN Reservations r ON d.DocumentID = r.DocumentID
GROUP BY d.DocumentID, d.Title
ORDER BY TotalReservations DESC;

---Get statistics on the number of book borrowings by month in 2022---
SELECT DATENAME(month, LoanDate) AS [Month], COUNT(*) AS TotalLoans
FROM LoanHistory
WHERE LoanDate BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY DATENAME(month, LoanDate);


---Retrieve crash reports generated in Q1 2023---
SELECT *
FROM Reports
WHERE ReportType = 'Incident'
AND ReportDate BETWEEN '2023-01-01' AND '2023-03-31';

---Trigger to check the number of books in stock when a book is borrowed---
CREATE TRIGGER CheckBookQuantityOnLoan
ON Loans
AFTER INSERT, UPDATE
AS
BEGIN
IF (SELECT QuantityInStock
FROM Documents D JOIN inserted I
ON D.DocumentID = I.DocumentID) < 0
BEGIN
RAISERROR('Số lượng sách trong kho không đủ', 16, 1);
ROLLBACK TRANSACTION;
RETURN
END
END;


---Trigger to update document status when someone borrows it---
CREATE TRIGGER UpdateDocStatusOnLoan
ON Loans
AFTER INSERT, UPDATE
AS
BEGIN
UPDATE Documents
SET StatusID = 2
WHERE DocumentID IN (SELECT DocumentID FROM inserted)
UPDATE Documents
SET StatusID = 1
WHERE DocumentID IN (SELECT DocumentID FROM deleted)
END;


---Trigger to check the book return date cannot be earlier than the loan date---
CREATE TRIGGER CheckReturnDate
ON Loans
AFTER INSERT, UPDATE
AS
BEGIN
IF (SELECT ReturnDate FROM inserted) < (SELECT LoanDate FROM inserted)
BEGIN
RAISERROR('Ngày trả sách không hợp lệ', 16, 1);
ROLLBACK TRANSACTION;
RETURN
END
END;

---Trigger to automatically delete reservations when lending books---
CREATE TRIGGER DeleteReservationOnLoan
ON Loans
AFTER INSERT, UPDATE
AS
BEGIN
DELETE FROM Reservations
WHERE DocumentID IN (SELECT DocumentID FROM inserted) AND
UserID IN (SELECT UserID FROM inserted)
END;


---Trigger to check library card validity when borrowing books---
CREATE TRIGGER CheckCardExpiration
ON Loans
AFTER INSERT, UPDATE
AS
BEGIN
IF (SELECT ExpirationDate FROM LibraryCards LC
JOIN inserted I ON LC.UserID = I.UserID) < GETDATE()
BEGIN
RAISERROR('Thẻ thư viện đã hết hạn', 16, 1);
ROLLBACK TRANSACTION;
RETURN
END
END;


---Trigger to automatically update statistics on daily book borrowings---
CREATE TRIGGER UpdateDailyLoansStat
ON Loans
AFTER INSERT, UPDATE
AS
BEGIN
DECLARE @loans int;
SELECT @loans = COUNT(*) FROM inserted;
UPDATE Statistic
SET StatisticValue = StatisticValue + @loans
WHERE StatisticType = 'Daily checkouts' AND
StatisticDate = CAST(GETDATE() AS DATE);
IF @@ROWCOUNT = 0
INSERT INTO Statistic (UserID, StatisticType, StatisticDate, StatisticValue)
VALUES (1, 'Daily checkouts', CAST(GETDATE() AS DATE), @loans);
END;


---Trigger to check that the number of reservations does not exceed the number of books in stock---
CREATE TRIGGER LimitReservationQuantity
ON Reservations
INSTEAD OF INSERT
AS
BEGIN
IF (SELECT COUNT(*) FROM inserted) <=
(SELECT QuantityInStock FROM Documents WHERE DocumentID = (SELECT DocumentID FROM inserted))
BEGIN
INSERT INTO Reservations
SELECT * FROM inserted
END
ELSE
BEGIN
RAISERROR('Vượt quá số lượng cho phép đặt trước', 16, 1);
ROLLBACK TRANSACTION;
END
END;


---Trigger to prevent deletion of data already in the book borrowing history---
CREATE TRIGGER PreventDeleteHistory
ON LoanHistory
INSTEAD OF DELETE
AS
BEGIN
RAISERROR('Không thể xóa lịch sử mượn sách', 16, 1);
ROLLBACK TRANSACTION;
END;

---Trigger limits the rate value from 1.0 to 5.0---
CREATE TRIGGER LimitRateValue
ON BookReviews
INSTEAD OF INSERT, UPDATE
AS
BEGIN
IF EXISTS (SELECT 1 FROM inserted WHERE Rate < 1 OR Rate > 5)
BEGIN
RAISERROR('Giá trị Rate phải từ 1.0 đến 5.0', 16, 1);
ROLLBACK TRANSACTION;
RETURN
END
INSERT INTO BookReviews (DocumentID, UserID, Rate, ReviewText)
SELECT DocumentID, UserID, Rate, ReviewText
FROM inserted
WHERE Rate BETWEEN 1 AND 5
END;


--- Create a view that lists information about books whose current inventory quantity is greater than 0--
CREATE VIEW BooksInStock AS
SELECT
    DocumentID,
    Title,
    Author,
    QuantityInStock
FROM
    Documents
WHERE
    QuantityInStock > 0;

SELECT * FROM BooksInStock;


---Create a view of the list of overdue books---
CREATE VIEW OverdueBooks AS
SELECT
    LoanID,
    Title,
    DueDate
FROM
    Loans
JOIN
    Documents ON Loans.DocumentID = Documents.DocumentID
WHERE
    DueDate < GETDATE();

SELECT * FROM OverdueBooks;

---Create a list view of authors with the most books---
CREATE VIEW AuthorsWithMostBooks AS
SELECT
    Author,
    COUNT(*) AS NumberOfBooks
FROM
    Documents
GROUP BY
    Author;

SELECT * FROM AuthorsWithMostBooks;

---Create a function that calculates late fees based on the number of days late---
CREATE FUNCTION CalculateLateFee (@DueDate DATE, @ReturnDate DATE)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @LateFee DECIMAL(10, 2)
    SET @LateFee = DATEDIFF(DAY, @DueDate, @ReturnDate) * 1.50 
    RETURN @LateFee
END;

DECLARE @LateFee DECIMAL(10, 2)
SET @LateFee = dbo.CalculateLateFee('2023-06-19', '2023-09-24');

---Create a function to check if a book is available in stock---
CREATE FUNCTION IsBookAvailable (@DocumentID INT)
RETURNS BIT
AS
BEGIN
    DECLARE @Available BIT
    SET @Available = 0
    IF EXISTS (SELECT 1 FROM Documents WHERE DocumentID = @DocumentID AND QuantityInStock > 0)
        SET @Available = 1
    RETURN @Available
END;


---Create a procedure that retrieves the documents with the highest ratings---
CREATE PROCEDURE GetTopRatedDocuments
AS
BEGIN
    SELECT TOP 5 *
    FROM Documents
    ORDER BY Rate DESC;
END;

EXEC GetTopRatedDocuments;

--- Create a process to get a list of documents by category ---
CREATE PROCEDURE GetDocumentsByCategory
    @CategoryName NVARCHAR(255)
AS
BEGIN
    SELECT *
    FROM Documents
    WHERE DocumentType = @CategoryName;
END;

EXEC GetDocumentsByCategory 'Short story';




