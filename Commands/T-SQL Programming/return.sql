/*
    RETURN - предназначена для безусловного выхода из пакета или блока инструкций. Все то, что будет идти после RETURN,
    выполняться не будет.
*/

DECLARE @PositiveInteger INT = 1

IF @PositiveInteger < 1
    RETURN

SELECT @PositiveInteger AS [Result]
