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