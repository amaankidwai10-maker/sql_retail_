DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
	transaction_id INT PRIMARY KEY,	
	sale_date DATE,	 
	sale_time TIME,	
	customer_id	INT,
	gender	VARCHAR(15),
	age	INT,
	category VARCHAR(15),	
	quantity	INT,
	price_per_unit FLOAT,	
	cogs	FLOAT,
	total_sale FLOAT
);
select * from retail_sales ;

select count(*) from retail_sales;

SET SQL_SAFE_UPDATES=0;

select * from retail_sales where transaction_id IS NULL or
	sale_date IS NULL
    or
    sale_time IS NULL 
    or
    customer_id IS NULL 
    or
    age IS NULL 
    or
    category IS NULL 
    or
    quantity IS NULL 
    or
    price_per_unit IS NULL 
    or
    cogs IS NULL 
    or
    total_sale IS NULL;
    
    DELETE FROM retail_sales where
	transaction_id IS NULL 
    or
	sale_date IS NULL
    or
    sale_time IS NULL 
    or
    customer_id IS NULL 
    or
    age IS NULL 
    or
    category IS NULL 
    or
    quantity IS NULL 
    or
    price_per_unit IS NULL 
    or
    cogs IS NULL 
    or
    total_sale IS NULL;

-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS total_sale FROM retail_sales;

-- How many unique customers we have
SELECT COUNT(DISTINCT customer_id) as total_customers FROM retail_sales;



SELECT DISTINCT category FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
-- Q.2 Write a SQL querry to retrieve all transactions where the category is 'Clothing' and the quantity is more than 10 in the month of Nov-2022.
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions(transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month.Find out best selling month in each year.
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
-- Q.9 Write a SQL query to find the number of unique customer's who purchase items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12&17, Evening >17).alter

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

SELECT * FROM retail_sales WHERE sale_date='2022-11-05';

-- Q.2 Write a SQL querry to retrieve all transactions where the category is 'Clothing' and the quantity is more than 10 in the month of Nov-2022.

SELECT * FROM retail_sales 
WHERE category='clothing' 
AND TO_CHAR(sale_date,'YYYY-MM')= '2022-11' 
AND quantity>=4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	category,
    SUM(total_sale) as net_sale
 FROM retail_sales 
 GROUP BY 1;
 

 -- Q.4 Write a SQL query to find the average age of customers who purchased items from 'Beauty' category.
 SELECT 
	AVG(age) as avg_age
    FROM retail_sales 
    WHERE category = 'beauty';
    
    
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
 
 SELECT * FROM retail_sales
 WHERE total_sale > 1000;
 
 -- Q.6 Write a SQL query to find the total number of transactions(transaction_id) made by each gender in each category.
 
 SELECT 
	category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP BY category,gender
ORDER BY 1;


-- Q.7 Write a SQL query to find out best selling month in each year.

SELECT 
	year(sale_date) as year,
	month(sale_date) as month,
	avg(total_sale) as  avg_sale,
    SUM(total_sale)
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,3 DESC;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT 
	customer_id as customer,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;



-- Q.9 Write a SQL query to find the number of unique customer's who purchase items from each category.

SELECT
	category,
	COUNT(DISTINCT(customer_id)) as cnt_unique_cs
FROM retail_sales
GROUP BY category;    


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12&17, Evening >17).



WITH hourly_sale
AS
(
SELECT *,
	CASE
    WHEN HOUR (sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT
	shift,
	COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift

-- END OF PROJECT -- 