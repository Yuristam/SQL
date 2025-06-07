SELECT 
	Gm.Title, 
	Gm.Description, 
	Gm.Price, 
	Pb.PublisherName, 
	Gn.GenreName, 
	C.CountryName, 
	Pl.Name
FROM Games AS Gm
	INNER JOIN Publishers AS Pb	ON Pb.PublisherID = Gm.PublisherID
	INNER JOIN Genres AS Gn		ON Gn.GenreID = Gm.GenreID
	INNER JOIN Countries AS C		ON C.CountryID = Gm.CountryID
	INNER JOIN Platforms AS Pl	ON Pl.PlatformID = Gm.PlatformID
ORDER BY 
	Gm.Title