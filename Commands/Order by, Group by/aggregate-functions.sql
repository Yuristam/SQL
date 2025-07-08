/*  
    MIN() - returns the smallest value within the selected column
    MAX() - returns the largest value within the selected column
    COUNT() - returns the number of rows in a set
    SUM() - returns the total sum of a numerical column
    AVG() - returns the average value of a numerical column
*/

-------------------------------------------------------------------

SELECT MIN(Price) AS MinPrice
FROM Products;

-----------------------------

SELECT MAX(Price) AS MaxPrice
FROM Products;

-----------------------------

SELECT COUNT(*)
FROM Products;

-----------------------------

SELECT COUNT(*) AS AllDrinksQuantity
FROM Drinks;

-----------------------------

SELECT COUNT(ID)
FROM Drinks
WHERE Price > 270;

-----------------------------

SELECT COUNT(DISTINCT Price)
FROM Products;

-----------------------------

SELECT SUM(Quantity) AS total
FROM OrderDetails;

-----------------------------

SELECT AVG(Price) AS AvgPrice
FROM Products;
