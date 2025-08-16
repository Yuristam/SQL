/* 
    Ограничение CHECK
*/

--------------------------------------------------
-- Проверка диапазона чисел

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Age INT CHECK (Age >= 18 AND Age <=65)
)

-- OK
INSERT INTO Employees VALUES (1, 30);

-- Ошибка
INSERT INTO Employees VALUES (2, 16);

---------------------------------------------------
-- Проверка на конкретный список значений

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    Status NVARCHAR(20) CHECK (Status IN ('New', 'Processing', 'Shipped'))
)

-- OK
INSERT INTO Orders VALUES (1, 'New');

-- Ошибка
INSERT INTO Orders VALUES (2, 'Canceled');

---------------------------------------------------
-- Проверка между столбцами в одной строке

CREATE TABLE Contracts (
    ContactID INT PRIMARY KEY,
    StartDate DATE,
    EndDate DATE,
    CHECK (EndDate > StartDate)
)

-- OK
INSERT INTO Contracts VALUES (1, '2025-01-01', '2025-12-31');

-- Ошибка
INSERT INTO Contracts VALUES (2, '2025-05-01', '2025-04-30');

---------------------------------------------------
-- Проверка с формулой

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Price DECIMAL(10,2),
    Discount DECIMAL(5,2),
    CHECK (Discount <= Price * 0.5)
)

-- OK
INSERT INTO Products VALUES (1, 100, 30);

-- Ошибка
INSERT INTO Products VALUES (2, 100, 60);