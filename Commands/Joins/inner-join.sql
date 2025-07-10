/*
    INNER JOIN
*/

SELECT d.Name, d.Price, dc.CategoryName
FROM Drinks d
INNER JOIN DrinkCategories dc ON d.CategoryID = dc.CategoryID

----------------------------------------

SELECT  p.ProductName,
        c.CategoryName,
        p.Price
FROM Products p
INNER JOIN Categories c ON p.CategoryId = c.CategoryId
ORDER BY p.CategoryId
