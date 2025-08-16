/*
    GOTO
*/
-------------------------------------

DECLARE @i INT = 1;

StartLoop: -- устанавливаем метку

    SELECT N'Итерация: ', @i;
    SET @i += 1;

    IF @i <= 3
        GOTO StartLoop;

SELECT N'Конец цикла';

-------------------------------------

DECLARE @i INT = 1;

PRINT N'Начало';

IF @i = 1
    GOTO MyLabel;

PRINT N'Эта строка не выполнится';

MyLabel:
PRINT N'Перешли по GOTO';
