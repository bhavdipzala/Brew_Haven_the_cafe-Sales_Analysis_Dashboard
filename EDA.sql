-- EXPLORATORY DATA ANALYSIS (EDA):

-- BASIC OVERVIEW AND BUSINESS-OVERALL KPIs AT A HIGH LEVEL:

-- 1. Total Orders (Customer Footfall)
SELECT COUNT(DISTINCT transaction_id) AS total_transactions
FROM transactions;

-- 2. Total Sales Revenue
SELECT SUM(transaction_quantity * unit_price) AS total_sales_revenue
FROM transactions;

-- 3. Total Quantity Sold
SELECT SUM(transaction_quantity) AS total_quantity_sold
FROM transactions;

-- 4. Average Order Value (AOV)
SELECT ROUND((SUM(transaction_quantity * unit_price) / COUNT(DISTINCT transaction_id)), 2) AS avg_order_value
FROM transactions;


-- STORE-WISE PERFORMANCE ANALYSIS:

-- 5. Overall Sales/KPIs by Store Location, [Ordered by Revenue]
SELECT
    store_location,
    COUNT(DISTINCT transaction_id) AS orders,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    SUM(transaction_quantity) AS quantity_sold,
    ROUND((SUM(transaction_quantity * unit_price) / COUNT(DISTINCT transaction_id)), 2) AS avg_order_value
FROM transactions t INNER JOIN stores s
ON t.store_id = s.store_id
GROUP BY store_location
ORDER BY sales_revenue DESC;

-- 6. Revenue Contribution(%) by Store Location
SELECT
    store_location,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    ROUND((SUM(transaction_quantity * unit_price) / (SELECT SUM(transaction_quantity * unit_price) FROM transactions))*100, 2) AS revenue_contribution
FROM stores s INNER JOIN transactions t
ON s.store_id = t.store_id
GROUP BY store_location
ORDER BY revenue_contribution DESC;


-- TIME-BASED ANALYSIS:

-- 7. Business-Overall Sales/KPIs by Hour of the Day, Finding the Peak Hours
SELECT
    HOUR(transaction_time) AS hour,
    COUNT(DISTINCT transaction_id) AS orders,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    SUM(transaction_quantity) AS quantity_sold,
    ROUND((SUM(transaction_quantity * unit_price) / COUNT(DISTINCT transaction_id)), 2) AS avg_order_value
FROM transactions
GROUP BY hour
ORDER BY hour;

-- 8. Overall Top-3 Hours Contributing the Most of Revenue
SELECT
    HOUR(transaction_time) AS top_3_hours,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    ROUND((SUM(transaction_quantity * unit_price) / (SELECT SUM(transaction_quantity * unit_price) FROM transactions))*100, 2) AS revenue_contribution
FROM transactions
GROUP BY top_3_hours
ORDER BY revenue_contribution DESC
LIMIT 3;

-- 9. Store-Wise Sales/KPIs by Hour of the Day, Finding the Peak Hours for Each Stores
SELECT
    store_location,
    HOUR(transaction_time) AS hour,
    COUNT(DISTINCT transaction_id) AS orders,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    SUM(transaction_quantity) AS quantity_sold,
    ROUND((SUM(transaction_quantity * unit_price) / COUNT(DISTINCT transaction_id)), 2) AS avg_order_value
FROM stores s INNER JOIN transactions t
ON s.store_id = t.store_id
GROUP BY store_location, hour
ORDER BY store_location, hour;


-- 10. Business-Overall Sales/KPIs by Day of the Week, Finding the Busy Weekdays
SELECT
    DAYNAME(transaction_date) AS day,
    COUNT(DISTINCT transaction_id) AS orders,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    SUM(transaction_quantity) AS quantity_sold,
    ROUND((SUM(transaction_quantity * unit_price) / COUNT(DISTINCT transaction_id)), 2) AS avg_order_value
FROM transactions
GROUP BY day
ORDER BY FIELD(day,'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday');

