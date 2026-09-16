-- Table Creation
CREATE TABLE category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE prod_info (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    Price DECIMAL(10, 2),
    StockQuantity INT,
    CONSTRAINT FK_Category FOREIGN KEY (CategoryID) REFERENCES category(CategoryID)
);

-- Insert Test Data
INSERT INTO category (CategoryID, CategoryName) VALUES 
(1, 'Electronics'), 
(2, 'Apparel');

INSERT INTO prod_info (ProductID, ProductName, CategoryID, Price, StockQuantity) VALUES
(101, 'Smartphone', 1, 699.99, 50),
(102, 'Laptop', 1, 1299.50, 30),
(103, 'T-Shirt', 2, 19.99, 200);

-- SELECT Command
SELECT ProductID, ProductName, Price, StockQuantity 
FROM prod_info 
WHERE Price > 50.00;

-- UPDATE Command
UPDATE prod_info 
SET Price = Price * 0.90 
WHERE CategoryID = 1;

-- ALTER TABLE Command (Add Column)
ALTER TABLE prod_info 
ADD DateAdded DATE DEFAULT GETDATE();

-- DELETE Command
DELETE FROM prod_info 
WHERE StockQuantity < 40;

-- Third Highest Price Query
SELECT ProductName
FROM prod_info
ORDER BY Price DESC
OFFSET 2 ROWS
FETCH NEXT 1 ROWS ONLY;

-- Inner Join
SELECT p.ProductID, p.ProductName, c.CategoryName, p.Price, p.StockQuantity
FROM prod_info p
INNER JOIN category c ON p.CategoryID = c.CategoryID;

-- Left Join
SELECT p.ProductID, p.ProductName, c.CategoryName, p.Price
FROM prod_info p
LEFT JOIN category c ON p.CategoryID = c.CategoryID;

-- Right Join
SELECT p.ProductID, p.ProductName, c.CategoryName, p.Price
FROM prod_info p
RIGHT JOIN category c ON p.CategoryID = c.CategoryID;

-- Full Outer Join
SELECT p.ProductID, p.ProductName, c.CategoryName, p.Price
FROM prod_info p
FULL OUTER JOIN category c ON p.CategoryID = c.CategoryID;

-- Cross Join
SELECT p.ProductID, p.ProductName, c.CategoryName, p.Price
FROM prod_info p
CROSS JOIN category c;

-- Rename Table (using sp_rename)
EXEC sp_rename 'prod_info', 'new_prod_info_name';

-- Rename Column (using sp_rename)
EXEC sp_rename 'new_prod_info_name.old_column_name', 'new_column_name', 'COLUMN';

-- Drop Column from Table
ALTER TABLE new_prod_info_name 
DROP COLUMN column_name;

-- Drop Foreign Key Constraint
ALTER TABLE new_prod_info_name 
DROP CONSTRAINT FK_Category;
