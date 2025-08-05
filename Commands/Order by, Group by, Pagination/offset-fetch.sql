/*
    OFFSET-FETCH - пропускает определенное кол-во строк, затем возвращает указанное кол-во строк (Пагинация)
    OFFSET - Указывает, сколько строк нужно пропустить
    FETCH - Указывает, сколько строк нужно извлечь после пропуска заданного количества строк
    * Работает только с ORDER BY
*/


-- Пропустить 1 строку
-------------------------
SELECT  ProductID,
        ProductName,
        Price
FROM Products
ORDER BY Price DESC
OFFSET 1 ROWS

-- Пропустить 5 строк, достать 5 следующих строк (Пагинация)
----------------------------
SELECT Name, Price
FROM Drinks
ORDER BY Price DESC
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY
