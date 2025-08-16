/*
    CASE...END

    🔸 Обязателен END → без него ошибка.
    🔸 ELSE не обязателен, если его нет → вернётся NULL.


    Синтаксис:
    CASE expression
        WHEN value1 THEN result1
        WHEN value2 THEN result2
        ...
        ELSE default_result
    END
*/

-------------------------------------------------
-- CASE...END

DECLARE @Season INT
DECLARE @Result NVARCHAR(20)

SET @Season = 2

SELECT @Result = CASE @Season WHEN 1 THEN 'Winter'
							  WHEN 2 THEN 'Spring'
							  WHEN 3 THEN 'Summer'
							  WHEN 4 THEN 'Autumn'
							  ELSE 'There is no such season'
				 END

SELECT @Result AS [Season]

-------------------------------------------------
-- Пример с таблицей

CREATE TABLE People (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50),
    Age INT,
    HasPassport BIT
);

INSERT INTO People (Name, Age, HasPassport) VALUES
(N'Армин', 25, 1),
(N'Микаса', 17, 0),
(N'Эрен', 19, 0);

SELECT 
    Name,
    Age,
    HasPassport,
    CASE 
        WHEN Age >= 18 AND HasPassport = 1 
            THEN N'Можно выдать визу'
        ELSE N'Не соответствует условиям'
    END AS Result
FROM People;

------

SELECT 
    Name,
    Age,
    CASE 
        WHEN Age < 7 OR Age > 65 
            THEN N'Льготный билет'
        ELSE N'Обычный билет'
    END AS TicketType
FROM People;
