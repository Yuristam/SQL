/*
    Scalar VS Table-Valued VS Multi-Statement TVF

    🟡 Scalar Function -> Возвращает одно значение (число, строку, дату и т.д.)
    🟨 например, цена по ID, возраст по дате рождения, количество заказов

    🟢 Табличная функция (Table-Valued Function, TVF)
    🟩 Если хочешь, чтобы результат можно было использовать как обычную таблицу.

    🔵 Многооператорная табличная функция (Multi-Statement TVF)
    🟦 Возвращает таблицу, но с переменными, условиями и циклами
*/

-----------------------------------------
-- 🟡 Scalar Function
CREATE FUNCTION dbo.GetDrinkPriceByName
(
    @DrinkName NVARCHAR(250)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @DrinkPrice DECIMAL(10,2);

    SELECT @DrinkPrice = Price
    FROM Drinks
    WHERE Name = @DrinkName;

    RETURN @DrinkPrice;
END

-- Вызов
SELECT dbo.GetDrinkPriceByName('Cola');


-----------------------------------------
-- 🟢 Табличная (inline TVF)
CREATE FUNCTION dbo.GetDrinkInfoByName
(
    @DrinkName NVARCHAR(250)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Id, Name, Price
    FROM Drinks
    WHERE Name = @DrinkName
);

-- Вызов
SELECT *
FROM dbo.GetDrinkInfoByName('Cola');


-----------------------------------------
-- 🔵 Многооператорная табличная
CREATE FUNCTION dbo.GetDrinksCheaperThan
(
    @MaxPrice DECIMAL(10,2)
)
RETURNS @Result TABLE
(
    Id INT,
    Name NVARCHAR(250),
    Price DECIMAL(10,2)
)
AS
BEGIN
    INSERT INTO @Result
    SELECT Id, Name, Price
    FROM Drinks
    WHERE Price < @MaxPrice;

    RETURN;
END

-- Вызов
SELECT * FROM dbo.GetDrinksCheaperThan(50);
