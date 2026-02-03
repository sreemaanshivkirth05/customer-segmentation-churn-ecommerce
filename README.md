# 🛒 Customer Segmentation & Churn Prediction for E-commerce

## 📌 Project Overview
This project implements an **end-to-end data analytics and machine learning pipeline** to analyze customer behavior and predict churn risk for an e-commerce platform using transactional data.

The solution combines **SQL-based feature engineering**, **Python-based modeling**, and **business-oriented interpretation** to help identify high-risk customers and actionable churn drivers.

---

## 🧠 Business Problem
Customer churn directly impacts revenue, marketing efficiency, and long-term growth.  
This project aims to answer:

- Which customers are most likely to churn?
- What behavioral patterns drive churn?
- How can the business proactively target at-risk customers?

---

## 📂 Dataset
- **Source:** Online Retail transactional dataset
- **Records:** ~525,000 transactions
- **Customers:** ~4,300 unique customers
- **Timeframe:** 2010–2011
- **Key Fields:** Invoice date, quantity, price, customer ID, product, country

---

## 🏗️ Project Structure

<img src="images/project_structure.png" width="700">



---

## 🔧 Feature Engineering (SQL)

### 1️⃣ RFM & Extended Features
- Recency (days since last purchase)
- Frequency (number of purchases)
- Monetary value
- Customer tenure
- Average order value
- Product diversity
- Average days between purchases

### 2️⃣ Return-Based Features
- Return count
- Return rate
- Indicator for customers with returns

All features were engineered using **PostgreSQL SQL** for scalability and clarity.

---

## 🚨 Churn Definition
Since future purchase data is unavailable, churn is defined as:

> **Customers in the top 30% of recency (least recently active)**

This creates a realistic churn-risk label suitable for supervised learning while avoiding data leakage.

---

## 🤖 Modeling Approach

### Models Used
- **Logistic Regression**
  - High interpretability
  - Clear business insights
- **Random Forest**
  - Captures non-linear customer behavior
  - Higher predictive performance

### Target Leakage Prevention
Recency was used **only for labeling** and explicitly excluded from model features.

---

## 📊 Model Performance

| Model | ROC-AUC |
|-----|--------|
| Logistic Regression | ~0.93 |
| Random Forest | ~0.98 |

---

## 🔍 Key Churn Drivers

### 🔴 Higher Churn Risk
- Longer customer tenure
- Higher return rate
- Longer gaps between purchases

### 🟢 Lower Churn Risk
- Higher purchase frequency
- Greater product diversity
- Consistent purchasing behavior
- Higher lifetime spend

**Insight:** Engagement patterns matter more than spending alone.

---

## 📈 Visualizations
- ROC curve comparison
- Confusion matrices
- Feature importance plots
- Churn probability distributions

---

## 📊 Power BI Dashboard
A Power BI dashboard can be built using the scored dataset to:
- Identify high-risk customers
- Analyze churn drivers by segment
- Support retention campaigns

---

## 🧰 Tools & Technologies
- SQL (PostgreSQL)
- Python (pandas, scikit-learn, matplotlib)
- Jupyter Notebook
- Git & GitHub
- Power BI

---

## 📌 Key Takeaways
- Built a complete analytics → ML pipeline
- Prevented target leakage
- Balanced interpretability and performance
- Delivered business-ready churn insights

---

## 🚀 Future Enhancements
- Cost-based churn optimization
- Time-based validation
- Automated churn scoring pipeline
- Model deployment

---

## 👤 Author
**Sreemaan Shivkirth**  
MS Computer Science (AI/ML) | Data Analyst
>>>>>>> 1eef0ea (Add project structure image to README)
