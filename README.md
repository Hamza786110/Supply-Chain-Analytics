# 📦 Supply Chain Analytics

An end-to-end supply chain analytics project built on a real-world Brazilian e-commerce dataset (~89,000 records). The project spans data cleaning in Python, KPI computation in Google BigQuery SQL, and an interactive Power BI dashboard for business insight.

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Project Structure](#-project-structure)
- [Dataset](#-dataset)
- [Data Cleaning](#-data-cleaning)
- [SQL Insights & KPIs](#-sql-insights--kpis)
- [Power BI Dashboard](#-power-bi-dashboard)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)

---

## 🔍 Project Overview

This project analyzes supply chain performance across five interconnected datasets — customers, orders, order items, payments, and products. The goal is to surface actionable KPIs (such as OTIF, fill rates, and cancellation rate) and visualize them in an easy-to-consume dashboard.

**Key questions answered:**
- How efficiently are orders being fulfilled and delivered on time?
- What is the cancellation rate and how many orders are pending delivery?
- Which product categories drive the most orders?
- How do customers prefer to pay?

---

## 📁 Project Structure

```
Supply-Chain-Analytics/
│
├── Original Data/                            # Raw input datasets
│   ├── df_Customers.csv
│   ├── df_OrderItems.csv
│   ├── df_Orders.csv
│   ├── df_Payments.csv
│   └── df_Products.csv
│
├── Cleaned Data/                             # Cleaned & UTF-8 encoded outputs
│   ├── cleaned_customer_data_utf8.csv
│   ├── cleaned_order_items_utf8.csv
│   ├── cleaned_orders_data_utf8.csv
│   ├── cleaned_payments_data_utf8.csv
│   └── cleaned_products_data_utf8.csv
│
├── Insights using SQL/                       # BigQuery SQL queries
│   ├── KPI values .sql
│   ├── cancellation rate .sql
│   ├── orders not delivered.sql
│   ├── total payments done by each type.sql
│   └── Top product category with maximum orders .sql
│
├── Dashboard/                                # Power BI dashboard
│   ├── supply chain.pbix
│   └── supply image.png
│
└── Supply Chain analysis.ipynb               # Python notebook — EDA & cleaning
```

---

## 🗃️ Dataset

Five relational tables with approximately **89,000 rows each**, representing a complete order-to-delivery pipeline.

| Table | Columns | Description |
|---|---|---|
| **Customers** | `customer_id`, `customer_zip_code_prefix`, `customer_city`, `customer_state` | Customer location info |
| **Orders** | `order_id`, `customer_id`, `order_status`, `order_purchase_timestamp`, `order_approved_at`, `order_delivered_timestamp`, `order_estimated_delivery_date` | Full order lifecycle |
| **Order Items** | `order_id`, `product_id`, `seller_id`, `price`, `shipping_charges` | Line-level order details |
| **Payments** | `order_id`, `payment_sequential`, `payment_type`, `payment_installments`, `payment_value` | Payment method & value |
| **Products** | `product_id`, `product_category_name`, `product_weight_g`, `product_length_cm`, `product_height_cm`, `product_width_cm` | Product metadata & dimensions |

---

## 🧹 Data Cleaning

Performed in `Supply Chain analysis.ipynb` using **Pandas** and **NumPy**.

### Handling Missing Values

**Orders table** — Missing `order_delivered_timestamp` values were handled based on order status:

| Order Status | Nulls | Strategy |
|---|---|---|
| `canceled` | 404 | Rows dropped — will never be delivered |
| `unavailable` | 2 | Rows dropped |
| `shipped` | 936 | Filled with `order_estimated_delivery_date` |
| `processing` | 273 | Filled with `order_estimated_delivery_date` |
| `approved` | 2 | Filled with `order_estimated_delivery_date` |
| `invoiced` | 266 | Filled with `order_estimated_delivery_date` |
| `delivered` | 6 | Filled with `order_estimated_delivery_date` |

Rows with a null `order_approved_at` were also dropped entirely.

**Products table** — Missing `product_category_name` values were filled with `'Unknown'`. Missing dimensional attributes (`weight`, `width`, `height`, `length`) were imputed using the **median value per product category** to preserve distribution integrity.

### Encoding Fix
Raw files contained characters incompatible with UTF-8. Data was re-imported using **Latin-1** encoding and then exported as clean **UTF-8** CSVs for downstream compatibility with BigQuery and Power BI.

### Exploratory Insights
- Identified **top 5 and bottom 5 cities** by customer volume
- Calculated **average shipping charge** and **average product price** (in BRL)
- Explored all unique `order_status` values across the dataset

---

## 📊 SQL Insights & KPIs

All queries were written for **Google BigQuery** against the `supplychain` dataset.

### Core KPIs — `KPI values .sql`

| KPI | Definition |
|---|---|
| **Total Order Lines** | Total count of all individual line items across all orders |
| **Line Fill Rate** | % of order lines that were successfully delivered |
| **Volume Fill Rate** | % of total order value (price) that was delivered |
| **Total Orders** | Count of distinct orders placed |
| **On Time Delivery %** | % of delivered orders that arrived on or before the estimated delivery date |
| **In Full Delivery %** | % of all orders that reached `delivered` status |
| **On Time In Full (OTIF) %** | % of all orders that were both delivered and on time |

> Decimal KPIs are multiplied by 100 and rounded to 2 decimal places.

### Additional Queries

| File | Insight |
|---|---|
| `cancellation rate .sql` | Percentage of total orders that were cancelled |
| `orders not delivered.sql` | Count of orders where `order_status != 'delivered'` |
| `total payments done by each type.sql` | Number of customers grouped by payment method (credit card, boleto, voucher, etc.) |
| `Top product category with maximum orders .sql` | Product category with the highest number of distinct delivered orders |

---

## 📈 Power BI Dashboard

The `supply chain.pbix` dashboard provides an interactive view of all KPIs and trends.

**Dashboard highlights:**
- KPI cards for OTIF %, On-Time Delivery %, Line Fill Rate, and Volume Fill Rate
- Order status breakdown
- Payment method distribution
- Top product categories by order volume
- Delivery performance over time

![Dashboard Preview](Dashboard/supply%20image.png)

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| **Python** (Pandas, NumPy, Matplotlib, Seaborn) | Data cleaning & exploratory analysis |
| **Jupyter Notebook** | Interactive analysis environment |
| **Google BigQuery** | Cloud SQL for KPI computation at scale |
| **Power BI Desktop** | Dashboard & data visualization |

---

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/Hamza786110/Supply-Chain-Analytics.git
cd Supply-Chain-Analytics
```

### 2. Run the Jupyter Notebook
Install dependencies and open the notebook:
```bash
pip install pandas numpy matplotlib seaborn
jupyter notebook "Supply Chain analysis.ipynb"
```
> **Note:** Update the file export paths in the last cell to match your local directory before running.

### 3. Load Data into BigQuery
Upload the cleaned CSVs from `Cleaned Data/` to your BigQuery project. Then update the project and dataset references in the SQL files — replace:
```
`sacred-particle-471715-e3`.`supplychain`
```
with your own:
```
`your-project-id`.`your-dataset-name`
```

### 4. Open the Power BI Dashboard
Open `Dashboard/supply chain.pbix` in **Power BI Desktop** and update the data source to point to your cleaned CSV files or BigQuery connection.

---

## 👤 Author

**Hamza** — [GitHub](https://github.com/Hamza786110)
