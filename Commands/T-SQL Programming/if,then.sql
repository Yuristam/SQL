/*
    IF...ELSE
    IF...THEN
*/

----------------------------------------------
-- IF...ELSE

DECLARE @Score INT = 75;
DECLARE @Message NVARCHAR(100)

SET @Score = 95

IF @Score >= 90
    SET @Message = N'Отлично';
ELSE IF @Score >= 70
    SET @Message = N'Хорошо';
ELSE
    SET @Message = N'Нужно подтянуться';

-------------------

DECLARE @Role NVARCHAR(20) = 'Admin';

IF @Role = 'Admin'
    SELECT N'Добро пожаловать, администратор';
ELSE
    SELECT N'Доступ ограничен';


----------------------------------------------
-- IF (без ELSE)

DECLARE @Age INT 
DECLARE @Result NVARCHAR(100)

SET @Age = 0

IF @Age >= 18
	SET @Result = N'Совершеннолетний'

SELECT @Result AS [Результат]

-- Результат: NULL

----------------------------------------------
-- AND

DECLARE @Age INT = 25;
DECLARE @HasPassport BIT = 1;
DECLARE @Message NVARCHAR(100);

IF @Age >= 18 AND @HasPassport = 1
    SET @Message = N'Можно выдать визу';
ELSE
    SET @Message = N'Не соответствует условиям';

----------------------------------------------
-- OR

DECLARE @Day NVARCHAR(10) = 'Saturday';
DECLARE @Message NVARCHAR(100)

IF @Day = 'Saturday' OR @Day = 'Sunday'
    SET @Message = N'Выходной';
ELSE
    SET @Message = N'Рабочий день';

----------------------------------------------
-- AND + OR

DECLARE @Age INT = 17;
DECLARE @HasParentalPermission BIT = 1;
DECLARE @Message NVARCHAR(100)

IF (@Age >= 18) OR (@Age < 18 AND @HasParentalPermission = 1)
    SET @Message = N'Можно участвовать';
ELSE
    SET @Message = N'Доступ запрещен';

----------------------------------------------
-- IF EXISTS

DECLARE @Output NVARCHAR(100)

IF EXISTS (SELECT * FROM Products)
    SET @Output = N'Записи есть';
ELSE 
    SET @Output = N'Записей нет';

SELECT @Output AS [Наличие записей]
