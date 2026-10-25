# BharatKart E-commerce Data Analysis

An end-to-end e-commerce data analysis project using **MySQL** for data cleaning and business analysis, and **Power BI** for interactive data visualization.

## Project Overview

The goal of this project is to prepare e-commerce data for analysis, investigate business questions using SQL, and present key metrics through a Power BI dashboard.

## Tools Used

- **MySQL** — Data cleaning, SQL queries, joins, aggregations, and business analysis
- **Power BI** — Dashboard development and data visualization

## Project Workflow

1. Inspected and cleaned the source data using SQL.
2. Investigated data quality issues, including missing values, duplicates, and invalid records where applicable.
3. Used SQL queries to answer business questions about revenue, profit, products, customers, payments, and orders.
4. Built a Power BI dashboard to visualize key performance indicators and category-level trends.

## Repository Structure

```text
BharatKart-SQL-PowerBI-Analysis/
├── sql/
│   ├── products.sql
│   ├── order_items_nd_order_items_clean.sql
│   ├── orders_nd_orders_clean.sql
│   ├── customer.sql
│   └── reviews.sql
├── powerbi/
│   └── BharatKart.pbix
├── screenshots/
│   ├── dashboard_overview.png
│   ├── profit_cost_analysis.png
│   └── category_payment_state_analysis.png
└── README.md
```

## Dashboard Preview

### Page 1 — Business Overview

Revenue, gross profit, total orders, average order value, revenue trends, and category performance.

![Dashboard Overview](screenshots/dashboard_overview.png)

### Page 2 — Profit and Cost Analysis

Comparison of profit and cost across product categories.

![Profit and Cost Analysis](screenshots/profit_cost_analysis.png)

### Page 3 — Category and Order Analysis

Profit margins by category, revenue by payment method and state, and order-status distribution.

![Category and Order Analysis](screenshots/category_payment_state_analysis.png)

## Key Metrics

The current dashboard displays approximately:

- **Total Revenue:** ₹50.27 million
- **Gross Profit:** ₹10.01 million
- **Total Orders:** 10K
- **Average Order Value:** ₹4.88K

*Values reflect the current Power BI report and may change with filters or data updates.*

## What I Learned

- Cleaning and validating data with SQL
- Writing queries for business analysis
- Connecting MySQL data to Power BI
- Designing dashboards to communicate business metrics

## Files

- SQL scripts: `sql/`
- Power BI report: `powerbi/BharatKart.pbix`
- Dashboard screenshots: `screenshots/`

---

**Author:** Srijan Kumar
