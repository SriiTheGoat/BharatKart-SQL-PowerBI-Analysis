select * from orders;


select order_id from orders
where order_id is null or trim(order_id)='';

select order_id, count(*) from orders
group by order_id
having count(*)>1;

SELECT *
FROM orders
WHERE order_id = 'O004791';

select * from orders
where order_id in (
select order_id from orders
group by order_id
having count(*)>1
);

SELECT COUNT(*) FROM (
    SELECT order_id
    FROM orders
    GROUP BY order_id
    HAVING COUNT(*) > 1
) AS duplicates;

SHOW KEYS FROM orders;

DESCRIBE orders;

create table orders_clean as
select distinct *
from orders;

select order_id, count(*)
from orders_clean
group by order_id
having count(*)>1;

select * from orders_clean
where order_id = 'O010533';

delete from orders_clean
where order_id = 'O010533'
and delivered_date is null or trim(delivered_date)='';

select * from orders_clean
where order_id = 'O010533';

select customer_id from orders_clean;

select customer_id, count(*) from orders_clean
group by customer_id
having count(*)>1;

select * from orders_clean
where customer_id is null or trim(customer_id)='';

select * from orders_clean
where order_date is null or trim(order_date)='';

select 
min(str_to_date(order_date, '%Y-%m-%d')) as minimum_date,
max(str_to_date(order_date, '%Y-%m-%d')) as maximum_date
from orders_clean;

select * from orders_clean;

select * from orders_clean
where promised_delivery_date is null or trim(promised_delivery_date)='';

select 
min(str_to_date(promised_delivery_date, '%Y-%m-%d')) as minimum_date,
max(str_to_date(promised_delivery_date, '%Y-%m-%d')) as maximum_date
from orders_clean;

select * from orders_clean;

select * from orders_clean
where delivered_date is null or trim(delivered_date)='';

select 
min(str_to_date(delivered_date, '%Y-%m-%d')) as minimum_date,
max(str_to_date(delivered_date, '%Y-%m-%d')) as maximum_date
from orders_clean;

select * from orders_clean;

select * from orders_clean
where order_status is null or trim(order_status)='';

select distinct order_status from orders_clean;


select * from orders_clean
where payment_method is null or trim(payment_method)='';

select distinct payment_method from orders_clean;