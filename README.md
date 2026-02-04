# 🛒 Customer Segmentation & Churn Prediction for E-commerce

## 📌 Project Overview

This project implements a **full end-to-end data analytics and machine learning pipeline** to identify customers at risk of churn in an e-commerce business using **transaction-level purchase data**.

The solution combines:

- **SQL-based data cleaning and feature engineering**
- **RFM and extended behavioral feature modeling**
- **Return-behavior analysis**
- **Business-driven churn labeling**
- **Supervised machine learning models (Logistic Regression, Random Forest)**
- **Model evaluation using ROC-AUC and classification metrics**
- **Actionable customer risk scoring**
- **Power BI dashboard for business users**

The objective is to transform **raw transactional data → customer intelligence → churn risk predictions → business actions**.

---

## 💼 Business Problem

Customer churn directly impacts:

- Revenue growth
- Marketing efficiency
- Customer lifetime value
- Retention strategy effectiveness

This project aims to answer:

- Which customers are **most likely to churn**?
- What **behavioral signals** indicate churn risk?
- How can the business **intervene early** to retain high-risk customers?

Instead of relying on intuition, this project builds a **data-driven churn prediction system**.

---

## 📊 Dataset Description

- **Source:** Online Retail transactional dataset  
- **Records:** ~525,000 transactions  
- **Customers:** ~4,300 unique customers  
- **Timeframe:** 2010–2011  
- **Granularity:** Transaction-level purchases  
- **Key Fields:**  
  - Invoice date  
  - Quantity  
  - Price  
  - Customer ID  
  - Product (StockCode, Description)  
  - Country  

Each row represents a **single product purchase within an invoice**.

---

## 🏗️ Project Structure
```
customer-segmentation-churn-ecommerce/
├── data/ 
│ ├── raw/
│ └── processed/
├── sql/
│ ├── schema.sql
│ ├── cleaning.sql
│ ├── rfm_base.sql
│ ├── extended_rfm.sql
│ ├── return_features.sql
│ ├── churn_label.sql
│ └── final_customer_features.sql
├── notebooks/
│ ├── 01_data_validation.ipynb
│ └── 02_churn_modeling.ipynb
├── images/
├── README.md
└── .gitignore
```
---


---

## 🧹 Data Cleaning (SQL)

Data cleaning is performed in **PostgreSQL** to simulate a real production analytics environment.

Key steps:

- Remove transactions with missing `customer_id`
- Handle invalid or zero-priced transactions
- Normalize data types (dates, numeric fields)
- Filter canceled invoices where applicable
- Create a clean transactional table for feature engineering

This ensures **all downstream features are computed on reliable data**.

---

## 🛠️ Feature Engineering (SQL)

All features are engineered in SQL for:

- Scalability
- Reproducibility
- Real-world data engineering realism

### 1️⃣ RFM Features

For each customer:

- **Recency (R):**  
  Number of days since the last purchase relative to a reference date  

- **Frequency (F):**  
  Total number of transactions  

- **Monetary (M):**  
  Total spend across all transactions  

These capture:
- How recently a customer purchased
- How often they purchase
- How valuable they are

---

### 2️⃣ Extended Behavioral Features

Beyond classic RFM, we compute:

- **Customer tenure:**  
  Days since first purchase  

- **Average order value (AOV):**  
  Monetary / Frequency  

- **Product diversity:**  
  Number of unique products purchased  

- **Average days between purchases:**  
  Measures purchase regularity and engagement stability  

These features capture:
- Customer maturity
- Spending patterns
- Breadth of engagement
- Behavioral consistency

---

### 3️⃣ Return-Based Features

Returns often signal **customer dissatisfaction or friction**.

We engineer:

- **Return count:** Number of negative/return transactions  
- **Return rate:** Returns / total transactions  
- **Has returned:** Binary indicator for return behavior  

These features add a **customer experience and risk dimension** to the model.

---

## 🚨 Churn Label Definition

Churn is defined using a **business-driven inactivity rule**:

- A customer is labeled **churned (1)** if they **do not make any purchase in a defined future time window** after their last observed transaction.
- Otherwise, they are labeled **active (0)**.

