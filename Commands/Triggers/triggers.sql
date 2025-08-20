/*
    Trigger - это объект БД, который срабатывает АВТОМАТИЧЕСКИ, при наступлении определённого 
    события в таблице или представлении.

    🔹 События: INSERT, UPDATE, DELETE, иногда INSTEAD OF (вместо операции).


    🔶 Виды триггеров:

    🔸 AFTER (или FOR)
    Выполняется после операции INSERT/UPDATE/DELETE.
    Например: после вставки записи — логируем её в историю.
    
    ❕ FOR и AFTER - по сути, одно и тоже, т.е. можно использовать и то, и то.


    🔸 INSTEAD OF
    Выполняется вместо операции.
    Полезно для VIEW (где прямые изменения невозможны).


    🔷 Внутри триггера доступны специальные таблицы:

    🔹 inserted — хранит новые строки (после INSERT или UPDATE).
    🔹 deleted — хранит старые строки (после DELETE или UPDATE).

    ❕ Данные таблицы автоматически создаются SQL сервером, и мы к ним можем обращаться в триггере.


*/
-----------------------------------------------------------------------------------------------------
-- Создание Таблицы для Аудита Products

CREATE TABLE AuditProducts
(
	ID INT IDENTITY(1,1) NOT NULL,
	DtChange DATETIME NOT NULL,
	UserName VARCHAR(100) NOT NULL,
	SQL_Command NVARCHAR(100) NOT NULL,
	ProductID_Old INT NULL,
	ProductID_New INT NULL,
	CategoryID_Old INT NULL,
	CategoryID_New INT NULL,
	ProductName_Old NVARCHAR(100) NULL,
	ProductName_New NVARCHAR(100) NULL,
	Price_Old MONEY NULL,
	Price_New MONEY NULL,

	CONSTRAINT PK_AuditProducts PRIMARY KEY (ID)
)

-------------------------------------------------
-- Создание триггера для таблицы Products

CREATE TRIGGER TRG_Audit_Products ON Products
	AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @SQL_Command NVARCHAR(100)

	/*
	Определяем, что это за операция
	на основе наличия записей в таблицах inserted и deleted.
	*/
	IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
		SET @SQL_Command = 'INSERT'

	IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
		SET @SQL_Command = 'UPDATE'

	IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
		SET @SQL_Command = 'DELETE'

    -- Инструкция если происходит добавление или обновление записи
	IF @SQL_Command = 'UPDATE' OR @SQL_Command = 'INSERT'
	BEGIN 
		INSERT INTO AuditProducts(DtChange, UserName, SQL_Command, ProductID_Old, 
								  ProductId_New, CategoryId_Old, CategoryId_New,
								  ProductName_Old, ProductName_New, Price_Old, Price_New)
		SELECT GETDATE(), SUSER_SNAME(), @SQL_Command, D.ProductId, I.ProductId,
			   D.CategoryId, I.CategoryId, D.ProductName, I.ProductName, D.Price, I.Price
		FROM inserted I
		LEFT JOIN deleted D ON I.ProductId = D.ProductId
	END

    -- Инструкция если происходит удаление записи
	IF @SQL_Command = 'DELETE'
	BEGIN 
		INSERT INTO AuditProducts(DtChange, UserName, SQL_Command, ProductId_Old,
								   ProductId_New, CategoryId_Old, CategoryId_New,
								   ProductName_Old, ProductName_New, Price_Old, Price_New)
		SELECT GETDATE(), SUSER_SNAME(), @SQL_Command,
				D.ProductId, NULL,
				D.CategoryId, NULL,
				D.ProductName, NULL,
				D.Price, NULL
		FROM deleted D
	END
END

----------------------------------------------------------
-- Проверка

--Добавляем запись
INSERT INTO Products
VALUES (1, N'Lenovo', 0)

--Изменяем запись
UPDATE Products SET ProductName = N'Samsung',
Price = 200
WHERE ProductName = 'Lenovo'

--Удаляем запись
DELETE Products WHERE ProductName = N'Samsung'

--Смотрим изменения
SELECT * FROM AuditProducts

----------------------------------------------------------
-- Включение и Отключение Триггеров

