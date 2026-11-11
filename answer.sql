-- Week 7 Assignment: Database Design and Normalization
-- MySQL solution

-- =========================================================
-- Question 1: Achieving First Normal Form (1NF)
-- =========================================================
-- The original Products column held multiple values in one cell.
-- In 1NF, each row contains one product for one order.
-- CustomerName is repeated here because this question focuses on
-- separating the repeating product values.

DROP TABLE IF EXISTS OrderProducts;

CREATE TABLE OrderProducts (
    OrderID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Product VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID, Product)
);

INSERT INTO OrderProducts (OrderID, CustomerName, Product) VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Review the 1NF result
SELECT OrderID, CustomerName, Product
FROM OrderProducts
ORDER BY OrderID, Product;


-- Question 2: Achieving Second Normal Form (2NF)
-- CustomerName depends on OrderID alone, so store it in AssignmentOrders.
-- Quantity depends on the full key (OrderID, Product), so store it
-- in AssignmentOrderItems.

DROP TABLE IF EXISTS AssignmentOrderItems;
DROP TABLE IF EXISTS AssignmentOrders;

CREATE TABLE AssignmentOrders (
    OrderID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID)
);

CREATE TABLE AssignmentOrderItems (
    OrderID INT NOT NULL,
    Product VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    CONSTRAINT fk_assignment_items_orders
        FOREIGN KEY (OrderID)
        REFERENCES AssignmentOrders (OrderID)
);

INSERT INTO AssignmentOrders (OrderID, CustomerName) VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

INSERT INTO AssignmentOrderItems (OrderID, Product, Quantity) VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

SELECT
    o.OrderID,
    o.CustomerName,
    i.Product,
    i.Quantity
FROM AssignmentOrders AS o
JOIN AssignmentOrderItems AS i
    ON i.OrderID = o.OrderID
ORDER BY o.OrderID, i.Product;