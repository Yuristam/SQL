/*
    Create table. Many-to-many
    Developers(many) - Projects(many)
*/

CREATE TABLE Developers(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    FullName NVARCHAR(250) NOT NULL
)

CREATE TABLE Projects (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(500) NOT NULL
)

-- Without constraint names
CREATE TABLE DeveloperProjects(
    DeveloperID INT NOT NULL,
    ProjectID INT NOT NULL,
    PRIMARY KEY (DeveloperID, ProjectID),
    FOREIGN KEY (DeveloperID) REFERENCES Developers(ID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ID)
)

---------------------------------------------------

-- With constraint names
CREATE TABLE DeveloperProjects(
    DeveloperID INT NOT NULL,
    ProjectID INT NOT NULL,
    CONSTRAINT PK_Developer_Projects PRIMARY KEY (DeveloperID, ProjectID),
    CONSTRAINT FK_DeveloperProjects_Developers FOREIGN KEY (DeveloperID) REFERENCES Developers(ID),
    CONSTRAINT FK_DeveloperProjects_Projects FOREIGN KEY (ProjectID) REFERENCES Projects(ID)
)
