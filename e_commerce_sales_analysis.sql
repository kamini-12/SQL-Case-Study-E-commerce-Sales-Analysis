-- 1️⃣ Top 5 Most Purchased Products
SELECT Product_Category, COUNT(*) AS Total_Purchases  
FROM transactions  
GROUP BY Product_Category  
ORDER BY Total_Purchases DESC  
LIMIT 5;

-- 2️⃣ Customer Retention Rate
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

-- 3️⃣ Churn Analysis (Inactive Customers)
SELECT 
    Transaction_ID,
    User_Name,
    Age,
    Country,
    Product_Category,
    Purchase_Amount,
    Payment_Method,
    Transaction_Date
FROM transactions
WHERE User_Name IN (
    SELECT DISTINCT User_Name 
    FROM transactions 
    WHERE Transaction_Date < CURRENT_DATE - INTERVAL '6 MONTHS'
)
ORDER BY Transaction_Date DESC;

-- 4️⃣  Most Common Payment Method
SELECT payment_method, COUNT(*) AS usage_count
FROM transactions
GROUP BY payment_method
ORDER BY usage_count DESC;

-- 5️⃣ Total Revenue by Country
SELECT Country, SUM(Purchase_Amount) AS Total_Revenue  
FROM transactions  
GROUP BY Country  
ORDER BY Total_Revenue DESC;

-- 6️⃣ Customer Spending Behavior Recency, Frequency, and Monetary Value (RFM Analysis)
SELECT 
    user_name,
    MAX(transaction_date) AS last_purchase_date,
    COUNT(transaction_id) AS purchase_frequency,
    SUM(purchase_amount) AS total_spent
FROM transactions
GROUP BY user_name
ORDER BY total_spent DESC;

-- 7️⃣ Average Order Value (AOV)
SELECT 
    ROUND(SUM(purchase_amount) / COUNT(transaction_id), 2) AS avg_order_value
FROM transactions;

-- 8️⃣ Customer Age Group Analysis
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+' 
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(purchase_amount) AS total_sales
FROM transactions
GROUP BY age_group
ORDER BY total_sales DESC;

-- 9️⃣ Customer Purchase Frequency
SELECT User_Name, COUNT(Transaction_ID) AS purchase_count
FROM transactions
GROUP BY User_Name
ORDER BY purchase_count DESC
LIMIT 5;

-- 🔟 Returning vs. New Customers
SELECT 
    CASE 
        WHEN user_id IN (SELECT user_id FROM transactions GROUP BY user_id HAVING COUNT(*) > 1) 
        THEN 'Returning Customer' 
        ELSE 'New Customer' 
    END AS customer_type, 
    COUNT(*) AS total_customers
FROM transactions
GROUP BY customer_type;