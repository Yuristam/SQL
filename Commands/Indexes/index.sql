/*
    Index - это специальная структура данных, которая ускоряет поиск и выборку строк в таблице или представлении. По сути это
    некие ссылки на данные, своего рода предметный указатель.

    0. Таблица без индексов это - Heap.

    Базовые Индексы (Кластерный и Некластерный) :

    1. Clustered Index (кластерный индекс)
        1.1 По сути это просто отсортированная таблица (по заданному столбцу(ключу))
        1.2 По умолчанию PRIMARY KEY (если конечно PRIMARY KEY не обозначен как NONCLUSTERED).
        1.3 В таблице может быть только один кластерный индекс.

    2. Nonclustered Index (некластерный индекс)
        2.1 По сути это "мини-таблица", содержащая только значение и ссылку(указатели), где его найти это самое значение.
        2.2 Можно создать много некластерных индексов.

    Другие индексы (по сути это атрибуты или опции индексов, они модифицируют поведение Кластерного и Некластерного индексов):

    3. UNIQUE (уникальный)
    4. FILTERED (фильтрованный) - индекс содержит только подмножество строк, удовлетворяющих условию.
    5. Full-text Index (полнотекстовый индекс)
    6. XML Index, Columnstore Index
*/

----------------------------------------------------------------------------------------------
-- heap таблица (данные лежат без порядка)

CREATE TABLE People 
(
	ID INT,
	NAME NVARCHAR (250) NOT NULL
)


CREATE TABLE People 
(
	ID INT IDENTITY(1, 1),
	NAME NVARCHAR (250) NOT NULL
)

----------------------------------------------------------------------------------------------
-- clustered index (PK по умолчанию - кластерный индекс)

CREATE TABLE People 
(
	ID INT IDENTITY(1, 1) PRIMARY KEY ,
	NAME NVARCHAR (250) NOT NULL
)

----------------------------------------------------------------------------------------------
-- nonclustered index (Heap + Nonclustered)

CREATE TABLE People 
(
	ID INT IDENTITY(1, 1) PRIMARY KEY NONCLUSTERED,
	NAME NVARCHAR (250) NOT NULL
)


----------------------------------------------------------------------------------------------
-- создание кластерного индекса

CREATE CLUSTERED INDEX IX_Customers_ID
ON Customers (CustomerID);

----

CREATE CLUSTERED INDEX IX_Clustered ON Characters
(
	ID ASC
)

----------------------------------------------------------------------------------------------
-- создание НЕкластерного индекса

CREATE NONCLUSTERED INDEX IX_Customers_Name
ON Customers (Name);

----

CREATE NONCLUSTERED INDEX IX_NonClustered ON Characters
(
	Name ASC
)

----------------------------------------------------------------------------------------------
-- создание уникального кластерного индекса

CREATE UNIQUE CLUSTERED INDEX IX_Customers_Email
ON Customers (Email);

----
-- Уникальный некластерный индекс

CREATE UNIQUE NONCLUSTERED INDEX IX_Customers_Phone
ON Customers (PhoneNumber);

----------------------------------------------------------------------------------------------
-- Фильтрованный некластерный индекс

CREATE NONCLUSTERED INDEX IX_Customers_Active
ON Customers (Status)
WHERE Status = 'Active';

----------------------------------------------------------------------------------------------
-- Индекс с включёнными столбцами (included columns)

CREATE NONCLUSTERED INDEX IX_Customers_Name_WithCity
ON Customers (Name)
INCLUDE (City, PhoneNumber);

CREATE NONCLUSTERED INDEX IX_NonClustered ON Pets
(
    Name ASC,
    OwnerID ASC
)
    INCLUDE (Price)

----------------------------------------------------------------------------------------------
-- Удаление Index 

DROP INDEX IX_NonClustered ON Characters

----------------------------------------------------------------------------------------------
-- Можно удалить и сразу же создать Индекс с изменениями 

CREATE NONCLUSTERED INDEX IX_NonClustered ON Pets
(
    Name ASC,
    OwnerID ASC,
	Breed ASC
)
    INCLUDE (Price, Classification)
WITH (DROP_EXISTING = ON);
    