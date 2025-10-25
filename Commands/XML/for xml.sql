/*
    Конструкции FOR XML.
    🔸 Конструкция FOR XML в MS SQL Server используется для преобразования результатов запроса в XML-формат. Она 
    позволяет получить данные в виде XML-документа прямо из SQL-запроса.

    Режимы:
    🔹 RAW – создает XML с элементом <row> для КАЖДОЙ строки SELECT-а.
    🔹 AUTO – в данном режиме структура XML документа создается автоматически, в зависимости от инструкции SELECT 
    (объединений, вложенных запросов и так далее).
    🔹 EXPLICIT – режим, при котором Вы сами формируете структуру итогового XML документа, это самый расширенный режим 
    работы конструкции FOR XML и, в то же время, самый трудоемкий.
    🔹 PATH – это своего рода упрощенный режим EXPLICIT, который хорошо справляется с множеством задач по формированию XML 
    документов, включая формирование атрибутов для элементов. Если Вам нужно самим сформировать структуру XML данных, 
    то рекомендовано использовать именно этот режим.

    Параметры:
    🔹 TYPE – возвращает сформированные XML данные с типом XML, если параметр TYPE не указан, данные возвращаются с 
    типом nvarchar(max). Параметр необходим в тех случаях, когда над итоговыми XML данными будут проводиться операции, 
    характерные для XML данных, например, выполнение инструкций на языке XQuery.
    🔹 ELEMENTS – если указать данный параметр, столбцы возвращаются в виде вложенных элементов.
    🔹 ROOT – параметр добавляет к результирующему XML-документу один элемент верхнего уровня (корневой элемент), по 
    умолчанию «root», однако название можно указать произвольное.
*/
------------------------------------------------------------------------------------------------------------------------
-- RAW режим
SELECT Id, Name, Age
FROM Users
FOR XML RAW

-- параметр TYPE
SELECT Id, Name, Age
FROM Users
FOR XML RAW, TYPE


----------
-- result 
<row Id="3" Name="Harry" Age="25" />
<row Id="2" Name="Jimmy" Age="24" />
<row Id="1" Name="John" Age="23" />


---------------------------------------
-- параметры ELEMENTS, ROOT
SELECT Id, Name, Age
FROM Users
FOR XML RAW ('User'), TYPE, ELEMENTS, ROOT ('Users')

-- result
<Users>
  <User>
    <Id>1</Id>
    <Name>John</Name>
    <Age>23</Age>
  </User>
  <User>
    <Id>2</Id>
    <Name>Jimmy</Name>
    <Age>24</Age>
  </User>
  <User>
    <Id>3</Id>
    <Name>Harry</Name>
    <Age>25</Age>
  </User>
</Users>


-------------------------------------
-- режим AUTO
SELECT Drinks.Name, Drinks.Price, DrinkCategories.CategoryName
FROM Drinks
LEFT JOIN DrinkCategories ON DrinkCategories.CategoryID = Drinks.CategoryID
FOR XML AUTO, TYPE

-- result
<Drinks Name="Cola" Price="80.00">
  <DrinkCategories CategoryName="Газированный напиток" />
</Drinks>
<Drinks Name="Чудо Натуральный" Price="250.00">
  <DrinkCategories CategoryName="Натуральный сок" />
</Drinks>
<Drinks Name="Legendary Water" Price="30.00">
  <DrinkCategories CategoryName="Вода" />
</Drinks>


-------------------------------------------
-- режим AUTO параметр ELEMENTS
SELECT Drinks.Name, Drinks.Price, DrinkCategories.CategoryName
FROM Drinks
LEFT JOIN DrinkCategories ON DrinkCategories.CategoryID = Drinks.CategoryID
FOR XML AUTO, TYPE, ELEMENTS

-- result
<Drinks>
  <Name>Cola</Name>
  <Price>80.00</Price>
  <DrinkCategories>
    <CategoryName>Газированный напиток</CategoryName>
  </DrinkCategories>
</Drinks>
<Drinks>
  <Name>Чудо Натуральный</Name>
  <Price>250.00</Price>
  <DrinkCategories>
    <CategoryName>Натуральный сок</CategoryName>
  </DrinkCategories>
</Drinks>
<Drinks>
  <Name>Legendary Water</Name>
  <Price>30.00</Price>
  <DrinkCategories>
    <CategoryName>Вода</CategoryName>
  </DrinkCategories>
</Drinks>


-------------------------------------------
-- режим PATH и использование атрибута @
SELECT Drinks.Id AS "@Id", Drinks.Name, Drinks.Price, DrinkCategories.CategoryName
FROM Drinks
LEFT JOIN DrinkCategories ON DrinkCategories.CategoryID = Drinks.CategoryID
FOR XML PATH ('Drink'), TYPE, ROOT ('Drinks')


-- result
<Drinks>
  <Drink Id="1">
    <Name>Cola</Name>
    <Price>80.00</Price>
    <CategoryName>Газированный напиток</CategoryName>
  </Drink>
  <Drink Id="2">
    <Name>Чудо Натуральный</Name>
    <Price>250.00</Price>
    <CategoryName>Натуральный сок</CategoryName>
  </Drink>
  <Drink Id="3">
    <Name>Legendary Water</Name>
    <Price>30.00</Price>
    <CategoryName>Вода</CategoryName>
  </Drink>
</Drinks>

--------
SELECT
    Id AS "@Id",
    Name AS "PersonalInfo/Name",
    Age AS "PersonalInfo/Age"
FROM Users
FOR XML PATH('User')

-- result
<User Id="1">
  <PersonalInfo>
    <Name>John</Name>
    <Age>23</Age>
  </PersonalInfo>
</User>
<User Id="2">
  <PersonalInfo>
    <Name>Jimmy</Name>
    <Age>24</Age>
  </PersonalInfo>
</User>
<User Id="3">
  <PersonalInfo>
    <Name>Harry</Name>
    <Age>25</Age>
  </PersonalInfo>
</User>
