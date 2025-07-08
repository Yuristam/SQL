/*
    AS
    Alias - Псевдоним – это указание упрощѐнного (или сокращенного) названия столбца или самого источника данных.
*/

SELECT  Pr.ProductID AS ID,
        Pr.ProductName AS ProductName,
        Pr.Price AS [Цена]
FROM Products AS Pr
