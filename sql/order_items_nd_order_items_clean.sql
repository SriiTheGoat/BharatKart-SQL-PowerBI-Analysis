select * from order_items;

select count(*), order_id from order_items
group by order_id
having count(*)>1;

select order_id from order_items
where order_id is null or trim(order_id)='';

select count(*), product_id from order_items
group by product_id
having count(*)>1;

select product_id from order_items
where product_id is null or trim(product_id)='';

select quantity from order_items
where quantity is null or trim(quantity)='' or quantity = 0;

select max(quantity), min(quantity) from order_items;

SELECT *
FROM order_items AS oi
JOIN orders_clean AS oc
ON oc.order_id = oi.order_id
where oi.quantity = -1;


select count(*) from order_items
where quantity = -1;

SELECT order_id, product_id, COUNT(*)
FROM order_items
WHERE quantity = -1
GROUP BY order_id, product_id;

SELECT order_status, COUNT(*)
FROM orders_clean
WHERE order_id IN (
    SELECT order_id
    FROM order_items
    WHERE quantity = -1
)
GROUP BY order_status;

SELECT *
FROM order_items
WHERE quantity = 1
AND (order_id, product_id) IN (
    SELECT order_id, product_id
    FROM order_items
    WHERE quantity = -1
);

SELECT *
FROM order_items
WHERE quantity = -1
AND (unit_price IS NULL OR discount_pct IS NULL);

SELECT *
FROM order_items
WHERE quantity = -1
AND (unit_price <= 0 OR discount_pct < 0 OR discount_pct > 100);

SELECT *
FROM order_items
WHERE order_id IS NULL
   OR product_id IS NULL
   OR quantity IS NULL
   OR unit_price IS NULL
   OR discount_pct IS NULL;
   
SELECT *
FROM order_items
WHERE TRIM(order_id) = ''
OR TRIM(product_id) = '';
   
SELECT order_id, product_id, quantity, unit_price, discount_pct, COUNT(*)
FROM order_items
GROUP BY order_id, product_id, quantity, unit_price, discount_pct
HAVING COUNT(*) > 1;	

SELECT *
FROM order_items
WHERE order_id = 'O004066'
  AND product_id = 'P0043';
  
SELECT *
FROM order_items
WHERE (order_id, product_id) IN (
    ('O005719', 'P0036'),
    ('O009128', 'P0152'),
    ('O009525', 'P0163')
);

CREATE TABLE order_items_clean AS
SELECT DISTINCT *
FROM order_items;

select * from order_items_clean;

SELECT COUNT(*)
FROM order_items_clean
WHERE quantity = -1;

