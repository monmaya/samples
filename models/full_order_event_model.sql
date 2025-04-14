--
-- File: https://github.com/monmaya/samples/blob/main/models/full_order_event_model.sql
--
-- References:
-- * https://github.com/monmaya/samples/blob/main/models/incremental_order_event_model.sql
-- * https://github.com/monmaya/samples/blob/main/models/seed_order_event_model.sql
-- * https://github.com/PacktPublishing/Driving-Data-Quality-with-Data-Contracts/blob/main/Chapter03/order_events.yaml
--

MODEL (
  name sqlmesh.full_order_event_model,
  kind FULL,
  cron '@daily',
  grain customer_id,
  audits (assert_positive_num_orders),
);

SELECT
  customer_id,
  COUNT(DISTINCT order_id) AS num_orders,
FROM
  sqlmesh.incremental_order_event_model
GROUP BY customer_id
ORDER BY num_orders desc

