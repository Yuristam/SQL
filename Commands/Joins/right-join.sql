/*
    RIGHT JOIN
*/

SELECT d.Name, d.Price, dc.CategoryName
FROM Drinks d
RIGHT JOIN DrinkCategories dc ON d.CategoryID = dc.CategoryID
