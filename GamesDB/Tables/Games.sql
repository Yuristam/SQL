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

ALTER TABLE Games ADD CountryID INT NULL
ALTER TABLE Games ADD PlatformID INT NULL
ALTER TABLE Games ALTER COLUMN CountryID INT NOT NULL
ALTER TABLE Games ALTER COLUMN PlatformID INT NOT NULL

ALTER TABLE Games 
    ADD CONSTRAINT FK_Games_Countries FOREIGN KEY (CountryID) 
    REFERENCES Countries(CountryID)
ALTER TABLE Games 
    ADD CONSTRAINT FK_Games_Platforms FOREIGN KEY (PlatformID) 
    REFERENCES Platforms(PlatformID)
