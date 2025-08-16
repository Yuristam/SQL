/*
    TRY...CATCH


    🔻
    BEGIN TRY

        (код в котором могут возникнуть ошибки)
    
    END TRY
    
    BEGIN CATCH
    
        (код в котором указываются инструкции, которые необходимо выполнить в случае появления ошибки.) 
    
    END CATCH
    🔺


    Системные Функции:
    🔹 ERROR_NUMBER()  - код ошибки
    🔸 ERROR_MESSAGE() - сообщение ошибки
*/
---------------------------------------------------------------

-- блок TRY 
BEGIN TRY
	DECLARE @Number1 INT = 10,
			@Number2 INT = 0,
			@Sum INT

	SET @Sum = @Number1 / @Number2;

END TRY
-- блок CATCH
BEGIN CATCH
	SELECT ERROR_NUMBER() AS [Номер ошибки],
		   ERROR_MESSAGE() AS [Сообщение ошибки]

	SET @Sum = 0    -- без этого в @Sum запишется NULL (по сути это и не нужно)
END CATCH

SELECT @Sum AS [Результат]
