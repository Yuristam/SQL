CREATE TABLE Publishers (
    PublisherID INT IDENTITY(1, 1) PRIMARY KEY,
    PublisherName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL
)

ALTER TABLE Publishers 
    ADD CountryID INT NOT NULL

ALTER TABLE Publishers 
	ADD CONSTRAINT UQ_Publisher_Name UNIQUE (PublisherName)

ALTER TABLE Publishers 
	ADD CONSTRAINT FK_Publishers_Countries FOREIGN KEY (CountryID) 
	REFERENCES Countries (CountryID)
