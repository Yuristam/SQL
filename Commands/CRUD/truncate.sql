/*
    DELETE - удаляет часть данных (т.е. можно использовать условие WHERE).
    TRUNCATE - удаляет все данные в таблице (а также обнуляет счетчик ID)
*/

----------------------------
-- DELETE

SELECT * FROM TestTable

DELETE TestTable
WHERE ProductId > 3

SELECT * FROM TestTable

----------------------------
-- TRUNCATE

SELECT * FROM Drinks

TRUNCATE TABLE Drinks

SELECT * FROM Drinks
