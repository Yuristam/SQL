/*
    Group by
*/

SELECT AVG(Price) AS AveragePrice, CategoryID
FROM Products
GROUP BY CategoryID;

----------------------------------------------

SELECT CategoryId AS [Id категории],
COUNT(*) AS [Количество строк],
MAX(Price) AS [Максимальное значение в столбце Price],
MIN(Price) AS [Минимальное значение в столбце Price],
AVG(Price) AS [Среднее значение в столбце Price]
FROM Products
GROUP BY CategoryId