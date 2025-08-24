/*
    тип данных XML 

    Методы:
    🔹 query() - метод делает выборку в самом XML документе, который хранится в столбце с типом XML. Метод принимает один 
    параметр, запрос к xml документу, т.е. что именно Вы хотите получить из xml.
    
    🔹 value() – метод возвращает значение узла. Метод имеет два параметра, первый - это откуда брать значение, а второй - какой 
    тип Вы при этом хотите получить на выходе.
    
    🔹 exist() – данный метод используется для того, чтобы проверять наличие тех или иных значений, атрибутов или элементов 
    в XML документе. Метод возвращает значения типа bit, такие как: 1 – если выражение на языке XQuery при запросе возвращает
    непустой результат, 0 – если возвращается пустой результат, NULL – если данные типа xml, к которым идет обращение, не содержат 
    никаких данных, т.е. NULL.
    
    🔹 modify() – этот метод изменяет XML данные. 

    🔹 nodes() – метод используется для получения реляционных данных из конкретного XML документа.



*/
----------------------------------------------------------------------------------------------------------------------------
-- создание таблицы с XML
CREATE TABLE TestTableXML(
	ID INT IDENTITY(1,1) NOT NULL,
	NameColumn NVARCHAR(100) NOT NULL,
	XMLData XML NULL 
	CONSTRAINT PK_TestTableXML PRIMARY KEY (ID)
)

GO

INSERT INTO TestTableXML (NameColumn, XMLData)
VALUES ('Text', '<Catalog>
					<Name>Eren</Name>
					<LastName>Jeager</LastName>
				 </Catalog>')

GO

SELECT * FROM TestTableXML

-------------------------------------------------
-- query()

SELECT XMLData.query('/Catalog/Name') AS [Тег Name]
FROM TestTableXML


-------------------------------------------------
-- value()
SELECT XMLData, XMLData.value('/Catalog[1]/LastName[1]', 'VARCHAR(100)') AS [LastName]
FROM TestTableXML


-------------------------------------------------
-- exist()
SELECT *
FROM TestTableXML
WHERE XMLData.exist('/Catalog[1]/LastName') = 1


-------------------------------------------------
-- modify()     для удаления элемента (delete)
UPDATE TestTableXML SET XMLData.modify('delete /Catalog/LastName')
GO
SELECT * FROM TestTableXML


-----------------
-- modify()     Добавление элемента (insert)
UPDATE TestTableXML 
SET XMLData.modify('insert <LastName>Smith</LastName> as last into (/Catalog) [1]')
GO
SELECT * FROM TestTableXML


-----------------
-- modify()     Изменение значения в узле (replace value of ... with ...)
UPDATE TestTableXML 
SET XMLData.modify('replace value of(/Catalog/Name[1]/text()) [1] with "Eren"')
GO
SELECT * FROM TestTableXML


-------------------------------------------------
-- nodes()
DECLARE @XML_Doc XML;
SET @XML_Doc='<Root>
				<row id="1" Name="Armin"></row>
				<row id="2" Name="Mikasa"></row>
			  </Root>';
SELECT TMP.col.value('@id','INT') AS Id,
		TMP.col.value('@Name', 'NVARCHAR(10)') AS Name
FROM @XML_Doc.nodes('/Root/row') AS TMP(Col);


-------------------------------------------------
-- 