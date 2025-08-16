/*
    CONSTRAINTS

    🔹 NULL / NOT NULL
    🔹 PRIMARY KEY (может состоять из нескольких столбцов (составной))
    🔹 FOREIGN KEY (ссылка на PRIMARY KEY)
    🔹 UNIQUE
    🔹 CHECK - задает условие по которому можно хранить данные (можно делать несколько CHECK к одному столбцу)
    🔹 DEFAULT - если пользователь не задал значение, то подставится значение по умолчанию


    🔶 ON DELETE / ON UPDATE:
    🔸 NO ACTION - ничего не делать, просто выводить ошибку (заблокировать изменение/удаление)
    🔸 CASCADE - каскадное изменение/удаление
    🔸 SET NULL - присвоить значение NULL
    🔸 SET DEFAULT - присвоить значение по умолчанию

    ❕ При создании FOREIGN KEY без указания ON DELETE/ON UPDATE, по умолчанию будет именно NO ACTION
*/

----------------------------------------------------------
-- 🔑 PRIMARY KEY

-- Создание ограничения 
ALTER TABLE Pets ADD CONSTRAINT PK_Pets PRIMARY KEY (PetID)

----

-- Создание ограничения при создании таблицы
-- Первый вариант
CREATE TABLE PetBreeds (
    BreedID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_BreedID PRIMARY KEY,
    BreedType VARCHAR (100) NOT NULL 
)

-- Второй вариант
CREATE TABLE PetBreeds (
    BreedID INT IDENTITY(1,1) NOT NULL,
    BreedType VARCHAR (100) NOT NULL,
    CONSTRAINT PK_BreedID PRIMARY KEY (BreedID) 
)

-----------------

-- 🔑 FOREIGN KEY
-- Создание ограничения при создании таблицы
CREATE TABLE Pets (
    PetID INT IDENTITY(1,1) NOT NULL,
    BreedID INT NOT NULL,
    PetName NVARCHAR(100) NOT NULL,
    Price MONEY NULL,
 CONSTRAINT PK_Pets PRIMARY KEY (PetID),
 CONSTRAINT FK_Pets FOREIGN KEY (BreedID) REFERENCES PetBreeds (BreedID)
    ON DELETE CASCADE           -- каскадное удаление
    ON UPDATE NO ACTION         -- заблокирует изменение
)

----

-- Создание ограничения 
ALTER TABLE Pets ADD CONSTRAINT FK_Pets FOREIGN KEY (BreedID) 
    REFERENCES PetBreeds (BreedID) 

-----------------

----------------------------------------------------------
-- Создание ограничения путем изменения столбца
ALTER TABLE Products ALTER COLUMN [Price] [Money] NOT NULL 
