/* 
    Add data. INSERT INTO
*/

-- Insert one (краткая запись)
INSERT INTO Companies
VALUES ('Apple')

-- Insert many
INSERT INTO Companies
VALUES ('Microsoft'), ('Google'), ('Meta')

-- Insert (полная запись)
INSERT INTO Employees (FullName, Age, Salary, CompanyID, PositionID)
VALUES 
    ('John Berry', 26, 55000, 2, NULL),
    ('Jane Apricot', 33, 35000, 1, 2),
    ('Sam Lemon', 25, 44000, 1, 1)


-----------------------------------------------

-- Insert (SELECT * FROM)
INSERT INTO Positions (Title, CompanyID)
    SELECT Title, CompanyID
    FROM Positions
    WHERE ID > 5