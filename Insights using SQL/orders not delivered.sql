-- Total orders that are not delivered
SELECT
  COUNT(DISTINCT order_id) AS non_delivered_count
FROM
  `sacred-particle-471715-e3`.`supplychain`.`orders`
WHERE
  order_status != 'delivered';
