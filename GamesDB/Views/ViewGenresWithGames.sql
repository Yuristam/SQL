CREATE VIEW ViewGenresWithGames
AS
	SELECT Gn.GenreName AS Genre,
		(SELECT COUNT(*)
		 FROM Games
		 WHERE GenreID = Gn.GenreID) AS [Count Games]
	FROM Genres Gn

GO

SELECT *
FROM ViewGameWithGenres