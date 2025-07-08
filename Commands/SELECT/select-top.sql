/*
    TOP - возвращает только первые N значений.
*/

-- TOP. первые 2 значения
SELECT TOP 2 ProductID, ProductName, Price
FROM Products

---------------------------------------------------------
-- TOP WITH TIES (возвращает также строки с одинаковыми значениями. Не работает без ORDER BY)
SELECT TOP 5 WITH TIES Name, Price
FROM Drinks
ORDER BY Price

---------------------------------------------------------
--TOP PERCENT (возвращает указанный процент данных)
SELECT TOP 20 PERCENT Name, Price
FROM Drinks
