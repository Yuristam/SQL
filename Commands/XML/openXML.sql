/*
    OPENXML - позволяет читать XML-данные и превращать их в табличный формат (то есть обратно в строки и столбцы SQL).

    🔸 Если FOR XML превращает результат запроса в XML, то OPENXML делает наоборот — парсит XML-документ 
    и достает из него данные в виде таблицы, которую можно использовать, как обычный SELECT из таблицы.


    🔹 1. Создадим переменную XML:

        DECLARE @xml XML = '
        <Users>
          <User Id="1" Name="John" Age="25"/>
          <User Id="2" Name="Anna" Age="30"/>
        </Users>';


    🔹 2. Подготовим XML к обработке:

        DECLARE @doc INT;
        EXEC sp_xml_preparedocument @doc OUTPUT, @xml;


    🔹 3. Прочитаем XML через OPENXML:

        SELECT *
        FROM OPENXML(@doc, '/Users/User', 1)
        WITH (
            Id INT '@Id',
            Name NVARCHAR(50) '@Name',
            Age INT '@Age'
        );


    🔹 4. Освобождаем ресурсы

        EXEC sp_xml_removedocument @doc;


    💡 Важно: sp_xml_preparedocument загружает XML в память, поэтому после использования обязательно 
    вызывать sp_xml_removedocument, иначе будут утечки памяти в SQL Server.
*/
----------------------------------------------------------------------------------------------------------------------

/*
    Ниже пример, с созданием XML документа в начале, а после чтением его. 
    Также используются встроенные процедуры sp_xml_preparedocument и sp_xml_removedocument
*/

--Объявляем переменные
DECLARE @XML_Doc XML;
DECLARE @XML_Doc_Handle INT;

--Формируем XML документ
SET @XML_Doc = (
					SELECT ProductId AS "@ID", ProductName, Price
					FROM Products
					ORDER BY ProductId
					FOR XML PATH ('Product'), TYPE, ROOT ('Products')
				);

--Подготавливаем XML документ
EXEC sp_xml_preparedocument @XML_Doc_Handle OUTPUT, @XML_Doc;

--Извлекаем данные из XML документа
SELECT *
FROM OPENXML (@XML_Doc_Handle, '/Products/Product', 2)
WITH (
		ProductId INT '@Id',
		ProductName VARCHAR(100),
		Price MONEY
	);

--Удаляем дескриптор XML документа
EXEC sp_xml_removedocument @XML_Doc_Handle;
