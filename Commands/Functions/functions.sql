/*
    FUNCTION - это автоматизированный механизм получения определѐнной информации, иными словами, в функции 
    заложен некий алгоритм, с помощью которого вычисляется итоговое значение.


    🔶 Функции бывают:
    🔸 Пользовательские - созданные пользователем
    🔸 Системные - созданные разработчиками MSSQL


    🔷 Функции делятся на 2 типа:    
    🔹 Скалярные (Scalar) - возвращают одно значение.
    🔹 Табличные (Table-Valued) - возвращают целую таблицу.


    ❕ Важные моменты:
    1. В отличие от процедур, функции ОБЯЗАТЕЛЬНО возвращают результат.
    2. В функциях НЕЛЬЗЯ изменять данные (INSERT, UPDATE, DELETE запрещены), только вычисления и выборки.
    3. Можно использовать в SELECT, WHERE, JOIN.
    4. Функции можно создавать как с параметрами, так и без них.
*/
-------------------------------------------------------------------------------------
-- Скалярная функция с параметром

CREATE FUNCTION GetProductName
	(
		@ProductID INT	-- Объявление входящих параметров
	)
RETURNS VARCHAR(100)	-- Тип возвращаемого результата
AS
BEGIN
	DECLARE @ProductName VARCHAR(100);

	SELECT @ProductName = ProductName
	FROM Products
	WHERE ProductID = @ProductID

	RETURN @ProductName		-- Возвращение результата
END

-- ❕ Если значения есть в таблице возвращает [Наименование товара], если нет значения по ID, то возвращает NULL


---------------
-- Вызов скалярной функции (использование)

-- Получение наименования конкретного товара
SELECT dbo.GetProductName(3) AS [Наименование товара]
SELECT dbo.GetProductName('3') AS [Наименование товара]   -- так тоже работает 😁


-- Передача в функцию параметра в виде столбца
SELECT ProductID,
	   ProductName,
	   dbo.GetProductName(ProductID) AS [Наименование продукта]
FROM Products


-------------------------------------------------------
-- Табличная функция с параметром

CREATE FUNCTION FT_GetProductsByCategory
	(
		@CategoryID INT
	)
RETURNS TABLE
AS
RETURN (
	SELECT ProductID,
		   ProductName,
		   Price,
		   CategoryID
	FROM Products
	WHERE CategoryID = @CategoryId
)


---------------
-- Вызов табличной функции
SELECT * FROM dbo.FT_GetProductsByCategory(8)


-------------------------------------------------------
-- Многооператорная табличная функция

CREATE FUNCTION FT_GetProductsByCategoryCheaperThan
	(
		@CategoryID INT,
		@Price MONEY
	)
RETURNS @TMP_Table TABLE (ProductID INT,
						  ProductName NVARCHAR(100),
						  Price MONEY,
						  CategoryID INT
						  )
AS
BEGIN
	IF @Price < 0
		SET @Price = 0

	INSERT INTO @TMP_Table
		SELECT ProductID,
			   ProductName,
			   Price,
			   CategoryID
		FROM Products
		WHERE CategoryID = @CategoryID
			AND Price <= @Price
	RETURN
END

-- Вызов
SELECT * FROM FT_GetProductsByCategoryCheaperThan(8, 250)


-------------------------------------------------------
-- Скалярная функция без параметров

CREATE FUNCTION dbo.GetDrinksCount()
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;

    SELECT @Count = COUNT(*) 
    FROM Drinks;

    RETURN @Count;
END

-----------------
-- Вызов
SELECT dbo.GetDrinksCount()


-------------------------------------------------------
-- Табличная функция без параметров

CREATE FUNCTION dbo.GetAllDrinks()
RETURNS TABLE
AS
RETURN
(
    SELECT ID, Name, Price
    FROM Drinks
);

-----------------
-- Вызов
SELECT * FROM dbo.GetAllDrinks();


-------------------------------------------------------
-- Изменение функции

ALTER FUNCTION GetProductName 		-- (теперь он будет возвращать CategoryName, так что имя функции не совсем верно, но это так для примера)
	(	
		@ProductID INT
	)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @CategoryName NVARCHAR(100)

	SELECT @CategoryName = pc.CategoryName
	FROM Products p
	INNER JOIN ProductsCategory pc ON pc.CategoryId = p.CategoryId
	WHERE p.ProductID = @ProductID

	RETURN @CategoryName
END

-- Вызов
SELECT ProductID,
	   ProductName,
	   dbo.GetProductName(ProductID) AS [CategoryName]
FROM Products


-------------------------------------------------------
-- Удаление функции

DROP FUNCTION GetProductName
