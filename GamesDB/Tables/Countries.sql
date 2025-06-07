CREATE TABLE Countries (
    CountryID INT IDENTITY(1,1) PRIMARY KEY,
    CountryName NVARCHAR(250) NOT NULL
)

ALTER TABLE Countries 
    ADD CONSTRAINT UQ_Country_Name UNIQUE (CountryName) 