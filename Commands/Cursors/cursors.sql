/*
    Курсоры - это объект в SQL Server, который позволяет построчно обрабатывать данные из результата запроса.
    
    🔻
    DECLARE — объявляем курсор и указываем, какой SELECT будет источником данных.
    OPEN — открываем курсор (SQL начинает формировать набор данных).
    FETCH NEXT — достаём строку (курсор двигается по результату).
    WHILE @@FETCH_STATUS = 0 — пока строки есть, выполняем логику.
    CLOSE — закрываем курсор.
    DEALLOCATE — освобождаем память.
    🔺

    🔶 Команда FETCH позволяет перемещаться по курсору, передвигая тем самым указатель по строкам в курсоре:
    🔹 NEXT - перемещает указатель на следующую строку
    🔹 PRIOR - перемещает указатель на предыдущую строку
    🔹 FIRST - на первую строку 
    🔹 LAST - на последнюю строку
    ❕ только для этого нужно указать параметр SCROLL, во время объявления курсора (CURSOR SCROLL FOR).


    ❌ Минусы
    🔸 Медленные (построчная обработка всегда хуже пакетной).
    🔸 Жрут память и ресурсы.
    🔸 Их обычно заменяют на JOIN, CTE, MERGE, UPDATE...FROM.
*/
-----------------------------------------------------------------------

-- 1. Объявление переменных
DECLARE @ProductID INT,
		@ProductName NVARCHAR(100),
		@Price MONEY

-- 2. Объявление курсора
DECLARE TestCursor CURSOR FOR
	SELECT ProductID, ProductName, Price
	FROM Products
	WHERE CategoryID = 1

-- 3. Открываем курсор
OPEN TestCursor

-- 4. Считываем данные из первой строки в курсоре
-- и записываем их в переменные
FETCH NEXT FROM TestCursor INTO @ProductID, @ProductName, @Price

-- Запускаем цикл, выйдем из него, когда закончатся строки в курсоре
WHILE @@FETCH_STATUS = 0
BEGIN
    -- На каждую итерацию цикла выполняем необходимые нам SQL инструкции
    -- Для примера изменяем цену по условию
	IF @Price < 100
		UPDATE Products SET Price = Price + 10
		WHERE ProductID = @ProductID

    -- Считываем следующую строку курсора
	FETCH NEXT FROM TestCursor INTO @ProductID, @ProductName, @Price
END

-- 5. Закрываем курсор
CLOSE TestCursor

-- Освобождаем ресурсы
DEALLOCATE TestCursor


-----------------------------------------------------
-- Пример с SCROLL (PRIOR, FIRST, LAST)

INSERT INTO People (Name)
VALUES (N'Иван'), (N'Анна'), (N'Пётр'), (N'Ольга');

-- Используем курсор
DECLARE @ID INT, @Name NVARCHAR(50);

DECLARE PeopleCursor CURSOR SCROLL FOR
    SELECT ID, Name FROM People ORDER BY ID;

OPEN PeopleCursor;

-- Первая строка
FETCH FIRST FROM PeopleCursor INTO @ID, @Name;
PRINT 'FIRST: ' + CAST(@ID AS NVARCHAR) + ' - ' + @Name;

-- Последняя строка
FETCH LAST FROM PeopleCursor INTO @ID, @Name;
PRINT 'LAST: ' + CAST(@ID AS NVARCHAR) + ' - ' + @Name;

-- Предыдущая строка (относительно текущей — LAST)
FETCH PRIOR FROM PeopleCursor INTO @ID, @Name;
PRINT 'PRIOR (перед последним): ' + CAST(@ID AS NVARCHAR) + ' - ' + @Name;

-- Следующая строка (относительно текущей)
FETCH NEXT FROM PeopleCursor INTO @ID, @Name;
PRINT 'NEXT: ' + CAST(@ID AS NVARCHAR) + ' - ' + @Name;

CLOSE PeopleCursor;
DEALLOCATE PeopleCursor;

---------
/*
    OUTPUT:

    FIRST → Иван
    LAST → Ольга
    PRIOR → Пётр (строка перед Ольгой)
    NEXT → снова Ольга (т.к. мы вернулись вперёд)
*/