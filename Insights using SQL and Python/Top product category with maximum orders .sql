
-- All Unique Categories 
-- select distinct(product_category_name) from `supplychain.products`;




-- write a query to find the maximum ordered category 

-- SELECT
--   t3.product_category_name,
--   COUNT(DISTINCT t1.order_id) AS delivered_order_count
-- FROM
--   `sacred-particle-471715-e3`.`supplychain`.`orders` AS t1
-- INNER JOIN
--   `sacred-particle-471715-e3`.`supplychain`.`order_items` AS t2
-- ON
--   t1.order_id = t2.order_id
-- INNER JOIN
--   `sacred-particle-471715-e3`.`supplychain`.`products` AS t3
-- ON
--   t2.product_id = t3.product_id
-- GROUP BY
--   t3.product_category_name
-- ORDER BY
--   COUNT(DISTINCT t1.order_id) DESC
-- LIMIT
--   1;

-- SELECT
--   COUNT(DISTINCT order_id) AS non_delivered_count
-- FROM
--   `sacred-particle-471715-e3`.`supplychain`.`orders`
-- WHERE
--   order_status != 'delivered';
