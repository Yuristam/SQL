-- Простое изменение
UPDATE Games SET Title = 'Need for Speed: Most Wanted'
WHERE GameID = 3


-- Изменение с условием из другой таблицы
UPDATE g 
SET g.Title = 'Horizon: Zero Dawn',
	g.Price = 45.50
FROM Games g
	INNER JOIN Publishers p ON g.PublisherID = p.PublisherID
WHERE 
	p.PublisherID = 8 AND
	g.CountryID = 2
