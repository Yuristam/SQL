/* 
    AGGREGATE FUNCTIONS:

    🔢 COUNT() – вычисляет количество значений в столбце (значения NULL не учитываются).
    ➕ SUM() – суммирует значения в столбце;
    🔠 MAX() – определяет максимальное значение в столбце;
    🔡 MIN() – определяет минимальное значение в столбце;
    🔤 AVG() – определяет среднее значение в столбце.
*/
------------------------------------------------------

-- MIN()
SELECT MIN(Price)
FROM Products;

------------------------
-- MAX()
SELECT MAX(Price)
FROM Products;

------------------------
-- COUNT(*) -- учитываются значения NULL только со (*)
SELECT COUNT(*)
FROM Products;

------------------------
-- COUNT() -- NULL не учитывается
SELECT COUNT(ProductName)
FROM Products;

------------------------
-- SUM()

SELECT SUM(Quantity)
FROM OrderDetails;

------------------------
-- AVG()

SELECT AVG(Price)
FROM Products;
