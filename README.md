# Coffee Shop Sales Analysis Excel Dashboard

### Overview
The project involves creating an interactive Excel dashboard to analyze and gain insights from a dataset containing coffee shop sales transactions. The dataset, which consists of around 150,000 sales transactions recorded over a period of six months, from January 1, 2023, to June 30, 2023, was obtained from the [Maven Analytics](https://mavenanalytics.io/data-playground?pageSize=all) site and can be accessed from the `Dataset.csv` file of this Repository.

The main objective of this project is to analyze retail sales data to derive actionable insights that will enhance the performance of the coffee shop.


### Dataset Description
The raw dataset includes the following columns:
- `transaction_id:` Unique identifier for each transaction
- `transaction_date`
- `transaction_time`
- `transaction_qty`
- `store_id`
- `store_location`
- `product_id`
- `unit_price`
- `product_category`
- `product_type`
- `product_detail`


### Data Cleaning and Transformation
Using the Excel Power Query Editor, the raw data was cleaned and transformed as follows:
- **Extracted and separated product sizes** from the `product_detail` column.
- **Trimmed the `product_detail` column** for consistency.
- **Added a `total order amount` column** using conditional columns.
- **Extracted month names and day names** for further analysis.
- **Added day numbers of the week and month numbers** to sort pivot tables by day and month names.
- **Corrected date and time formats** for accuracy.


### Data Modelling and Analysis
After cleaning the data, it was loaded into the Excel data model and worksheet. Various pivot tables and Key Performance Indicator (KPI) measures were created using Power Pivot tools and the data model. These pivot tables and KPI measures were then used to develop an interactive dashboard to gain insights based on the following problem statements:
- How do sales vary by day of the week and hour of the day?
- Are there any peak times for sales activity?
- What is the total sales revenue for each month?
- How do sales vary across different store locations?
- What is the average price per order per person?
- Which products are the best-selling in terms of quantity and revenue?
- How do sales vary by product category and type?


### Dashboard Features
The interactive dashboard includes the following components:
- **Pivot Charts:**
  1. Hourly sales($) trend across store locations
  2. Sales($) trend by weekdays across store locations
  3. Monthly sales revenue($) across store locations
  4. Total customer footfall and sales revenue($) across store locations
  5. Total revenue distribution by product categories
  6. Top 5 revenue($) generating product types
  7. Total revenue distribution by product size

- **KPI Measures:**
  1. Total sales revenue
  2. Total customer footfall
  3. Average order amount per customer
  4. Average order quantity per customer

- **Slicer:**
  - Month name (for filtering results by month)


### Final Snapshot of the Dashboard
![Dashboard_Snapshot](https://github.com/bhavdipzala/Coffee_Shop_Sales_Analysis_Excel_Dashboard/blob/main/dashboard_snapshot.jpg)

This Excel dashboard **enables stakeholders** to visualize and analyze sales data effectively, provides a clear overview of sales trends, identifies key performance indicators, and supports informed decision-making to optimize sales strategies and improve overall business performance.
