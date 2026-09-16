-- ==========================================================
-- ADDED QUERIES FOR PRACTICE: NESTED SELECT, AGGREGATE, & ANALYTICAL
-- ==========================================================

-- 1. NESTED SELECT (Subqueries)
-- Find all products with a price greater than the average price of all products
SELECT ProductID, ProductName, Price
FROM prod_info
WHERE Price > (SELECT AVG(Price) FROM prod_info);

-- Find products belonging to categories that have 'Electronics' in their name (using IN subquery)
SELECT ProductID, ProductName, Price, CategoryID
FROM prod_info
WHERE CategoryID IN (
    SELECT CategoryID 
    FROM category 
    WHERE CategoryName LIKE '%Electronics%'
);

-- 2. AGGREGATE FUNCTIONS WITH GROUP BY
-- Get the total stock quantity and average price for each category ID
SELECT CategoryID, 
       SUM(StockQuantity) AS TotalStock, 
       AVG(Price) AS AveragePrice,
       COUNT(ProductID) AS TotalProducts
FROM prod_info
GROUP BY CategoryID;

-- Filter aggregated results using HAVING: Categories where total stock is greater than 30
SELECT CategoryID, 
       SUM(StockQuantity) AS TotalStock
FROM prod_info
GROUP BY CategoryID
HAVING SUM(StockQuantity) > 30;

-- 3. ANALYTICAL (WINDOW) FUNCTIONS
-- Assign a row number to products ordered by price descending within each category
SELECT ProductID, 
       ProductName, 
       CategoryID, 
       Price,
       ROW_NUMBER() OVER (PARTITION BY CategoryID ORDER BY Price DESC) AS PriceRankInCat
FROM prod_info;

-- Calculate a running total of stock quantity ordered by price
SELECT ProductID, 
       ProductName, 
       Price, 
       StockQuantity,
       SUM(StockQuantity) OVER (ORDER BY Price ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotalStock
FROM prod_info;

-- Compare each product's price with the previous product's price using LAG
SELECT ProductID, 
       ProductName, 
       Price,
       LAG(Price, 1) OVER (ORDER BY Price) AS PreviousProductPrice
FROM prod_info;
