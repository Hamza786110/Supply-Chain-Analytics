-- Total payment done by each payment type

select p.payment_type,count(o.customer_id) as Total_Customers
from `sacred-particle-471715-e3.supplychain.orders` as o inner join
`sacred-particle-471715-e3.supplychain`.payments p on o.order_id=p.order_id
group by p.payment_type 