use  bharatkart;
show tables from bharatkart;
describe customers;
describe order_items;
describe orders;
describe products;
describe reviews;

SELECT COUNT(*) FROM customers;
select count(*) from order_items;
select count(*) from orders;
select count(*) from products;
select count(*) from reviews;

SELECT
COUNT(*) - COUNT(customer_id),
COUNT(*) - COUNT(state),
COUNT(*) - COUNT(signup_date),
COUNT(*) - COUNT(acquisition_channel)
FROM customers;


select * from customers
where acquisition_channel is null;

select * from customers
where trim(customer_id) = '';

select count(*) from customers
where trim(state) = '';

select count(*) from customers
where trim(signup_date) = '';

select count(*) from customers
where trim(acquisition_channel) = '';


select * from customers where state ='';

select * from customers where customer_id in 
(select customer_id from customers where state ='');

select state,
case
when state='' then 'Unknown'
else state
end as flag
from customers;

update customers
set state='Unknown'
where trim(state)='';

select * from customers;

select distinct state from customers;

select state, upper(state) from customers;

update customers
set state = upper(state);

select distinct state from customers;

SELECT DISTINCT CONCAT('[', state, ']')
FROM customers;

update customers
set state = trim(state);

select distinct state from customers;

select signup_date from customers;

select
min(str_to_date(signup_date,'%y-%m-%d')) as min_date,
max(str_to_date(signup_date,'%y-m%-d%')) as max_date
from customers;

SELECT DISTINCT signup_date
FROM customers
LIMIT 20;

SELECT COUNT(*)
FROM customers
WHERE TRIM(signup_date) = '';

SELECT signup_date, LENGTH(signup_date)
FROM customers
where LENGTH(signup_date)>10;

SELECT signup_date
FROM customers
WHERE STR_TO_DATE(signup_date, '%Y-%m-%d') IS NULL;

SELECT
MIN(STR_TO_DATE(signup_date, '%Y-%m-%d')) AS min_date,
MAX(STR_TO_DATE(signup_date, '%Y-%m-%d')) AS max_date
FROM customers;

select signup_date, count(*) 
from customers
group by signup_date
having count(*) > 1;

select *
from customers
where signup_date is null 
or trim(signup_date)='customers';

select * 
from customers
where trim(acquisition_channel)='' or acquisition_channel is null;

select distinct acquisition_channel 
from customers;