--
-- File: https://github.com/monmaya/samples/blob/main/models/incremental_order_event_model.sql
--
-- References:
-- * https://github.com/monmaya/samples/blob/main/models/seed_order_event_model.sql
-- * https://github.com/PacktPublishing/Driving-Data-Quality-with-Data-Contracts/blob/main/Chapter03/order_events.yaml
--

MODEL (
  name sqlmesh.incremental_order_event_model,
  kind INCREMENTAL_BY_UNIQUE_KEY (
    unique_key order_id
  ),
  start '2025-01-01',
  cron '@daily',
  grain (customer_id)
);

SELECT
  order_id,
  customer_id,
  order_event_timestamp,
  -- 'z' as new_column,
  items
FROM
  sqlmesh.seed_order_event_model
WHERE
  order_event_timestamp BETWEEN @start_date AND @end_date
  
