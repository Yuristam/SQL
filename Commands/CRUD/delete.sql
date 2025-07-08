-- Простое удаление
DELETE FROM Games
WHERE GameID = 1


-- Удаление с условием из другой таблицы (удалить игры от издателя)
DELETE g
FROM Games g
	INNER JOIN Publishers p ON g.PublisherID = p.PublisherID
WHERE 
	p.PublisherName = 'Capcom' AND
	g.Price < 16
