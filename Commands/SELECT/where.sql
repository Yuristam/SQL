/* 
    WHERE - условия.
    >
    >=
    =
    <
    <=
    <> (!=)
    !>
    !<
    LIKE
    NOT LIKE
    BETWEEN 
    NOT BETWEEN
    IN
    NOT IN
    EXISTS
*/

-------------------------------------

-- ><=
SELECT  ProductID,
        ProductName,
        Price
FROM Products
WHERE Price >= 100 AND Price <= 500

-- BETWEEN
SELECT  ProductID,
        ProductName,
        Price
FROM Products
WHERE Price BETWEEN 100 AND 500

-- NOT BETWEEN
SELECT  ProductID,
        ProductName,
        Price
FROM Products
WHERE Price NOT BETWEEN 100 AND 500

----------------------------------------

-- LIKE 'E%' (название которого начинается с 'E')
SELECT  ProductID,
        ProductName,
        Price
FROM Products
WHERE ProductName LIKE 'T%'

-- NOT LIKE 'E%'
SELECT  ProductID,
        ProductName,
        Price
FROM Products
WHERE ProductName NOT LIKE 'T%'

-------------------------------------------

-- IN (товары по определенным ценам)
SELECT  ProductID,
        ProductName,
        Price
FROM Products
WHERE Price IN (50, 100)        

-- OR
SELECT  ProductID,
        ProductName,
        Price
FROM Products
WHERE Price = 50 OR Price = 100

-------------------------------------------

-- NULL

SELECT  ProductID,
        ProductName,
        Price
FROM Products
WHERE Price IS NOT NULL