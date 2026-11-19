select count(distinct e.order_id ) as Unique_ord
from ecom e ;
select count(e.customer_unique_id) as Uniq_custm
from ecom e ;
select sum(e.price) as total_rev
from ecom e ; 
select e.customer_state as state,sum(e.price )as rev 
from ecom e group by e.customer_state order by rev desc limit 5;
select sum(e.price )/count(distinct e.order_id) as avg_val
from ecom e;
select sum(e.price)as revenue,e.customer_unique_id as cstm
from ecom e group by e.customer_unique_id order by revenue desc limit 10 ;
select e.product_category_name as prod,sum(e.price)as rev 
from ecom e group by e.product_category_name order by rev desc limit 5;
select sum(e.price)as revenue,e.`month/year_of_purchase` as trend 
from ecom e group by e.`month/year_of_purchase` order by trend asc; 
select e.customer_state as state, sum(e.price)as rev
from ecom e group by e.customer_state order by rev desc limit 5;
select count(distinct e.order_id)as count ,e.`month/year_of_purchase` as mon 
from ecom e group by e.`month/year_of_purchase` order by mon asc;
select e.payment_type as type,COUNT(distinct e.order_id)as ord 
from ecom e group by e.payment_type order by ord desc; 
select avg(e.price) as price,e.product_category_name as catg 
from ecom e group by e.product_category_name;
select count(distinct e.order_id)as arv_late 
from ecom e where e.order_estimated_delivery_date< e.order_delivered_customer_date;
select round(
sum(
case when e.order_estimated_delivery_date< e.order_delivered_customer_date
then 1 else 0
end )*100/count(distinct e.order_id),2)
as late
from ecom e;
select
case WHEN
e.order_delivered_customer_date=e.order_estimated_delivery_date
then 'on-time'
else 'LATE'
end as status,count(distinct e.order_id)as count
from ecom e group by status;

create view order_vi as
select order_id,
sum(e.price) as total_price,
sum(e.freight_value)as tot_fr,
count(e.order_item_id) as it_c,
 MAX(order_purchase_timestamp) AS purchase_date,
 MAX(order_delivered_customer_date) AS delivered_date,
MAX(order_estimated_delivery_date) AS estimated_date
from ecom e group by order_id;  
SELECT COUNT(*) FROM order_vi;
select count(order_id) 
from order_vi where delivered_date is not NULL;

select order_id,DATEDIFF(delivered_date,purchase_date)as diff 
from order_vi;
select avg(DATEDIFF(delivered_date,purchase_date))as diff_avg
from order_vi;
select avg(DATEDIFF(delivered_date,estimated_date))as date_dif
from order_vi where delivered_date>estimated_date;

select count(e.customer_unique_id)as cc,count(distinct order_id) as oc
from ecom e group by e.customer_unique_id having oc>1;