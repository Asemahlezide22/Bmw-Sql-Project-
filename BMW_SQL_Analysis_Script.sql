
-- BMW Sales Analysis Project
-- Author: Asemahle Zide
-- Description: SQL script for analyzing BMW South Africa sales data

-- 1. Total Sales Revenue
SELECT SUM(price) AS total_revenue FROM sales;

-- 2. Number of Cars Sold by Fuel Type
SELECT fuel_type, COUNT(*) AS total_sold
FROM sales
GROUP BY fuel_type;

-- 3. Top 5 Best-Selling Vehicle Models
SELECT vehicle_model, COUNT(*) AS units_sold
FROM sales
GROUP BY vehicle_model
ORDER BY units_sold DESC
LIMIT 5;

-- 4. Monthly Sales Totals
SELECT strftime('%Y-%m', date_of_sale) AS month, COUNT(*) AS sales_count
FROM sales
GROUP BY month
ORDER BY month;

-- 5. Average Sale Price by Province
SELECT d.location, ROUND(AVG(s.price), 2) AS avg_price
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
GROUP BY d.location;

-- 6. Customer Satisfaction Score by Vehicle Model
SELECT s.vehicle_model, ROUND(AVG(c.satisfaction_score), 2) AS avg_score
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY s.vehicle_model;

-- 7. Count of Customers by Age Group and Gender
SELECT age_group, gender, COUNT(*) AS customer_count
FROM customers
GROUP BY age_group, gender
ORDER BY age_group;

-- 8. Customer Names with Dealer Locations
SELECT c.name AS customer_name, d.dealer_name, d.location
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN dealers d ON s.dealer_id = d.dealer_id
LIMIT 50;

-- 9. Dealers with Average Sale Price > R1 million
SELECT d.dealer_name, d.location, ROUND(AVG(s.price), 2) AS avg_price
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
GROUP BY d.dealer_id
HAVING avg_price > 1000000;

-- 10. Customers with Low Satisfaction (Below 5)
SELECT name, age_group, gender, satisfaction_score
FROM customers
WHERE satisfaction_score < 5
ORDER BY satisfaction_score;

-- 11. Dealer(s) with the Highest Total Revenue
SELECT d.dealer_name, SUM(s.price) AS total_revenue
FROM sales s
JOIN dealers d ON s.dealer_id = d.dealer_id
GROUP BY s.dealer_id
ORDER BY total_revenue DESC
LIMIT 1;

-- 12. Rank Dealers by Sales Volume (Optional: Requires Window Functions)
SELECT dealer_name, location, sales_count, 
       RANK() OVER (ORDER BY sales_count DESC) AS rank
FROM (
    SELECT d.dealer_name, d.location, COUNT(*) AS sales_count
    FROM sales s
    JOIN dealers d ON s.dealer_id = d.dealer_id
    GROUP BY d.dealer_id
);
