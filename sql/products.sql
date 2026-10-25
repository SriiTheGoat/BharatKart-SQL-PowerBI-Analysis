select * from products;

select product_id, count(*) 
from products
group by product_id
having count(*)>1;

select distinct product_name, category
from products;

select max(mrp), min(mrp)
from products;

select max(cost_price), min(cost_price)
from products;

SELECT *
FROM products
WHERE product_id IS NULL
OR product_name IS NULL
OR category IS NULL
OR mrp IS NULL
OR cost_price IS NULL;