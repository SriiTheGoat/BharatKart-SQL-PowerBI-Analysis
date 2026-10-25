-- BHARATKART SQL ANALYSIS PROJECT
USE bharatkart;

-- 1. Calculate total revenue after discounts.
-- Table: order_items_clean
-- Columns: quantity, unit_price, discount_pct

select sum((quantity * unit_price)*(1-discount_pct)) as total_revenue
from order_items_clean
where quantity>0;

-- 2. Count total orders.
-- Table: orders_clean
-- Columns: order_id

select count(distinct order_id) as total_orders
from orders_clean;

-- 3. Find revenue by product category.
-- Tables: order_items_clean, products
-- Columns: product_id, quantity, unit_price, discount_pct, category

select p.category, sum(oic.quantity * oic.unit_price *(1-oic.discount_pct)) as revenue
from order_items_clean as oic
join products as p 
on p.product_id = oic.product_id
where oic.unit_price>0
group by p.category;

-- 4. Find the most-used payment method.
-- Table: orders_clean
-- Column: payment_method

select payment_method, count(payment_method)
from orders_clean
group by payment_method
order by count(payment_method) desc limit 1;

-- 5. Find the top 5 states by customer count.
-- Table: customers
-- Columns: customer_id, state

select state, count(customer_id)
from customers
group by state
order by count(customer_id) desc limit 5;

-- 6. Find the acquisition channel bringing the most customers.
-- Table: customers
-- Columns: customer_id, acquisition_channel

select acquisition_channel, count(acquisition_channel)
from customers
group by acquisition_channel
order by count(acquisition_channel) desc limit 1;

-- 7. Find the top 10 products by quantity sold.
-- Tables: order_items_clean, products
-- Columns: product_id, product_name, quantity

select p.product_name,sum(oic.quantity)
from products as p
join order_items_clean as oic
on oic.product_id = p.product_id
group by product_name
order by sum(quantity) desc limit 10;

-- 8. Calculate profit by product category.
-- Tables: order_items_clean, products
-- Columns: product_id, quantity, unit_price, discount_pct, cost_price, category

SELECT
    p.category,
    SUM(
        oic.quantity * oic.unit_price
        * (1 - oic.discount_pct)
        - oic.quantity * p.cost_price
    ) AS profit
FROM order_items_clean AS oic
JOIN products AS p
    ON p.product_id = oic.product_id
WHERE oic.quantity > 0
GROUP BY p.category
ORDER BY profit DESC;

-- 9. Count orders by status.
-- Table: orders_clean
-- Columns: order_id, order_status

select order_status, count(order_id)
from orders_clean
group by order_status
order by count(order_id) desc;

-- 10. Calculate average delivery time.
-- Table: orders_clean
-- Columns: order_date, delivered_date

select avg(datediff(delivered_date,order_date)) from orders_clean;

-- 11. Count late deliveries.
-- Table: orders_clean
-- Columns: promised_delivery_date, delivered_date

select count(*) as late_delivary_date
from orders_clean
where promised_delivery_date < delivered_date;

-- 12. Calculate average order value by payment method.
-- Tables: orders_clean, order_items_clean
-- Columns: order_id, payment_method, quantity, unit_price, discount_pct

WITH order_totals AS (
    SELECT
        oc.order_id,
        oc.payment_method,
        SUM(
            oic.quantity * oic.unit_price
            * (1 - oic.discount_pct)
        ) AS order_value
    FROM orders_clean AS oc
    JOIN order_items_clean AS oic
        ON oc.order_id = oic.order_id
    WHERE oic.quantity > 0
    GROUP BY oc.order_id, oc.payment_method
)
SELECT
    payment_method,
    ROUND(AVG(order_value), 2) AS avg_order_value
FROM order_totals
GROUP BY payment_method
ORDER BY avg_order_value DESC;

-- 13. Calculate average valid review score.
-- Table: reviews
-- Column: review_score

select avg(review_score) 
from reviews
where review_score > 0 and review_score <6;

-- 14. Find average rating by product category.
-- Tables: reviews, orders_clean, order_items_clean, products
-- Columns: order_id, review_score, product_id, category

SELECT p.category, AVG(r.review_score) AS avg_rating
FROM reviews AS r
JOIN orders_clean AS oc
    ON r.order_id = oc.order_id
JOIN order_items_clean AS oic
    ON oc.order_id = oic.order_id
JOIN products AS p
    ON oic.product_id = p.product_id
WHERE r.review_score BETWEEN 1 AND 5
GROUP BY p.category
ORDER BY avg_rating DESC;

