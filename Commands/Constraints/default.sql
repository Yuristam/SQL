/*
    Ограничение DEFAULT
*/

--------------------------------------------------------------
-- Значение по умолчанию для числа

CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    Age INT DEFAULT 18
)

-- Укажем возраст -> возраст 25
INSERT INTO Employees (ID, Age) VALUES (1, 25)

-- Не укажем возраст → автоматически подставится 18
INSERT INTO Employees (ID) VALUES (2)

--------------------------------------------------------------
-- Значение по умолчанию для строки

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Status NVARCHAR(20) DEFAULT 'Active'
);

-- Укажем статус явно
INSERT INTO Users VALUES (1, 'Alice', 'Blocked');

-- Не укажем статус → станет 'Active'
INSERT INTO Users (UserID, Name) VALUES (2, 'Bob');

--------------------------------------------------------------
-- Значение по умолчанию с функцией

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Не укажем дату → подставится текущая
INSERT INTO Orders (OrderID) VALUES (1);

-- Укажем дату явно
INSERT INTO Orders VALUES (2, '2025-08-16 12:00:00');

--------------------------------------------------------------
-- Комбинация DEFAULT + CHECK

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Price DECIMAL(10,2) DEFAULT 0 CHECK (Price >= 0),
    Stock INT DEFAULT 0 CHECK (Stock >= 0)
);

-- OK
INSERT INTO Products (ProductID) VALUES (1);

-- Ошибка, потому что CHECK не пропускает отрицательные
INSERT INTO Products VALUES (2, -100, 10);
