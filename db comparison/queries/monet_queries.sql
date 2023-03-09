-- -- --------------------------------------------------------------------------------
-- Порахувати кількість проданового товару
select sum(s.quantity)
from sales s;
--
-- -- Порахувати вартість проданого товару
select sum(s.total_price)
from sales s;
--
-- -- Порахувати вартість проданого товару за період
select coalesce(sum(s.quantity), 0)
from sales s
         join orders o on o.id = s.order_id
where o.order_date between '2020-01-01' and '2020-01-14';
--
-- -- Порахувати скільки було придбано товару А в мазазині В за період С
select coalesce(sum(s.quantity), 0)
from sales s
         join orders o on o.id = s.order_id
         join products p on p.id = s.product_id
         join stores s2 on s2.id = o.store_id
where p.name = 'Croissants Thaw And Serve'
  and s2.name = 'Weber LLC'
  and order_date between '2020-01-01' and '2020-01-14';

-- -- Порахувати скільки було придбано товару А в усіх магазинах за період С
select coalesce(sum(s.quantity), 0)
from sales s
         join orders o on o.id = s.order_id
         join products p on p.id = s.product_id
where p.name = 'Croissants Thaw And Serve'
  and order_date between '2020-01-01' and '2020-01-14';


-- -- Порахувати сумарну виручку магазинів за період С
select coalesce(sum(o.payment),0)
from orders o
where o.order_date between '2020-01-01' and '2020-01-14';

-- -- Вивести топ 10 купівель товарів по два за період С (наприклад масло, хліб - 1000 разів)
with saleOrders as (select *
                    from orders o
                             inner join sales s on o.id = s.order_id
                    where o.order_date between '2020-01-01' and '2020-02-02')
select s1.product_id, s2.product_id, count(*)
from saleOrders s1
         inner join saleOrders s2 on s1.order_id = s2.order_id
where s1.product_id < s2.product_id
group by s1.product_id, s2.product_id
order by count(*) desc limit 10;


-- -- Вивести топ 10 купівель товарів по три за період С (наприклад молоко, масло, хліб - 1000 разів)
with saleOrders as (select *
                    from orders o
                             inner join sales s on o.id = s.order_id
                    where o.order_date between '2020-01-01' and '2020-02-02')
select s1.product_id, s2.product_id, s3.product_id, count(*)
from saleOrders s1
         inner join saleOrders s2 on s1.order_id = s2.order_id
         inner join saleOrders s3 on s1.order_id = s3.order_id
where s1.product_id < s2.product_id
  and s2.product_id < s3.product_id
group by s1.product_id, s2.product_id, s3.product_id
order by count(*) desc limit 10;


-- -- Вивести топ 10 купівель товарів по чотири за період С
with saleOrders as (select *
                    from orders o
                             inner join sales s on o.id = s.order_id
                    where o.order_date between '2020-01-01' and '2020-02-02')
select s1.product_id, s2.product_id, s3.product_id, s4.product_id, count(*)
from saleOrders s1
         inner join saleOrders s2 on s1.order_id = s2.order_id
         inner join saleOrders s3 on s1.order_id = s3.order_id
         inner join saleOrders s4 on s1.order_id = s4.order_id
where s1.product_id < s2.product_id
  and s2.product_id < s3.product_id
and s3.product_id < s4.product_id
group by s1.product_id, s2.product_id, s3.product_id, s4.product_id
order by count(*) desc limit 10;