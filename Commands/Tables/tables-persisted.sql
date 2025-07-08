/*
    Вычисляемый столбец
*/

CREATE TABLE Products(
    ProductID INT IDENTITY(1, 1) NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Weight DECIMAL (18, 2) NULL,
    Price Money NULL,
    Amount AS (Weight * Price)                  -- Вычисляемый столбец
)

---------------------------------------------

CREATE TABLE Products(
    ProductID INT IDENTITY(1, 1) NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Weight DECIMAL (18, 2) NULL,
    Price Money NULL,
    Amount AS (Weight * Price) PERSISTED       -- PERSISTED означает, что данные хранятся физически (то есть в БД)
)
