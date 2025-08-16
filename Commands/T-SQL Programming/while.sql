/*
    WHILE
    🔸 В SQL существует только один тип цикла - WHILE с предусловием.
    🔹 BREAK - Для того чтобы принудительно выйти из цикла в T-SQL
    🔹 CONTINUE - Для того чтобы пропустить итерацию
*/
-----------------------------------------------------------------------------
-- WHILE

DECLARE @i INT = 1;

WHILE @i <= 5
BEGIN
    PRINT N'Итерация №';
	PRINT @i;
    SET @i = @i + 1;
END

--------

DECLARE @CountAll INT = 0

WHILE @CountAll < 10
BEGIN

    SET @CountAll = @CountAll + 1

END

SELECT @CountAll AS [Результат]

-- результат: 10

----------------------------------
-- BREAK

DECLARE @CountAll INT = 0

WHILE @CountAll < 10
BEGIN

    SET @CountAll += 1

	IF @CountAll = 5
		BREAK
END

SELECT @CountAll AS [Результат]

-- Результат: 5

----------------------------------
-- CONTINUE

DECLARE @CountAll INT = 0
DECLARE @Cnt INT = 0

WHILE @CountAll < 10
BEGIN

    SET @CountAll = @CountAll + 1

	IF @CountAll = 5
		CONTINUE
	
	SET @Cnt += 1
END

SELECT @CountAll AS [CountAll],
		@Cnt AS [Cnt]

-- Результат: CountAll = 10, Cnt = 9
