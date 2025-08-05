/* 
    ORDER BY - сортировка
*/

--ORDER BY
------------------------
SELECT  ProductID,
        ProductName,
        Price
FROM Products
ORDER BY Price

--ORDER BY ... DESC
------------------------
SELECT  ProductID,
        ProductName,
        Price
FROM Products
ORDER BY Price DESC
 
--ORDER BY (more than 1 parameter)
------------------------
SELECT  ProductID,
        ProductName,
        Price
FROM Products
ORDER BY Price DESC, ProductName


SELECT  ProductID,
        ProductName,
        Price
FROM Products
ORDER BY 3 DESC, 2     -- по порядковому номеру столбцов
