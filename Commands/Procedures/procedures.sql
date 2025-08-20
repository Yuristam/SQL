/*
    STORED PROCEDURES

    🔷 Хранимая процедура – это объект базы данных, в котором заложен алгоритм в виде SQL
    инструкций.

    ❕ Это как функция в программировании, но чаще применяется для выполнения нескольких действий сразу: 
    выборка, вставка, обновление, удаление, логика с условиями и циклами.
*/
-------------------------------------------------------------------------------------------------
-- Создание процедуры

CREATE PROCEDURE TestProcedure
(
	@CategoryID INT,
	@ProductName NVARCHAR(100)
)
AS
BEGIN
	DECLARE @AVG_Price MONEY

    -- Определяем среднюю цену в категории
	SELECT @AVG_Price = ROUND(AVG(Price), 2)
	FROM Products
	WHERE CategoryID = @CategoryID

    -- Вставляем данные
	INSERT INTO Products(CategoryID, ProductName, Price)
		VALUES (@CategoryID, LTRIM(RTRIM(@ProductName)), @AVG_Price)

    -- Возвращаем данные
	SELECT * FROM Products
	WHERE CategoryID = @CategoryID
END


-------------------------------------
-- Вызов процедуры (использование)

EXEC TestProcedure @CategoryID = 8,
				   @ProductName = 'Test Product'


-- можно еще так (используя слово EXECUTE)
EXECUTE TestProcedure @CategoryID = 8,
				   @ProductName = 'Test Product'


-- можно еще так (не перечисляя названия параметров)
EXECUTE TestProcedure 7, 'Test Product 2'


-------------------------------------
-- еще один пример создания процедуры (увеличиваем цену продукта, если цена НЕ больше чем в 2 раза)

CREATE PROCEDURE UpdateProductPrice
(
	@ProductID INT,
	@NewPrice MONEY
)
AS
BEGIN
	DECLARE @OldPrice MONEY

	SELECT @OldPrice = Price
	FROM Products
	WHERE ProductID = @ProductID

	IF @NewPrice < (@OldPrice * 2)
	BEGIN 
		UPDATE Products SET Price = @NewPrice 
		WHERE ProductID = @ProductID
	END

	SELECT * FROM Products	
END


EXECUTE UpdateProductPrice 7, 7

-------------------------------------
-- Изменение процедуры

ALTER PROCEDURE TestProcedure
(
	@CategoryID INT,
	@ProductName NVARCHAR(100),
	@Price MONEY = NULL		-- необязательный параметр
)
AS
BEGIN
	-- Если Price is NULL, то устанавливаем цену, которая равна средней арифметической цене всех товаров этой категории
	IF @Price IS NULL
		SELECT @Price = ROUND(AVG(Price), 2)
		FROM Products
		WHERE CategoryID = @CategoryID

	-- добавляем новый продукт
	INSERT INTO Products (CategoryID, ProductName, Price)
		VALUES (@CategoryID, LTRIM(RTRIM(@ProductName)), @Price)

	-- возвращаем продукты по выбранной категории
	SELECT * FROM Products
	WHERE CategoryID = @CategoryID
END


-- Вызов

EXEC TestProcedure @CategoryID = 1,
				   @ProductName = 'New Test Product',
				   @Price = 100


------------------
-- еще один пример (все параметры могут принимать значение NULL)

ALTER PROCEDURE TestProcedure
(
	@CategoryID INT = NULL,
	@ProductName NVARCHAR(100) = NULL,
	@Price MONEY = NULL		-- необязательный параметр
)
AS
BEGIN
	IF @CategoryID IS NULL
		SET @CategoryID = 1

	IF @ProductName IS NULL
		SET @ProductName = N'Не задано'

	IF @Price IS NULL
		SELECT @Price = ROUND(AVG(Price), 2)
		FROM Products
		WHERE CategoryID = @CategoryID

	INSERT INTO Products (CategoryID, ProductName, Price)
		VALUES (@CategoryID, LTRIM(RTRIM(@ProductName)), @Price)

	SELECT * FROM Products
	WHERE CategoryID = @CategoryID
END


------------------
-- тот же код, что и сверху, только более улучшенный

ALTER PROCEDURE TestProcedure
(
    @CategoryID INT = NULL,
    @ProductName NVARCHAR(100) = NULL,
    @Price MONEY = NULL
)
AS
BEGIN
    -- Если категория не указана → подставляем 1
    SET @CategoryID = ISNULL(@CategoryID, 1);

    -- Если имя не указано → подставляем "Не задано"
    SET @ProductName = ISNULL(LTRIM(RTRIM(@ProductName)), N'Не задано');

    -- Если цена не указана → средняя по категории
    SET @Price = ISNULL(
                    @Price,
                    (SELECT ROUND(AVG(Price), 2) 
                     FROM Products 
                     WHERE CategoryID = @CategoryID)
                 );

    -- Добавляем новый продукт
    INSERT INTO Products (CategoryID, ProductName, Price)
    VALUES (@CategoryID, @ProductName, @Price);

    -- Возвращаем продукты по выбранной категории
    SELECT * FROM Products
    WHERE CategoryID = @CategoryID;
END;


-------------------------------------
-- Удаление процедуры

DROP PROCEDURE TestProcedure
