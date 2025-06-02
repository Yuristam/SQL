CREATE TABLE Games (
    GameID INT IDENTITY(1, 1) PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL,
    GenreID INT NOT NULL,
    PublisherID INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_Games_Genres FOREIGN KEY (GenreID)
        REFERENCES Genres(GenreID),
    CONSTRAINT FK_Games_Publishers FOREIGN KEY (PublisherID)
        REFERENCES Publishers(PublisherID)
)
