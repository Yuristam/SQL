/* 
    Create table. Many-to-one 
    Company(one) - Employee(many)
    Position(one) - Employee(many)
    Company(one) - Position(many)
*/

CREATE TABLE Companies (
    ID INT IDENTITY(1, 1) PRIMARY KEY,                                                      -- PK without name
    Name NVARCHAR(100) NOT NULL
)

CREATE TABLE Positions (
    ID INT IDENTITY(1, 1) PRIMARY KEY,                                                      -- PK without name
    Title NVARCHAR(250) NOT NULL,
    CompanyID INT NOT NULL,

    FOREIGN KEY (CompanyID) REFERENCES Companies(ID)                                        -- constraint WITHOUT name
)

CREATE TABLE Employees (
    ID INT IDENTITY(1, 1),
    FullName NVARCHAR(250) NOT NULL,
    Age TINYINT NOT NULL,
    Salary Money NULL,
    CompanyID INT NULL,
    PositionID INT NULL,

	CONSTRAINT PK_Employees PRIMARY KEY(ID),                                                -- PK WITH name
    FOREIGN KEY (PositionID) REFERENCES Positions(ID),                                      -- constraint WITHOUT name
    CONSTRAINT FK_Employees_Companies FOREIGN KEY (CompanyID) REFERENCES Companies(ID)      -- constraint WITH name
)