-- 11. Overall Top-3 Weekdays Contributing the Most of Revenue
SELECT
    DAYNAME(transaction_date) AS top_3_weekdays,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    ROUND((SUM(transaction_quantity * unit_price) / (SELECT SUM(transaction_quantity * unit_price) FROM transactions))*100, 2) AS revenue_contribution
FROM transactions
GROUP BY top_3_weekdays
ORDER BY revenue_contribution DESC
LIMIT 3;

-- 12. Store-Wise Sales/KPIs by Day of the Week, Finding the Busy Weekdays for Each Stores
SELECT
    store_location,
    DAYNAME(transaction_date) AS day,
    COUNT(DISTINCT transaction_id) AS orders,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    SUM(transaction_quantity) AS quantity_sold,
    ROUND((SUM(transaction_quantity * unit_price) / COUNT(DISTINCT transaction_id)), 2) AS avg_order_value
FROM stores s INNER JOIN transactions t
ON s.store_id = t.store_id
GROUP BY store_location, day
ORDER BY store_location, FIELD(day, 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday');

-- 13. Business-Overall Monthly Sales/KPI Trends
SELECT
    YEAR(transaction_date) AS year,
    MONTH(transaction_date) AS month_n,
    MONTHNAME(transaction_date) AS month,
    COUNT(DISTINCT transaction_id) AS orders,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    SUM(transaction_quantity) AS quantity_sold,
    ROUND((SUM(transaction_quantity * unit_price) / COUNT(DISTINCT transaction_id)), 2) AS avg_order_value
FROM transactions
GROUP BY year, month_n, month
ORDER BY year, month_n;

-- 14. Business-Overall Month-On-Month Revenue Growth(%) Over The Time
WITH monthly_sales_revenue AS (
    SELECT
        YEAR(transaction_date) AS year,
        MONTH(transaction_date) AS month_n,
        MONTHNAME(transaction_date) AS month,
        SUM(transaction_quantity * unit_price) AS sales_revenue
    FROM transactions
    GROUP BY year, month_n, month
)
SELECT
    year,
    month_n,
    month,
    sales_revenue,
    ROUND(((sales_revenue - LAG(sales_revenue) OVER(ORDER BY year, month_n)) / LAG(sales_revenue) over(ORDER BY year, month_n))*100, 2)
        AS revenue_growth
FROM monthly_sales_revenue
ORDER BY year, month_n;

-- 15. Store-Wise Monthly Sales/KPI Trends
SELECT
    store_location,
    YEAR(transaction_date) AS year,
    MONTH(transaction_date) AS month_n,
    MONTHNAME(transaction_date) as month,
    COUNT(DISTINCT transaction_id) AS orders,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    SUM(transaction_quantity) AS quantity_sold,
    ROUND((SUM(transaction_quantity * unit_price) / COUNT(DISTINCT transaction_id)), 2) AS avg_order_value
FROM stores s INNER JOIN transactions t
ON s.store_id = t.store_id
GROUP BY store_location, year, month_n, month
ORDER BY store_location, year, month_n;

-- PRODUCT PERFORMANCE ANALYSIS:

-- 16. Top [to Least] Selling Products by Quantity Sold, Identifying Best Selling Products
SELECT
    product_detail AS top_selling_products,
    SUM(transaction_quantity) AS quantity_sold
FROM products p INNER JOIN transactions t
ON p.product_id = t.product_id
GROUP BY product_detail
ORDER BY quantity_sold DESC;

-- 17. Top [to Least] Selling Products by Sales Revenue
SELECT
    product_detail AS top_selling_products,
    SUM(transaction_quantity * unit_price) AS sales_revenue
FROM products p INNER JOIN transactions t
ON p.product_id = t.product_id
GROUP BY product_detail
ORDER BY sales_revenue DESC;

-- 18. Monthly Top 2 Best-Selling Products by Quantity Sold, Identifying Seasonal Picks and any Changes in Customers Prefrences over the yeras
WITH monthly_best_sellers AS (
    SELECT
        YEAR(transaction_date) AS year,
        MONTH(transaction_date) AS month_n,
        MONTHNAME(transaction_date) AS month,
        product_detail AS top_selling_product,
        SUM(transaction_quantity) AS quantity_sold,
        RANK() OVER(PARTITION BY YEAR(transaction_date), MONTH(transaction_date) ORDER BY SUM(transaction_quantity) DESC) AS rank_
    FROM transactions t INNER JOIN products p
    ON t.product_id = p.product_id
    GROUP BY year, month_n, month, top_selling_product
)
SELECT
    year,
    month_n,
    month,
    rank_,
    top_selling_product,
    quantity_sold
FROM monthly_best_sellers
WHERE rank_ = 1 or rank_ = 2
ORDER BY year, month_n, quantity_sold DESC;

-- 19. Sales/KPIs by Product Category (Product Category Performance), [Ordered by Revenue]
SELECT
    product_category,
    COUNT(DISTINCT transaction_id) AS orders,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    SUM(transaction_quantity) AS quantity_sold,
    ROUND((SUM(transaction_quantity * unit_price) / COUNT(DISTINCT transaction_id)), 2) AS avg_order_value
FROM products p INNER JOIN transactions t
ON p.product_id = t.product_id
GROUP BY product_category
ORDER BY sales_revenue DESC;

-- 20. Product Type Performance within Each Category
SELECT
    product_category,
    product_type,
    COUNT(DISTINCT transaction_id) AS orders,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    SUM(transaction_quantity) AS quantity_sold,
    ROUND((SUM(transaction_quantity * unit_price) / COUNT(DISTINCT transaction_id)), 2) AS avg_order_value
FROM products p INNER JOIN transactions t
ON p.product_id = t.product_id
GROUP BY product_category, product_type
ORDER BY product_category, sales_revenue DESC;

-- 21. Revenue Contribution(%) by Product Category
SELECT
    product_category,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    ROUND((SUM(transaction_quantity * unit_price) / (SELECT SUM(transaction_quantity * unit_price) FROM transactions))*100, 2) AS revenue_contribution
FROM products p INNER JOIN transactions t
ON p.product_id = t.product_id
GROUP BY product_category
ORDER BY revenue_contribution DESC;


-- 22. Sales/KPIs by Product Size / Product Size Performance, [Ordered by Revenue]
SELECT
    product_size,
    COUNT(DISTINCT transaction_id) AS orders,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    SUM(transaction_quantity) AS quantity_sold,
    ROUND((SUM(transaction_quantity * unit_price) / COUNT(DISTINCT transaction_id)), 2) AS avg_order_value
FROM products p INNER JOIN transactions t
ON p.product_id = t.product_id
GROUP BY product_size
ORDER BY sales_revenue DESC;

-- 23. Revenue Contribution(%) by Product Size
SELECT
    product_size,
    SUM(transaction_quantity * unit_price) AS sales_revenue,
    ROUND((SUM(transaction_quantity * unit_price) / (SELECT SUM(transaction_quantity * unit_price) FROM transactions))*100, 2) AS revenue_contribution
FROM products p INNER JOIN transactions t
ON p.product_id = t.product_id
GROUP BY product_size
ORDER BY revenue_contribution DESC;

-- 24. Customer Order-Quantity Distribution and Revenue Contribution(%)
SELECT
    transaction_quantity AS order_quantity,
    COUNT(DISTINCT transaction_id) AS total_orders,
    SUM(transaction_quantity * unit_price) AS total_sales_revenue,
    ROUND((SUM(transaction_quantity * unit_price) / (SELECT SUM(transaction_quantity * unit_price) from transactions))*100, 2) AS revenue_contribution
FROM transactions
GROUP BY order_quantity
ORDER BY order_quantity;


