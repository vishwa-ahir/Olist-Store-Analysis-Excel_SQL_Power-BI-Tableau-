Use project;

select * from olist_customers_dataset;
select * from olist_order_items_dataset;
select * from olist_order_payments_dataset;
select * from olist_order_reviews_dataset;
select * from olist_orders_dataset;
select * from olist_products_dataset;

select count(*) as "Total Customers" from olist_customers_dataset;
select count(*) as "Total payments" from Olist_order_payments_dataset;
select count(*) as "Total Orders" from Olist_orders_dataset;
select count(*) as "Total Product" from Olist_products_dataset;
select count(freight_value) as freight_value from Olist_order_items_dataset;

#1 Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics

select * from Olist_orders_dataset;
select* from Olist_order_payments_dataset;


select case when weekday(order_purchase_timestamp)=5 then "Weekday"
when weekday(order_purchase_timestamp)=6 then "Weekend"
else "Weekday"
end as Days,
round(sum(payment_value)) as Payment
from Olist_orders_dataset as Orders join Olist_order_payments_dataset as payment
on orders.order_id = payment.order_id
group by Days;


#2 Number of Orders with review score 5 and payment type as credit card.

select * from olist_order_payments_dataset;
select * from olist_order_reviews_dataset;

select payment.payment_type,review.review_score, count(distinct(review.order_id)) as unique_orders 
from olist_order_reviews_dataset as review join olist_order_payments_dataset as payment
on review.order_id=payment.order_id
where review.review_score in (5) and payment.payment_type in ('credit_card');

#3 Average number of days taken for order_delivered_customer_date for pet_shop

select * from olist_products_dataset;
select * from olist_orders_dataset;
select * from olist_order_items_dataset;

select round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp))) as  shiiping_Days, product.product_category_name 
from olist_orders_dataset as orders join olist_order_items_dataset as items
on orders.order_id = items.order_id
join olist_products_dataset as product
on items.product_id= product.product_id
where  product.product_category_name =('pet_shop');


#4 Average price and payment values from customers of sao paulo city
 
select * from olist_order_payments_dataset;
select * from olist_customers_dataset;
select * from olist_order_items_dataset;
select * from olist_orders_dataset;

select customers.customer_city,
round(avg(items.price)) as Avg_price, 
round(avg(payment.payment_value))  as Avg_Payment
from olist_customers_dataset as customers join olist_orders_dataset as orders
on customers.customer_id=orders.customer_id
join  olist_order_items_dataset as items
on orders.order_id=items.order_id
join olist_order_payments_dataset as payment
on payment.order_id=orders.order_id
where customers.customer_city=('sao paulo');

#5 Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.

select * from olist_orders_dataset;
select * from olist_order_reviews_dataset;

select review.review_score,
round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp))) as Shipping_Day
from olist_orders_dataset as orders join  olist_order_reviews_dataset as review
on orders.order_id=review.order_id
group by  review.review_score
order by  review.review_score;

#6 Top 5 customer cities based on payment values

select * from olist_order_payments_dataset;
select * from olist_customers_dataset;
select * from olist_orders_dataset;

select customer_city,
round(sum(payment_value)) as payment
from
 olist_customers_dataset as customer join olist_orders_dataset as orders
on customer.customer_id = orders.customer_id
join olist_order_payments_dataset as payment
on orders.order_id=payment.order_id
group by customer_city
order by sum(payment.payment_value) desc limit 5;






