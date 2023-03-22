create database project3;
use project3;
create table transactionmaster1(
event_time char(65),
event_type char(65),
product_id int,
category_id int,
category_code char(65),
brand char(65),
price int,
user_id int,
user_session char(65)
);
select * from transactionmaster1;
select count(*) from transactionmaster1;
select distinct(category_id) from transactionmaster1;
select distinct substring(event_time,12,15) as year from transactionmaster1;
select distinct (year(cast(substring(event_time,1,10) as date))) as year from transactionmaster1;
select year(cast(substring(event_time,1,10) as date)) as year,month(cast(substring(event_time,1,10) as date)) as month1 from transactionmaster1 group by month1;
---- month of sale
select year(cast(substring(event_time,1,10) as date)) as year, month(cast(substring(event_time,1,10) as date))as month1 , sum(price) as total_sales from transactionmaster1 
where event_type="purchase" group by month1, year(cast(substring(event_time,1,10) as date)) order by total_sales desc;
---Top brands by sales
select brand,sum(price) as total_sales from transactionmaster1
where event_type="purchase"
group by brand
order by total_sales desc
limit 6;  
with top_brand as (select brand,sum(price),dense_rank()over (order by sum(price) desc) from transactionmaster1  where event_type="purchase" group by brand) 
select * from top_brand
 limit 6 ;
 ----Time to visit
select sum(cast(substring(event_time,12,19) as time)) , event_type,cast(event_type as time) from transactionmaster1
where event_type not like "event_type"
group by event_type;
 
 ---Demands for items
 with top_category as (select category_code,sum(price),dense_rank()over (order by sum(price) desc) from transactionmaster1  where event_type="purchase" group by category_code) 
select * from top_cate
 limit 6 ;
 select category_code,sum(price) as total_sales from transactionmaster1
where event_type="purchase"
group by category_code
order by total_sales desc
limit 6;  
--Actual time to purchase
select product_id,count(event_type) as no_of_time_purchased from transactionmaster1 
where  event_type="purchase"
group by product_id
order by no_of_time_purchased desc;







