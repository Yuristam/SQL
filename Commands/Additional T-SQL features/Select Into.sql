/*
    SELECT INTO — это конструкция в SQL Server, которая позволяет создать новую таблицу и сразу заполнить её 
    результатом запроса. То есть, она делает сразу два шага в одном: 
        
    1.создаёт таблицу;
    2. вставляет в неё данные из SELECT


    Синтаксис:
    🔽
        SELECT [столбцы]
        INTO НоваяТаблица
        FROM СуществующаяТаблица
        WHERE [условие]
    🔼


    ! можно использовать для создания backup-ов.
*/
------------------------------------------------

-- Простой пример
SELECT Id, Name, Salary
INTO HighSalaryEmployees
FROM Employees
WHERE Salary > 50000;


-- Еще один пример
SELECT d.Name, d.Price, dc.CategoryName 
INTO FizzyDrinks 
FROM Drinks d
LEFT JOIN DrinkCategories dc ON dc.CategoryID = d.CategoryID
WHERE d.CategoryID = 1   -- Газированные напитки


-- Создание Бекапа
SELECT *
INTO EmployeesBackup
FROM Employees;
