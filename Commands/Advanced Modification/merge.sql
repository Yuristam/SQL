/*
    MERGE - это оператор, который объединяет в себе INSERT, UPDATE и DELETE в одном выражении.

    1. MERGE INTO TargetTable — куда будут вноситься изменения.
    2. USING SourceTable — откуда берём данные (может быть подзапрос).
    3. ON — условие, по которому сравниваем строки.
    4. WHEN MATCHED THEN UPDATE — если нашли совпадение, обновляем.
    5. WHEN NOT MATCHED THEN INSERT — если не нашли, вставляем.
    6. WHEN NOT MATCHED BY SOURCE THEN DELETE — можно удалить строки, которых больше нет в источнике.

    MERGE <Основная таблица>
        USING <Таблица или запрос источника>
        ON <Условия объединения>
        [ WHEN MATCHED [ AND <Доп. условие> ]
            THEN <UPDATE или DELETE>
        [ WHEN NOT MATCHED [ AND Доп. условие> ]
            THEN <INSERT> ]
        [ WHEN NOT MATCHED BY SOURCE [ AND <Доп. условие> ]
            THEN <UPDATE или DELETE> ] [ ...n ]
    [ OUTPUT ];
*/

----------------------------------------------------------
-- без OUTPUT

MERGE INTO Pets P
	USING NewPets Np
	ON P.ID = Np.ID
	WHEN MATCHED THEN 
		UPDATE SET 
			P.Name = Np.Name,
			P.Price = Np.Price
	WHEN NOT MATCHED THEN
		INSERT (Name, Price)
		VALUES (Np.Name, Np.Price)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE

-----------------------------------------------------------
-- с OUTPUT

MERGE INTO Pets P
	USING NewPets Np
	ON P.ID = Np.ID
	WHEN MATCHED THEN 
		UPDATE SET 
			P.Name = Np.Name,
			P.Price = Np.Price
	WHEN NOT MATCHED THEN
		INSERT (Name, Price)
		VALUES (Np.Name, Np.Price)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE

	OUTPUT $action AS [Операция], Inserted.Id,
		Inserted.Name AS PetNameNEW,
		Inserted.Price AS PriceNEW,
		Deleted.Name AS PetNameOLD,
		Deleted.Price AS PriceOLD;
