/*
    # - temporary tables
    Временные таблицы - это таблицы, которые автоматически удаляются после определенного периода времени.
    1. При завершении сессии (соединения)
    2. При завершении хранимой процедуры/функции (MSSQL)
    3. Явное удаление (DROP TABLE)
*/

-- Create temp table
CREATE TABLE #TempProducts(
    ID INT IDENTITY(1, 1) NOT NULL,
    ProductName VARCHAR(250) NOT NULL,
    Price Money NOT NULL
)

-- Delete temp table
DROP TABLE #TempProducts