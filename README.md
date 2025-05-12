## Project Overview

This project is a comprehensive sales analysis of **Brew Haven: The Cafe**, using a raw transactional dataset sourced from Kaggle. The analysis was conducted in two parts: **SQL for data cleaning, transformation, and exploratory data analysis (EDA)**, followed by **Power BI for data modelling, dashboard creation, and business insights delivery**.

The dataset consists of **149,116 retail transactions** recorded over a **six-month period (January 1, 2023 – June 30, 2023)** across three store locations. The goal of this project was to uncover sales patterns, customer behaviour, and product performance in order to support data-driven decision-making for operational improvement and strategic planning.

---

## Problem Statement

The primary objective of this project is to analyse the coffee shop's transactional sales data to uncover meaningful insights that can help improve business performance across all store locations. By leveraging data-driven analysis, the aim is to identify key trends, patterns, and opportunities that can inform strategic decisions related to operations, marketing, and product offerings.

Key business questions addressed in this project include:

* **How do sales vary by day of the week and hour of the day?**
  Are there specific days or time slots that generate peak sales activity?

* **Are there identifiable peak sales hours across locations?**
  Can staff scheduling and promotions be optimised based on these trends?

* **What is the total sales revenue for each month?**
  Are there any noticeable month-on-month growth trends?

* **How do sales perform across different store locations?**
  Are there differences in sales patterns between outlets?

* **Which products are the best sellers in terms of quantity and revenue?**
  Can we identify top-performing products that drive most of the sales?

* **How do product categories and sizes influence sales performance?**
  Are certain product types or sizes more profitable than others?

---


## About the Dataset

