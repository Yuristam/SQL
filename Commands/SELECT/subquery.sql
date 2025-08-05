/*
    Подзапрос или Subquery (aka nested query, inner query) - по сути SELECT внутри другого SELECT-а.

    !Важно: 
    1. в подзапросе НЕЛЬЗЯ использовать ORDER BY
    2. НЕЛЬЗЯ возвращать больше ОДНОГО столбца 
*/

-------------------------------------------------------------------------------
-- Пример с SELECT

SELECT CategoryName AS [category name],
	(SELECT COUNT(*)
	 FROM Drinks 
	 WHERE Drinks.CategoryID = DrinkCategories.CategoryID) AS [drinks count]
FROM DrinkCategories

-------------------------------------------------------------------------------
-- Пример с SELECT 

SELECT Name
FROM Employees
WHERE DepartmentID = (
    SELECT ID FROM Departments WHERE Name = 'Sales'
)

-------------------------------------------------------------------------------
-- Пример с DELETE

DELETE FROM Drinks 
WHERE CategoryID IN (SELECT CategoryID
					 FROM DrinkCategories
					 WHERE CategoryName = N'Газировка');

-------------------------------------------------------------------------------
-- Пример с UPDATE

UPDATE Drinks 
SET Price = 250 
WHERE CategoryID IN (
	SELECT CategoryID
	FROM DrinkCategories
	WHERE CategoryName IN (N'Газировка', N'Натуральный сок')
);
