CREATE TABLE Publishers (
    PublisherID INT IDENTITY(1, 1) PRIMARY KEY,
    PublisherName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL
)