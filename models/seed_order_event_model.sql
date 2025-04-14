--
-- File: https://github.com/monmaya/samples/blob/main/models/seed_order_event_model.sql
--
-- References:
-- * https://github.com/PacktPublishing/Driving-Data-Quality-with-Data-Contracts/blob/main/Chapter03/order_events.yaml
--

MODEL (
  name sqlmesh.seed_order_event_model,
  kind FULL,
  columns (
    order_id VARCHAR,
    customer_id VARCHAR,
    order_event_timestamp TIMESTAMP,
    items STRUCT<
      product_id VARCHAR,
      quantity INTEGER,
      price FLOAT
    >
  ),
  grain (order_id, order_event_timestamp)
);
  
WITH dummy_data AS (
  SELECT 
    '123' as order_id,
    '456' as customer_id,
    strptime('2025-04-12T14:20:30', '%Y-%m-%dT%H:%M:%S') as order_event_timestamp,
    STRUCT('789' as product_id, 2 as quantity, 19.99 as price) as items
  UNION ALL
  SELECT 
    '124' as order_id,
    '457' as customer_id,
    strptime('2025-04-12T15:20:30', '%Y-%m-%dT%H:%M:%S') as order_event_timestamp,
    STRUCT('790' as product_id, 1 as quantity, 29.99 as price) as items
  UNION ALL
  SELECT 
    '125' as order_id,
    '457' as customer_id,
    strptime('2025-04-12T15:21:30', '%Y-%m-%dT%H:%M:%S') as order_event_timestamp,
    STRUCT('789' as product_id, 2 as quantity, 19.99 as price) as items
)
SELECT * FROM dummy_data;
