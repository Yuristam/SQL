/* 
    Create table. One-to-one
    Person(one) - Passport(one)
*/

CREATE TABLE People (
    ID INT IDENTITY (1,1) PRIMARY KEY,
    FullName NVARCHAR(250) NOT NULL
)

CREATE TABLE Passports (
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    PassportNumber VARCHAR(20) UNIQUE NOT NULL,
    IssueDate DATE NOT NULL,
    ExpirationDate DATE NOT NULL,
    PersonID INT UNIQUE NOT NULL,                   -- UNIQUE key word is used for One-to-One

    FOREIGN KEY (PersonID) REFERENCES People(ID)
)