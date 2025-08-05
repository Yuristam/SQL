/*
    UNION - нужен для объединения нескольких SELECT-ов в один
    * должно быть одинаковое КОЛИЧЕСТВО столбцов.
    * ТИПЫ ДАННЫХ должны быть ОДИНАКОВЫМИ.
    * столбцы должны идти в одинаковом порядке

    по умолчанию DISTINCT (не возвращает одинаковые строки, а только один)
    * UNION ALL - возвращает все строки (две или несколько одинаковых тоже)
*/

----------------------------
--  with UNION (возвращается один запрос - один большой SELECT)

SELECT CustomerID, FirstName, LastName, Email
FROM Customers_USA

UNION

SELECT CustomerID, FirstName, LastName, Email
FROM Customers_Europe

----------------------------
-- without UNION (возвращается 2 запроса - 2 SELECT)

SELECT CustomerID, FirstName, LastName, Email
FROM Customers_USA

SELECT CustomerID, FirstName, LastName, Email
FROM Customers_Europe

----------------------------
-- UNION ALL (возваращает одинаковые строки тоже)
-- например, если есть Erwin Smith и в Customers_USA, и в Customers_Europe, вернёт обоих

SELECT CustomerID, FirstName, LastName, Email
FROM Customers_USA

UNION ALL

SELECT CustomerID, FirstName, LastName, Email
FROM Customers_Europe
