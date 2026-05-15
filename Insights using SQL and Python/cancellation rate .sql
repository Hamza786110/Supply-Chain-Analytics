-- write a query to find the cancellation rate
SELECT
  ROUND(( COUNT(CASE
        WHEN orders.order_status = 'canceled' THEN orders.order_id
    END
      ) / COUNT(orders.order_id)) * 100,2) AS cancellation_rate
FROM
  `sacred-particle-471715-e3`.`supplychain`.`orders` AS orders;