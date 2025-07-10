/*
    CROSS JOIN
*/

SELECT 
	d.Name AS Drink, 
	d.Price AS [Drink Price],
	s.Name AS Snack, 
	s.Price AS [Snack Price]
FROM Drinks d
CROSS JOIN Snacks s
