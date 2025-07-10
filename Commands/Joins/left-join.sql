/*
    LEFT JOIN
*/

SELECT d.Name, d.Price, dc.CategoryName
FROM Drinks d
LEFT JOIN DrinkCategories dc ON d.CategoryID = dc.CategoryID
