/* 
    Зачем нужны Views если есть Table-Valued Functions ?

    🔹 VIEW
    Не принимает параметры. Это просто "сохранённый SELECT".

    🔸 ФУНКЦИЯ (TVF)
    Может принимать параметры → делает её гибкой.

    📌 Использование:
    🔹 VIEW хорошо использовать для репортинга, BI, "виртуальных таблиц".
    🔸 ФУНКЦИЯ чаще для бизнес-логики и переиспользуемых фильтров.
*/
------------------------------------------------------------------------

-- VIEW: всегда один и тот же результат
CREATE VIEW vwAdults AS
SELECT Name, Age FROM People WHERE Age >= 18;

SELECT * FROM vwAdults; -- всегда одинаково

-------------------------------------------------------

-- FUNCTION: можно передавать параметр
CREATE FUNCTION dbo.GetAdultsByAge(@MinAge INT)
RETURNS TABLE
AS
RETURN
    SELECT Name, Age FROM People WHERE Age >= @MinAge;

SELECT * FROM dbo.GetAdultsByAge(21); -- можно менять условие
