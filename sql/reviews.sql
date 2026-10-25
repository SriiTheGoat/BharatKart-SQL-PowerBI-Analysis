select * from reviews;

select count(*), order_id
from reviews
group by order_id
having count(*)>1;

select *
from reviews
where order_id is null or trim(order_id)='';

select min(review_score), max(review_score) from reviews;

SELECT *
FROM reviews
WHERE review_score = 0;

SELECT COUNT(*)
FROM reviews
WHERE review_score = 0;

SELECT *
FROM reviews
WHERE review_score = 6;

UPDATE reviews
SET review_score = NULL
WHERE review_score = 0 OR review_score = 6;

select *
from reviews
where review_score is null or trim(review_score)='';

select *
from reviews
where review_date is null or trim(review_date)='';

SELECT
MIN(STR_TO_DATE(review_date, '%Y-%m-%d')) AS min_date,
MAX(STR_TO_DATE(review_date, '%Y-%m-%d')) AS max_date
FROM reviews;

SELECT order_id, COUNT(*)
FROM reviews
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT review_score, COUNT(*) AS total
FROM reviews
GROUP BY review_score
ORDER BY review_score;