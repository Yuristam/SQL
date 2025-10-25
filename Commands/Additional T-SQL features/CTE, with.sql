/*
    CTE - Common Table Expressions. Конструкция WITH.

    🔸 CTE - это временный результат запроса (по сути, именованный подзапрос), который можно использовать в пределах 
    одного SQL-запроса.


    ! множественные запросы разделяются запятой (,)


    🔹 Особенности CTE:
    ⌚ Действует только в рамках одного запроса                     =>  После ; — исчезает
    📋 Может ссылаться сам на себя                                  =>  Рекурсия
    🔁 Может использоваться несколько раз                           =>  Экономит дублирование кода
    🚫 Не создаёт временную таблицу	                                =>  Всё в памяти
    ⚠️ Нужно ставить ; перед WITH, если это не первый оператор      =>  Иначе SQL Server выдаст ошибку


    ! можно также использовать и для модификации данных (Update, Delete)

    ! также можно использовать и для РЕКУРСИИ, то есть иерархические структуры (например, дерево категорий, 
    сотрудники и их начальники, файлы и папки и т.д.)

*/
-----------------------------------------------------------------------------------------------------------------------

-- использование подзапроса
SELECT *
FROM (
	SELECT Name, Price, CategoryId
	FROM Drinks
	WHERE Price > 1000
	) AS ExpensiveDrinks
WHERE CategoryId = 2;


-- использование CTE (WITH)
WITH ExpensiveDrinkCTE AS (
	SELECT Name, Price, CategoryId
	FROM Drinks
	WHERE Price > 1000
)

SELECT *
FROM ExpensiveDrinkCTE
WHERE CategoryId = 2

----------------------------------
-- Множественные CTE

WITH EmployeesWithHighSalary AS (
	SELECT Id, Name, DepartmentId
	FROM Employees
	WHERE Salary > 3000
),
DepartmentsCTE AS (
	SELECT Id, Name AS DepartmentName
	FROM Departments
)

SELECT e.Name, d.DepartmentName
FROM EmployeesWithHighSalary e
JOIN DepartmentsCTE d ON e.DepartmentId = d.Id


----------------------------------------------------
-- Update

WITH TopEmployees AS (
    SELECT TOP 10 Id, Salary
    FROM Employees
    ORDER BY Salary DESC
)
UPDATE TopEmployees
SET Salary = Salary * 1.1;  -- повышение на 10%

-----------------------------------------------------
-- Delete

WITH OldOrders AS (
    SELECT *
    FROM Orders
    WHERE OrderDate < '2024-01-01'
)
DELETE FROM OldOrders;


-------------------------------------------------
-- Рекурсия (иерархическая структура) используется UNION ALL

-- 1. допустим есть таблица 
CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    ManagerId INT NULL  -- для уровня должен быть null
);


-- 2. добавляем данные
INSERT INTO Employees (Id, Name, ManagerId) VALUES
(1, 'Alice', NULL),   -- Директор (нет начальника)
(2, 'Bob', 1),        -- Подчинённый Alice
(3, 'Carol', 1),      -- Подчинённая Alice
(4, 'Dave', 2),       -- Подчинённый Bob
(5, 'Emma', 3);       -- Подчинённая Carol


-- 3. используем рекурсию
WITH EmployeeHierarchy AS (
    -- 1️⃣ Базовый уровень (директор, у него нет начальника)
    SELECT 
        Id, 
        Name, 
        ManagerId,
        0 AS Level  -- уровень иерархии
    FROM Employees
    WHERE ManagerId IS NULL

    UNION ALL

    -- 2️⃣ Рекурсивная часть (ищем подчинённых)
    SELECT 
        e.Id, 
        e.Name, 
        e.ManagerId,
        eh.Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerId = eh.Id
)
SELECT *
FROM EmployeeHierarchy
ORDER BY Level, Name;

/*
-- result 

Alice
├── Bob
│   └── Dave
└── Carol
    └── Emma
*/