-- 15. Count customers who placed multiple orders.
-- Tables: customers, orders_clean
-- Columns: customer_id, order_id

select c.customer_id, count(oc.order_id) as order_times
from customers as c
join orders_clean as oc
on oc.customer_id = c.customer_id
group by c.customer_id
having count(oc.order_id)>1
order by count(oc.order_id) desc;


-- 16. Find the month with the highest revenue.
-- Tables: orders_clean, order_items_clean
-- Columns: order_id, order_date, quantity, unit_price, discount_pct

SELECT 
    DATE_FORMAT(oc.order_date, '%Y-%m') AS order_month,
    SUM(oic.quantity * oic.unit_price * (1 - oic.discount_pct)) AS revenue
FROM orders_clean AS oc
JOIN order_items_clean AS oic
    ON oc.order_id = oic.order_id
WHERE oic.quantity > 0
GROUP BY order_month
ORDER BY revenue DESC
LIMIT 1;

-- Q17. Top 3 customers by spending within each state
-- Tables: customers, orders_clean, order_items_clean
-- Columns:
-- customers: customer_id, state
-- orders_clean: customer_id, order_id
-- order_items_clean: order_id, quantity, unit_price, discount_pct
-- Concept: DENSE_RANK() / ROW_NUMBER()

with customer_spending as (
select c.customer_id, c.state, sum(oic.quantity * unit_price * (1-discount_pct)) as spending
from customers as c
join orders_clean as oc
on c.customer_id = oc.customer_id
join order_items_clean as oic
on oc.order_id = oic.order_id
where oic.quantity >0
group by c.customer_id, c.state
), 
ranked_customers as(
select customer_id, state, spending, 
dense_rank() over (
partition by state
order by spending desc 
) as rank_spending
from customer_spending
)
select *
from ranked_customers
where rank_spending <= 3
order by state, rank_spending;


-- Q18. Find products with revenue above average revenue per product
-- Tables: products, order_items_clean
-- Columns:
-- products: product_id, product_name
-- order_items_clean: product_id, quantity, unit_price, discount_pct
-- Concept: Subquery

select p.product_name, p.product_id, sum(oic.quantity * oic.unit_price * (1-oic.discount_pct)) as revenue
from order_items_clean as oic
join products as p
on p.product_id = oic.product_id
group by p.product_name, p.product_id
having revenue > (select avg(oic.quantity * oic.unit_price * (1-oic.discount_pct)) as avg_revenue
from order_items_clean as oic
join products as p
on p.product_id = oic.product_id)
order by revenue desc;

-- Q19. Calculate monthly revenue and percentage change from the previous month
-- Tables: orders_clean, order_items_clean
-- Columns:
-- orders_clean: order_id, order_date
-- order_items_clean: order_id, quantity, unit_price, discount_pct
-- Concept: CTE + LAG()

with monthly_revenue as (
select date_format(oc.order_date, '%Y-%m')as order_month,
sum(oic.quantity * oic.unit_price * (1-oic.discount_pct)) as revenue
from order_items_clean as oic
join orders_clean as oc
on oc.order_id = oic.order_id
where oic.quantity > 0
group by order_month
),
revenue_comparison as (
select order_month, revenue, 
lag(revenue) over(order by order_month) as previous_month
from monthly_revenue
)
select order_month, revenue, previous_month,
ROUND(
(revenue - previous_month) / previous_month * 100, 2) AS percentage_change
FROM revenue_comparison
ORDER BY order_month;

-- Q20. Classify customers by number of orders:
-- One-time: exactly 1 order
-- Regular: 2–4 orders
-- Loyal: 5+ orders
-- Then count customers in each group
-- Tables: customers, orders_clean
-- Columns:
-- customers: customer_id
-- orders_clean: customer_id, order_id
-- Concept: CASE + CTE or Subquery

WITH customer_orders AS (
    SELECT
        c.customer_id,
        COUNT(oc.order_id) AS order_count
    FROM customers AS c
    LEFT JOIN orders_clean AS oc
        ON oc.customer_id = c.customer_id
    GROUP BY c.customer_id
),
customer_group AS (
    SELECT
        customer_id,
        CASE
            WHEN order_count = 1 THEN 'One-time'
            WHEN order_count BETWEEN 2 AND 4 THEN 'Regular'
            WHEN order_count >= 5 THEN 'Loyal'
            ELSE 'No Orders'
        END AS customer_type
    FROM customer_orders
)
SELECT
    customer_type,
    COUNT(*) AS total_customers
FROM customer_group
GROUP BY customer_type
ORDER BY total_customers DESC;
