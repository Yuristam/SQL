/*
    Transactions


    🔸 Atomicity (Атомарность)
    Всё или ничего. Если одна операция в транзакции не удалась → откатываются все.
    🔸 Consistency (Согласованность)
    После транзакции база остаётся в правильном, согласованном состоянии.
    🔸 Isolation (Изоляция)
    Незавершённые транзакции не мешают друг другу (разные уровни изоляции).
    🔸 Durability (Надёжность)
    После фиксации (COMMIT) изменения сохраняются навсегда, даже при сбое сервера.


    Команды управления транзакциями:

    🔹 BEGIN TRANSACTION (или BEGIN TRAN) – команда
    служит для определения начала транзакции. В качестве параметра этой команде можно
    передать и название транзакции.
    🔹 COMMIT TRANSACTION (или COMMIT TRAN) – команда для успешного завершения транзакции.
    🔹 ROLLBACK TRANSACTION (или ROLLBACK TRAN) – команда для отмены всех изменений.
    🔹 SAVE TRANSACTION (или SAVE TRAN) – данная команда устанавливает промежуточную точку сохранения 
    внутри транзакции, к которой можно откатиться, в случае возникновения необходимости.
*/
-------------------------------------------------------------------

BEGIN TRY
-- Начало транзакции
BEGIN TRANSACTION

	-- Инструкция 1 (тут все отработает правильно)
	UPDATE Products SET CategoryID = 2
	WHERE ProductID = 1

	-- Инструкция 2 (тут произойдет ошибка, т.к. по условиям этой таблицы нельзя передавать NULL в CategoryID)
	UPDATE Products SET CategoryID = NULL
	WHERE ProductID = 2

	-- ... Другие инструкции
    
    -- Если все хорошо. Сохраняем все изменения
    COMMIT TRANSACTION

END TRY
BEGIN CATCH

	-- В случае непредвиденной ошибки
	-- Откат транзакции
	ROLLBACK TRANSACTION

	-- Выводим сообщение об ошибке
	SELECT ERROR_NUMBER() AS [Номер ошибки],
		   ERROR_MESSAGE() AS [Описание ошибки]

	-- Прекращаем выполнение инструкции
	RETURN
END CATCH


--------------------------------------------
-- еще один пример

BEGIN TRY
    BEGIN TRANSACTION;

        UPDATE Accounts
        SET Balance = Balance - 1000
        WHERE AccountID = 1;

        UPDATE Accounts
        SET Balance = Balance + 1000
        WHERE AccountID = 2;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    THROW; -- выбрасывает ошибку
END CATCH;

--------------------------------------------
-- вместо XACT_STATE() <> 0 можно так же использовать @@ERROR <> 0, @@TRANCOUNT > 0

BEGIN CATCH
    IF @@ERROR <> 0
        ROLLBACK TRANSACTION;

    THROW; -- выбрасывает ошибку
END CATCH;

------

BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;  

    THROW; -- выбрасывает ошибку
END CATCH;


----------------------------------------------
-- Best practice

BEGIN TRY
    BEGIN TRANSACTION;   -- начало транзакции

    -- === Твой код ===
    UPDATE Accounts
    SET Balance = Balance - 1000
    WHERE AccountID = 1;

    UPDATE Accounts
    SET Balance = Balance + 1000
    WHERE AccountID = 2;
    -- =================

    COMMIT TRANSACTION;  -- фиксируем изменения
END TRY
BEGIN CATCH
    -- если есть активная транзакция — откатываем
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;  

    -- пробрасываем ошибку наверх (коротко и без лишних переменных)
    THROW;
END CATCH;

-- ❕ Обычно используют THROW, а RAISERROR — только если нужно своё кастомное сообщение или особая логика.

------------------------------------------------------------------------
-- пример с SAVE TRANSACTION

/*
    🔑 Зачем это нужно?

    1. Ты начинаешь одну большую транзакцию.
    2. Внутри неё выполняешь несколько логических шагов.
    3. Если в каком-то шаге ошибка — можно откатиться не полностью, а только до savepoint’а.
*/

BEGIN TRANSACTION;

    -- Первый шаг: обновляем счёт клиента
    UPDATE Accounts
    SET Balance = Balance - 1000
    WHERE AccountID = 1;

    -- Сохраняем промежуточное состояние
    SAVE TRANSACTION Step1;

    -- Второй шаг: переводим на другой счёт
    BEGIN TRY
        UPDATE Accounts
        SET Balance = Balance + 1000
        WHERE AccountID = 999; -- представим, что такого ID нет
    END TRY
    BEGIN CATCH
        -- Ошибка — откатываемся только до Step1, а не весь транзакшн
        ROLLBACK TRANSACTION Step1;  
    END CATCH;

    -- Делаем еще что-то (транзакция всё ещё открыта)
    INSERT INTO Logs(Msg) 
    VALUES (N'Перевод выполнен частично');

COMMIT TRANSACTION;
