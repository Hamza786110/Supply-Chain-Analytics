-- write a query to find Create the following KPIs  
-- 1. Total Order Lines 
-- 2. Line Fill Rate 
-- 3. Volume Fill Rate 
-- 4. Total Orders 
-- 5. On Time Delivery % 
-- 6. In Full Delivery % 
-- 7. On Time In Full %
-- 
-- for the decimal values multiply it by 100 and round it off to 2 decimal points
SELECT
  COUNT(order_items.order_id) AS total_order_lines,
  ROUND( ( COUNT(
        CASE
          WHEN orders.order_status = 'delivered' THEN order_items.order_id
      END
        ) / COUNT(order_items.order_id)) * 100, 2) AS line_fill_rate,
  ROUND( ( SUM(
        CASE
          WHEN orders.order_status = 'delivered' THEN order_items.price
          ELSE 0
      END
        ) / SUM(order_items.price)) * 100, 2) AS volume_fill_rate,
  COUNT(DISTINCT orders.order_id) AS total_orders,
  ROUND( ( COUNT(
        CASE
          WHEN orders.order_status = 'delivered' AND SAFE_CAST(orders.order_delivered_timestamp AS TIMESTAMP) <= TIMESTAMP(orders.order_estimated_delivery_date) THEN orders.order_id
      END
        ) / COUNT(
        CASE
          WHEN orders.order_status = 'delivered' THEN orders.order_id
      END
        )) * 100, 2) AS on_time_delivery_percentage,
  ROUND( ( COUNT(
        CASE
          WHEN orders.order_status = 'delivered' THEN orders.order_id
      END
        ) / COUNT(orders.order_id)) * 100, 2) AS in_full_delivery_percentage,
  ROUND( ( COUNT(
        CASE
          WHEN orders.order_status = 'delivered' AND SAFE_CAST(orders.order_delivered_timestamp AS TIMESTAMP) <= TIMESTAMP(orders.order_estimated_delivery_date) THEN orders.order_id
      END
        ) / COUNT(orders.order_id)) * 100, 2) AS on_time_in_full_percentage
FROM
  `sacred-particle-471715-e3`.`supplychain`.`orders` AS orders
INNER JOIN
  `sacred-particle-471715-e3`.`supplychain`.`order_items` AS order_items
ON
  orders.order_id = order_items.order_id;