The dataset used in this project was sourced from [Kaggle: Coffee Shop Sales](https://www.kaggle.com/datasets/ahmedabbas757/coffee-sales), and contains detailed sales transaction records over a six-month period from **January 1, 2023, to June 30, 2023**.

It consists of **149,116 rows**, each representing a single sales transaction, captured across **three store locations**. The dataset is in a **single-table format**, with the following fields:

| Column Name        | Description                                              |
| ------------------ | -------------------------------------------------------- |
| `transaction_id`   | Unique sequential ID for each transaction                |
| `transaction_date` | Date of the transaction                                  |
| `transaction_time` | Time of the transaction                                  |
| `transaction_qty`  | Quantity of items sold in the transaction                |
| `store_id`         | Unique ID for the store where the transaction took place |
| `store_location`   | Location name of the store                               |
| `product_id`       | Unique ID of the product sold                            |
| `unit_price`       | Retail price of the product sold                         |
| `product_category` | Category of the product                                  |
| `product_type`     | Type of product                                          |
| `product_detail`   | Description of the product                               |

While the original dataset is flat and denormalised, it offers rich information about customer purchasing behaviour, store performance, and product-level trends. Before analysis, this data was imported into **MySQL**, where it underwent extensive cleaning, transformation, and normalisation into a relational schema to ensure data integrity and facilitate efficient querying.


---

## Methodology

The project is divided into a two-part analytical process: **ETL & Exploratory Data Analysis using SQL**, followed by **data modelling and interactive dashboard development in Power BI**.

### SQL – ETL Process & Exploratory Data Analysis

The raw dataset(.csv file) was imported into a MySQL database using the `LOAD DATA INFILE` command into a staging table named `raw_dataset`. Before exploratory Data analysis, several data **cleaning and transformation** steps were applied:

* Removed carriage return (CHAR(13)) from the `product_detail` column to eliminate hidden line breaks characters.
* The flat data was **normalised** into three tables—`transactions`, `products`, and `stores`, to reduce redundancy and improve query efficiency.
* Added primary and foreign key constraints to maintain referential integrity and eliminate redundancy.
* Corrected the date formats using the `STR_TO_DATE` function.
* Extracted product size (e.g., Small, Regular, Large) from the `product_detail` column and stored it in a new `product_size` column.
* Cleaned `product_detail` column by removing size abbreviations (e.g., "Lg", "Rg").

Once cleaned and transformed, detailed SQL Exploratory Data Analysis was performed to understand key trends and patterns. In doing so, `CTEs`, `JOINs`, `GROUP BY`, date functions, and aggregation techniques were used to analyse sales across various dimensions such as category, time, location etc.

### Power BI – Data Modelling & Dashboard Development

After completing the SQL analysis, the normalised dataset was brought into Power BI using MySQL connector.
* In Power Query Editor, imported tables were renamed to `fact_transactions`, `dim_products`, and `dim_stores`.
* Defined and configured 1-to-many relationships between dimension and fact tables, and a star schema was then created.
* Created a custom `Date_Table` to enable time-intelligent functions (fields include date, month, month_name, day, weekday, weekday_name, year, etc.)
* Created 25+ **DAX measures** to develop **custom KPIs and dynamic calculations** such as MoM %Change of KPIs, Conditional highlights for KPI direction (green/red based on trends), dynamic metric toggles (to analyse sales based on Total Sales Revenue, Orders, Quantity Sold), etc.


---

## Dashboard Overview & Features

### **Final Dashboard Snapshot**
[Dashboard Snapshot](Dashboard_Snapshot.jpg)


### **Components & Features**

The dashboard is organised into multiple panels, each offering targeted insights:

#### **KPI Panel**

* **Total Orders**
* **Total Sales Revenue**
* **Average Order Value**
* **Average Quantity Ordered**
* Below each KPI:

  * **Month-over-Month % change** (with color-coded indicators)
  * **Absolute value difference**

#### **Filters / Slicers Panel**

* Select **Year**
* Select **Month(s)**
* Select **Store(s)**
* **Metric Selector**: Choose to analyse the dashboard by:

  * `Sales Revenue`, `Orders`, or `Quantity Sold`

(Any combination of year, month, store, and metric can be selected, and all charts dynamically update based on this selection.)

#### **Time-Based Analysis & Trends**

1. **Sales by Day of the Month**

   * Column chart with average line and tooltip KPIs
2. **Hourly Sales Trend Across Store Locations**

   * Multi-line chart comparing locations
3. **Sales by Weekday**

   * Column chart with weekday labels and average trend line
4. **Monthly Sales Trend Over the Year**

   * Column chart tracking monthly sales growth
5. **Sales: Weekdays vs Weekends**

   * Doughnut chart showing distribution

#### **Product Performance & Revenue Drivers**

1. **Best to Least Performing Products**

   * Horizontal bar chart, sorted descending
2. **Top 5 best-performing Product Categories**

   * Treemap chart highlighting category size
3. **Sales by Product Size**

   * Pie chart showing size-wise contribution

#### **Store-Level Comparison**

* **Sales Across Store Locations**

  * Doughnut chart comparing the performance of all 3 stores


---


## Key Insights & Findings

The following insights are derived from six months of sales data (January–June 2023). The analysis was performed using SQL and visualised in Power BI, with metrics primarily focused on **Total Sales Revenue**.

> *Note: Insights are based on aggregated data. Month-by-month trends or promotional campaigns may introduce variability not reflected in the high-level findings.*


### 🕒 **Time-Based Sales Trends**

#### 1. **Peak Sales Hours Across Store Locations**

* All three stores experience **peak sales between 7 AM and 10 AM**, confirming strong morning demand.
* After 10 AM, a **significant decline in sales** occurs, stabilizing until 5 PM:

  * **Hell's Kitchen** and **Lower Manhattan**: Continuous drop after 5 PM.
  * **Astoria**: Maintains **steady sales** into the evening, unlike other locations.

#### 2. **Weekday Sales Patterns**

* **Hell's Kitchen**:

  * Highest revenue on **Tuesdays** and **Fridays**.
  * Lowest on **Saturdays**.
* **Lower Manhattan**:

  * Peak on **Mondays**, drop on **Sundays**.
* **Astoria**:

  * High performance on **Monday, Wednesday, and Thursday**.
  * Lowest on **Tuesday and Saturday**.
* Aggregated trend: **Monday** is the **highest-performing day**, **Saturday** the lowest across all locations.

#### 3. **Monthly Revenue Growth**

* Revenue showed **consistent upward momentum** from **January (\$82K)** to **June (\$166K)**.
* Sales effectively **doubled over the six-month period**, suggesting growing popularity or increased footfall.

#### 4. **Weekdays vs Weekends**

* **72%** of sales come from **weekdays**, while **weekends contribute only 28%**.
* Weekdays are clearly the business's revenue core.


### **Product Performance & Revenue Drivers**

* **Top-Selling Products** which consistently drive high revenue include Ethiopia, Organic Grown Coffee, Jamaican Coffee Latte, and Brazilian.

* **Coffee** is the leading product category, followed by Tea, Bakery, Drinking Chocolate, and Coffee Beans.

* **Large** size generates the most of the revenue, closely followed by **Regular**. **Small** size contributes only a minimal share.


### **Store-Level Sales Distribution**

* All three stores contribute almost **equally**, each accounting for **\~32–33%** of total sales, indicating balanced performance and no outlier in underperformance or dominance.



---


## Recommendations


#### 1. Optimise Non-Peak Hour Sales

* **Problem**: Significant sales drop after morning hours (post-10 AM).
* **Recommendation**: Introduce time-limited offers, lunch-hour combos, or targeted campaigns between **11 AM and 5 PM**, especially at **Hell’s Kitchen** and **Lower Manhattan**.

#### 2. Boost Weekend Traffic

* **Problem**: **Saturdays** show the lowest sales across all stores.
* **Recommendation**: Launch **weekend specials**, or small event tie-ins (e.g., music, book clubs) to improve footfall.

#### 3. Promote Best-Selling Items

* **Opportunity**: Products like **Ethiopia** and **Jamaican Coffee Latte** consistently drive revenue.
* **Recommendation**: Highlight these products by digital promotions to further maximise their impact.

#### 4. Upsell Larger Sizes

* **Observation**: **Large-sized products** generate the highest revenue.
* **Recommendation**: Train staff to promote upsizing or introduce bundled discounts on larger sizes.

#### 5. Maintain Balanced Store Operations

* **Insight**: All store locations contribute nearly equally to total revenue.
* **Recommendation**: Maintain consistent operational standards and customer experience across locations to sustain this balance.
