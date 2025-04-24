-- Achieving 1NF (First Normal Form)
-- Transform the ProductDetail table into 1NF by splitting the Products column
SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail
JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) n
ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1
ORDER BY OrderID, n.n;

-- Achieving 2NF (Second Normal Form)
-- Create CustomerDetails table to store customer information
CREATE TABLE CustomerDetails (
    OrderID INT,
    CustomerName VARCHAR(255),
    PRIMARY KEY (OrderID)
);

-- Insert data into CustomerDetails
INSERT INTO CustomerDetails (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create OrderDetails table to store order information
CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)
);

-- Insert data into OrderDetails
INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
