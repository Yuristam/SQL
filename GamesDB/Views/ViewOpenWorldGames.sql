CREATE VIEW ViewOpenWorldGames
AS 
	SELECT Title AS Game
	FROM Games Gm
		JOIN Genres Gn ON Gn.GenreID = Gm.GenreID
	WHERE Gn.GenreName = 'Open World'

GO

SELECT *
FROM ViewOpenWorldGames


GO


-- Изменение представления
ALTER VIEW ViewOpenWorldGames
AS 
	SELECT Title AS Game, Price
	FROM Games Gm
		JOIN Genres Gn ON Gn.GenreID = Gm.GenreID
	WHERE Gn.GenreName = 'Open World'


GO


-- Удаление
DROP VIEW ViewOpenWorldGames