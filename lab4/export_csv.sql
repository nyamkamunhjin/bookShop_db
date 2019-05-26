-- select 
--     s.customer_id, s.product_id, s.quantity, o.payment_type, o.order_date, o.total_price 
-- from 
--     orders o inner join shopping_cart s on s.cart_id = o.cart_id
-- INTO OUTFILE 'test.csv'
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n';

LOAD DATA INFILE "internom/test.csv"
INTO TABLE order_check
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n';