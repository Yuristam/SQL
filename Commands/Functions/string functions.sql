/*
    String functions:

    🔹 LTRIM() - убирает пробел в начале строки.
    🔹 RTRIM() - убирает пробел в конце строки.
    🔹 LOWER() - В верхнем регистре
    🔹 UPPER() - В нижнем регистре
    🔹 LEN() - Количество символов в строке
    🔹 LEFT() - только первые несколько символов слева
    🔹 RIGHT() - только первые несколько символов справа
    🔹 SUBSTRING() - вывести определенную часть строки, начиная с указанной позиции и в определенном количестве символов
*/
--------------------------------------------
-- LTRIM() RTRIM()

DECLARE @TestVar VARCHAR(100),
		@TestVar2 VARCHAR(100)

-- Присвоение значения
SELECT @TestVar = '     Text',
	   @TestVar2 = 'Text    '
	   
-- без функций
SELECT @TestVar AS TestVar,
	   @TestVar2 AS TestVar2

-- с функцией
SELECT LTRIM(@TestVar) AS TestVar,
	   RTRIM(@TestVar2) AS TestVar2


--------------------------------------------
-- LOWER() UPPER()

DECLARE @TestVar VARCHAR(100),
        @TestVar2 VARCHAR(100)

-- Присвоение значения
SELECT @TestVar = 'ТеКст',
       @TestVar2 = 'ТЕкст'

-- Без использования функции
SELECT @TestVar AS TestVar,
       @TestVar2 AS TestVar2

-- С использованием функций
SELECT UPPER(@TestVar) AS TestVar,
       LOWER(@TestVar2) AS TestVar2


--------------------------------------------
-- LEN()

SELECT LEN('123456789') AS [Количество символов]


--------------------------------------------
-- LEFT() RIGHT()

DECLARE @TestVar VARCHAR(100),
        @TestVar2 VARCHAR(100)

-- Присвоение значений
SELECT @TestVar = '1234567890',
       @TestVar2 = '1234567890'

-- Первый параметр - строка, второй - количество символов
SELECT LEFT(@TestVar, 5) AS TestVar,
RIGHT(@TestVar2, 5) AS TestVar2


--------------------------------------------
-- SUBSTRING()

DECLARE @TestVar VARCHAR(100)

-- Присвоение значения
SELECT @TestVar = '1234567890'

-- три параметра, первый - строка, второй – начальная позиция, третий - количество символов
SELECT SUBSTRING(@TestVar, 3, 5) AS TestVar