This converts an **unsupervised behavioral problem** into a **supervised classification problem** aligned with real retention use cases.

---

## 🧩 Final Modeling Dataset

All engineered features are joined into a single **customer-level modeling table** containing:

- RFM features
- Extended behavioral features
- Return behavior features
- Churn label (target variable)

This table represents **one row per customer** and is exported for modeling in Python.

---

## 🤖 Modeling Approach (Python)

### Models Used

1. **Logistic Regression**
   - Interpretable baseline model
   - Coefficients explain feature impact direction and strength

2. **Random Forest**
   - Non-linear model
   - Captures complex interactions between features
   - Provides feature importance rankings

---

## 📈 Model Evaluation

Models are evaluated using:

- **ROC-AUC** (overall ranking quality)
- **Precision, Recall, F1-score**
- **Confusion Matrix**

The Random Forest achieves higher ROC-AUC, while Logistic Regression provides **clear interpretability** of churn drivers.

---

## 🔍 Feature Importance & Interpretation

Key insights:

- **Tenure, frequency, and purchase regularity** are strong churn predictors
- Customers with **low frequency and long gaps between purchases** are higher risk
- **Product diversity** and **consistent engagement** reduce churn probability
- **Return behavior** provides early warning signals of dissatisfaction

---

## 📊 Business Value

This system enables the business to:

- Identify **high-risk customers before they leave**
- Prioritize **retention campaigns**
- Personalize **offers and interventions**
- Improve **customer lifetime value**
- Optimize **marketing spend**

---

## 📊 Power BI Dashboard

The Power BI dashboard provides:

- Churn vs active customer distribution
- Risk segmentation views
- Feature-driven churn insights
- High-risk customer lists for action
- Interactive exploration for business users

---

## 🚀 How to Run the Project (Step-by-Step)

This project uses **PostgreSQL for feature engineering** and **Python for modeling**. Follow the steps below to reproduce the full pipeline from raw data to churn predictions.

---

### Prerequisites

Make sure you have the following installed:

- Git
- PostgreSQL (and pgAdmin)
- Python 3.9 or higher
- Jupyter Notebook or VS Code
- Power BI Desktop (optional, for dashboard)

Python libraries required:

- pandas
- numpy
- scikit-learn
- matplotlib
- seaborn

Install them using:

```
pip install pandas numpy scikit-learn matplotlib seaborn jupyter
```
#### 1. Clone the Repositary
```
git clone https://github.com/<your-username>/customer-segmentation-churn-ecommerce.git
cd customer-segmentation-churn-ecommerce
```

#### 2. Setup PostgreSQL Database
1. Open pgAdmin
2. Create a new database 
3. Open the Query Tool and run the SQL files in this exact order.
```
sql/schema.sql
sql/cleaning.sql
sql/rfm_base.sql
sql/extended_rfm.sql
sql/return_features.sql
sql/churn_label.sql
sql/final_customer_features.sql

```
#### 3. Export Final Dataset from PostgreSql
In pgAdmin:
1. Locate the final table
2. Right click the table and export it.
3. Export it as CSV to:
```
data/processed/modeling_dataset.csv
```
#### 4. Setup the Python Environment
It is recommended to use a virtual environment to keep dependicies isolated.

#### 5. Run the Data Validation Notebook
1. Start Jupyter Notebok
2. Open the following Notebook:
```
notebooks/01_data_validation.ipynb
```
3. Run all the cells from top to bottom.

#### 6. Run the CHurn Modeling Notebook
1. Open:
```
notebooks/02_churn_modeling.ipynb
```
2. Run all the cells from top to bottom.
3. Export the scored dataset to:
```
data/processed/churn_scored_customers.csv
```


---

## 🧠 Skills Demonstrated

- SQL data modeling and feature engineering
- RFM and behavioral analytics
- Business-driven churn definition
- Supervised machine learning (Logistic Regression, Random Forest)
- Model evaluation and interpretation
- Data storytelling and dashboarding
- End-to-end analytics pipeline design

---

