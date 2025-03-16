# SQL-Case-Study-E-commerce-Sales-Analysis

# 🛒 E-commerce Sales Analysis – SQL Case Study  

## 📌 Overview  
This project analyzes e-commerce sales data using SQL to extract key business insights. The dataset includes transaction details such as customer demographics, product categories, purchase amounts, and payment methods.  

## 📊 Key Business Questions Answered  
1. **Top 5 Most Purchased Products** – Identify the best-selling products.  
2. **Customer Retention Rate** – Measure the percentage of returning customers.  
3. **RFM Analysis** – Find high-value customers based on Recency, Frequency, and Monetary value.  
4. **Churn Analysis** – Identify inactive customers who haven’t purchased in 6 months.  
5. **Total Revenue by Country** – Discover which countries generate the most revenue.  
6. **Peak Sales Hours** – Determine the best time for sales.  
7. **Average Purchase Amount by Age Group** – Analyze spending patterns across age groups.  

## 💻 SQL Queries & Insights  

### 1️⃣ Top 5 Most Purchased Products  
```sql
SELECT Product_Category, COUNT(*) AS Total_Purchases  
FROM transactions  
GROUP BY Product_Category  
ORDER BY Total_Purchases DESC  
LIMIT 5;
```
**Insight:** Identifies best-selling products for inventory planning.  

### 2️⃣ Customer Retention Rate  
```sql
SELECT 
  COUNT(DISTINCT User_Name) AS Total_Customers,
  COUNT(DISTINCT CASE WHEN User_Name IN 
    (SELECT User_Name FROM transactions GROUP BY User_Name HAVING COUNT(*) > 1) 
    THEN User_Name END) AS Returning_Customers,
  ROUND(
    (COUNT(DISTINCT CASE WHEN User_Name IN 
      (SELECT User_Name FROM transactions GROUP BY User_Name HAVING COUNT(*) > 1) 
      THEN User_Name END) * 100.0) 
    / COUNT(DISTINCT User_Name), 2) AS Retention_Rate
FROM transactions;
```
**Insight:** Helps measure customer loyalty.  

### 3️⃣ Total Revenue by Country  
```sql
SELECT Country, SUM(Purchase_Amount) AS Total_Revenue  
FROM transactions  
GROUP BY Country  
ORDER BY Total_Revenue DESC;
```
**Insight:** Identifies high-revenue countries for market expansion.  


## 📂 Project Structure  
```
📁 E-commerce-Sales-Analysis  
│── 📜 README.md  
│── 📜 e_commerce_sales_analysis.sql  
│── 📜 SQL_Insights.pdf  
│── 📜 Dataset.csv  
```

## 🚀 How to Use  
1. **Import the dataset** into your SQL database.  
2. **Run the queries** provided in `e_commerce_sales_analysis.sql`.  
3. **Analyze the results** to gain valuable business insights.  

## 🤝 Contributing  
Feel free to fork the repo, submit pull requests, or suggest improvements!  

## 📩 Contact  
For any queries, reach out to **Kamini Sarode**.  

