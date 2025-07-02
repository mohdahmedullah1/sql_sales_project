-- SQL Retail Sales Analysis - p1
CREATE DATABASE sql_project_p2;


--Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
			(
				transactions_id	INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id	INT,
				gender	VARCHAR(15),
				age	INT,
				category VARCHAR(15),
				quantiy	INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT


			);


SELECT count(*) FROM RETAIL_SALES;

select * from retail_sales 
	where 
		Transactions_id is NULL
		or
		sale_date is NULL
		or
		sale_time is NULL
		or
		customer_id is NULL
		or
		gender is NULL
		or
		age is NULL
		or
		category is NULL
		or
		quantiy is NULL
		or
		price_per_unit is NUll
		or
		cogs is NULL
		or
		total_sale is null;
	
--Data cleaning
DELETE FROM retail_sales
		where 
		Transactions_id is NULL
		or
		sale_date is NULL
		or
		sale_time is NULL
		or
		customer_id is NULL
		or
		gender is NULL
		or
		category is NULL
		or
		quantiy is NULL
		or
		price_per_unit is NUll
		or
		cogs is NULL
		or
		total_sale is null;


--Data Exploration

--how many sales we have?
select count(*) as total_sale from retail_sales

--how many unique customers we have?
select count(distinct customer_id) as total_sale from retail_sales

--Q.1 Write a SQL query to retrieve all the columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date = '2022-11-05'

--Q.2 write a SQL query to retrieve all the transactions where the category is 'clothing' and the quantity sold is
--more than 10 in the month of nov-2022


SELECT * FROM retail_sales
WHERE category = 'Clothing' and TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' and quantity >= 4


--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT
	category,
	sum(total_sale) as net_sale,
	count(*) as total_orders
from retail_sales
group by category;


--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2) as avg_age from retail_sales
where category = 'Beauty';

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
where total_sale >= 1000;


--Q.6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category.

SELECT
	category,
	gender,
	count(*) as Total_trans
from retail_sales
group by 
	category,
	gender
order by 1;

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

SELECT 
		year,
			month,
		avg_sale
FROM
(
SELECT
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1


--Q.8 Write sQL query to find the top 5 customers based on the highest total sales

SELECT 
	customer_id,
	SUM(total_sale) as total_sales

FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
	category,
	COUNT(DISTINCT customer_id) as cn_unique_cs
FROM retail_sales
GROUP BY category


--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening > 17)

WITH hourly_sale
as
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
FROM retail_sales
)
SELECT
	shift,
	COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift


--END of Project







