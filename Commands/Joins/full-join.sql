/*
    FULL JOIN
*/

SELECT d.Name, d.Price, dc.CategoryName
FROM Drinks d
FULL JOIN DrinkCategories dc ON d.CategoryID = dc.CategoryID
