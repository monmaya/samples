--
-- File: https://github.com/monmaya/samples/blob/main/audits/assert_positive_num_orders.sql
--
-- References:
-- * https://github.com/monmaya/samples/blob/main/models/full_order_event_model.sql
--

AUDIT (
  name assert_positive_num_orders,
);

SELECT *
FROM @this_model
WHERE
  num_orders < 0
  
