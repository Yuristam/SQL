/*
    OUTPUT - инструкция T-SQL, позволяющая получить изменившиеся строки в результате выполнения 
    инструкций INSERT, UPDATE, DELETE или MERGE.

    1. Inserted - временная таблица добавления 
    2. Deleted - временная таблица удаления 
*/


-----------------------------------
-- пример с INSERT

INSERT INTO Pets
	OUTPUT Inserted.ID,
		   Inserted.Name,
		   Inserted.Price
	VALUES ('Bobik', 145.03)


-----------------------------------
-- пример с DELETE

DELETE Pets
    OUTPUT Deleted.*
WHERE ID > 3


-----------------------------------
-- пример с UPDATE

UPDATE Pets SET Price = 250
	OUTPUT Inserted.ID AS [ID],
		   Deleted.Price AS [Old Price],
		   Inserted.Price AS [New Price]
WHERE ID > 3
