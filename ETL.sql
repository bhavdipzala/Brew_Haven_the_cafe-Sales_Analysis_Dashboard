CREATE DATABASE brew_haven_the_cafe;
USE brew_haven_the_cafe;

-- EXTRACT

-- 'raw_dataset' table has been created to import the raw dataset as it is.
CREATE TABLE raw_dataset (
    transaction_id INT,
    transaction_date VARCHAR(15),
    transaction_time VARCHAR(15),
    transaction_qty INT,
    store_id INT,
    store_location VARCHAR(20),
    product_id INT,
    unit_price FLOAT,
    product_category VARCHAR(20),
    product_type VARCHAR(50),
    product_detail VARCHAR(50)
);

-- Raw .csv file has been imported into the 'raw_dataset' table.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Coffee Shop Sales.csv'
INTO TABLE raw_dataset
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM raw_dataset;

-- TRANSFORM

-- Carriage Returns (CHAR(13)) have been removed from the last column 'product_detail' to remove hidden characters(\n).
UPDATE raw_dataset
SET product_detail = REPLACE(product_detail, CHAR(13), '');

-- 'raw_dataset' table has been normalized by
-- creating three related tables - Stores, Products, and Transactions, and extracting data from the 'raw_dataset' table.

-- 1. 'stores' table
CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_location VARCHAR(20) NOT NULL,
    CONSTRAINT unique_stores UNIQUE (store_location) -- Prevents duplicate store listings.
);

INSERT INTO stores
(store_id, store_location)
SELECT DISTINCT store_id, store_location FROM raw_dataset;

SELECT * FROM STORES;

-- 2. 'Products' table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_detail VARCHAR(50),
    product_type VARCHAR(50),
    product_category VARCHAR(20),
    CONSTRAINT unique_products UNIQUE (product_detail, product_type, product_category) -- Prevents duplicate product listings
);

INSERT INTO products
(product_id, product_detail, product_type, product_category)
SELECT DISTINCT product_id, product_detail, product_type, product_category FROM raw_dataset;

SELECT * FROM products;

-- 3. 'transactions' table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    product_id INT,
    transaction_quantity INT, -- column name has been renamed from 'transaction_qty'
    unit_price DECIMAL(5,2),
    store_id INT,
    transaction_date DATE,
    transaction_time TIME,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id) -- foreign keys have been created, referencing the 'products' and 'stores' tables
);

INSERT INTO transactions
(transaction_id, product_id, transaction_quantity, unit_price, store_id, transaction_date, transaction_time)
SELECT transaction_id, product_id, transaction_qty, unit_price, store_id, STR_TO_DATE(transaction_date, '%d-%m-%Y'), transaction_time FROM raw_dataset;

SELECT * FROM transactions;

-- 'Product_size' column has been created inside the 'products' table, and the product sizes have been extracted from the 'product_detail' column.
-- also the existing constraint 'unique_products' has been updated to include new 'product_size' column.

ALTER TABLE products
ADD COLUMN product_size VARCHAR(15),
DROP CONSTRAINT unique_products,
ADD CONSTRAINT unique_products UNIQUE (product_detail, product_type, product_category, product_size);

UPDATE products
SET product_size =
    CASE 
        WHEN product_detail LIKE '% Lg' THEN 'Large'
        WHEN product_detail LIKE '% Rg' THEN 'Regular'
        WHEN product_detail LIKE '% Sm' THEN 'Small'
        ELSE  'N/A'
    END;

-- Size abbreviations have been removed from the 'product_detail' column.
UPDATE products
SET product_detail =
    REPLACE(
        REPLACE(
            REPLACE(product_detail, ' Lg', ''),
        ' Rg', ''),
    ' Sm', '');



