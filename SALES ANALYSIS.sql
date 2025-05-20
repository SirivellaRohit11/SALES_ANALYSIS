USE ANALYSIS;

SELECT * FROM SALES_ANALYSIS;

-- 1. Find all orders shipped via 'Economy' mode with a total amount greater than ₹25,000.
SELECT ship_mode, total_amount from sales_analysis
where ship_mode = 'Economy' and total_amount > 25000;

-- 2. Retrieve all sales data for 'Technology' category in 'Ireland' made after 2020-01-01.
select * from sales_analysis
where order_date > '2020-01-01'and  country = 'Ireland' and category = 'Technology';

-- 3: List the top 10 most profitable sales transactions in descending order.
select * from sales_analysis
order by total_amount desc
limit 10;

-- 4: Find all customers whose name starts with 'J' and ends with 'n'.
select customer_name
from sales_analysis
where customer_name like 'J%n';

-- 5: Retrieve all product names that contain 'Acco' anywhere in the name.
select product_name
from sales_analysis
where product_name like '%acco%';

-- 6: Get the top 5 cities with the highest total sales amount.
select city, sum(total_amount) as total_sales_amount
from sales_analysis
group by city
order by total_sales_amount desc
limit 5;

-- 7: Find the total revenue, average unit cost, and total number of orders.
select sum(total_amount) as `total revenue`, avg(Unit_cost) as `Average Unit Cost`, sum(Sold_Quantity) as `Total number of orders`
from sales_analysis;

-- 8: Get total sales per product category.
select Category, sum(Sold_Quantity) as `Total Sales`
from sales_analysis
group by category;

-- 9: Get customers who have placed orders worth more than ₹50,000.
select Customer_Name, sum(Total_Amount) as `Orders Worth`
from sales_analysis
group by Customer_Name
having `Orders Worth` > 50000;

-- 10: Find the top 5 customers by sales revenue using DENSE_RANK().
with customer_revenue as (
	select Customer_Name, sum(Total_Amount) as Total_Revenue
    from sales_analysis
    group by Customer_Name
),
ranked_customers as (
	select Customer_Name, 
    dense_rank() over(order by Total_Revenue desc) as revenue_rank
    from customer_revenue
)
select * from ranked_customers
where revenue_rank <= 5;


