/*
    BEGIN...END - конструкция, которая нужна для объединения нескольких команд или инструкций.

    📌 Главное правило:
    🔹 Если внутри IF/WHILE/TRY только одна строка, BEGIN ... END можно не писать.
    🔹 Но если строк больше одной → блок обязателен.
*/

-----------------------------------

DECLARE @Age INT = 10;

IF @Age >= 18
BEGIN
    PRINT N'Совершеннолетний';
    PRINT N'Можно голосовать';
END
ELSE
BEGIN
    PRINT N'Несовершеннолетний';
    PRINT N'Нельзя голосовать';
END

-----------------------------------

DECLARE @Room NVARCHAR(50)
DECLARE @Action1 NVARCHAR(100), @Action2 NVARCHAR(100), @Action3 NVARCHAR(100), @Action4 NVARCHAR(100)

SET @Room = N'Кухня'
	
IF @Room IN (N'Кухня')
BEGIN
	SET @Action1 = N'Открыть холодильник'
	SET @Action2 = N'Взять молоко'
	SET @Action3 = N'Закрыть холодильник'
	SET @Action4 = N'Поставить молоко на стол'

END
SELECT @Action1 AS [Действие 1],
	   @Action2 AS [Действие 2], 
	   @Action3 AS [Действие 3], 
	   @Action4 AS [Действие 4]