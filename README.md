# Brew Haven: The Café - Sales Analysis

### Overview and Objective
This project involves developing an interactive Excel dashboard aimed at analyzing and extracting valuable insights from a comprehensive dataset containing over 145,000 sales transactions from **Brew Haven: The Café**. The dataset, spanning from January 1, 2023, to June 30, 2023, was sourced from the [Maven Analytics Data Playground](https://mavenanalytics.io/data-playground?pageSize=all) and is included in the `Dataset.csv` file within this repository.

The primary objective of this project is to utilize advanced Excel features to conduct a thorough analysis of café sales data, visualise the analysis, and derive actionable insights and key performance indicators (KPIs) that can significantly enhance the operational efficiency and revenue performance of **Brew Haven: The Café**.


### Dataset Description
The raw dataset includes the following columns:
- `transaction_id`: Unique identifier for each transaction
- `transaction_date`
- `transaction_time`
- `transaction_qty`: Quantity of items in the transaction
- `store_id`: Unique identifier for each store
- `store_location`
- `product_id`: Unique identifier for each product
- `unit_price`: Price per unit of the product
- `product_category`
- `product_type`
- `product_detail`: Additional details about the product (e.g., size, flavour)


### Data Cleaning and Transformation
To ensure data accuracy and facilitate analysis, the raw data was cleaned and transformed using Power Query Editor. Key steps included:
- Extracting and categorising product sizes from the `product_detail` column to enhance product-level analysis.
- Trimming and standardising the `product_detail` column for consistency across records.
- Creating a `total order amount` column using conditional columns tool to calculate the monetary value of each transaction.
- Extracting and organizing time-based data by generating new columns for month names, day names, day numbers, and month numbers, improving the sorting and analysis of sales trends.
- Correcting and standardizing date and time formats to ensure accuracy in reporting and analysis.


### Data Modelling and Analysis
Post-cleaning, the data was integrated into the Excel data model, enabling the creation of pivot tables and KPIs. These were then used to construct an interactive dashboard designed to address several key business questions:
- What are the sales patterns by day of the week and hour of the day?
- When are the peak sales or revenue times?
- What is the total sales revenue for each month?
- How do sales vary across different store locations?
- What is the average revenue per order?
- Which products are the top performers in terms of quantity and revenue?
- How do sales compare across different product categories and types?


### Dashboard Features & Components
The interactive dashboard is equipped with the following elements to facilitate in-depth analysis visualisation and decision-making:
- **Pivot Charts:**
  1. Hourly sales trends across store locations
  2. Weekday sales trends across store locations
  3. Monthly sales revenue trends across store locations
  4. Total customer footfall and sales revenue across store locations
  5. Revenue distribution by product categories
  6. Top 5 revenue-generating product types
  7. Revenue distribution by product size

- **KPI Measures:**
  1. Total sales revenue
  2. Total customer footfall
  3. Average order value per customer
  4. Average order quantity per customer

- **Slicers:**
  - Month name (for filtering data by specific months)


### Final Snapshot of the Dashboard
![Dashboard_Snapshot](https://github.com/bhavdipzala/Coffee_Shop_Sales_Analysis_Excel_Dashboard/blob/main/dashboard_snapshot.jpg)


### Insights and Impact

This Excel dashboard enables stakeholders to effectively visualise and analyse sales data, uncover critical sales trends, identify key performance indicators, and make informed decisions. The detailed, actionable insights derived from this analysis have the potential to drive a 30% increase in sales revenue through optimized product offerings, staffing, and marketing strategies, ultimately enhancing the overall business performance of The Café.
