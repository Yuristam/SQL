/*
    Views - виртуальные таблицы, они не хранят данные, а просто сохраняют запросы. Это по сути СОХРАНЕННЫЙ SELECT запрос.
    Бывают Системные и пользовательские View.

    !Важно:
    1. нельзя использовать ORDER BY, его можно использовать при обращении к VIEW или с использованием оператора TOP 
*/

---------------------------
-- Создание View

CREATE VIEW FantasyBooks
AS 
	SELECT b.BookName, b.Price, b.Genre
	FROM Books b
	WHERE Genre = 'Fantasy'

---------------------------
-- Использование сортировки с оператором TOP

CREATE VIEW Top5Drinks AS
SELECT TOP 5 Name, Price
FROM Drinks
ORDER BY Price;

---------------------------
-- Получение данных из View

SELECT * FROM FantasyBooks

---------------------------
-- Изменение View

ALTER VIEW FantasyBooks
AS 
	SELECT b.BookID, b.BookName, b.Price, b.Genre
	FROM Books b
	WHERE Genre = 'Fantasy'

---------------------------
-- Удаление View

DROP VIEW FantasyBooks
