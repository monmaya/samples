--
--
--
CREATE TABLE incremental_order_event_model(
	order_id VARCHAR,
       	customer_id VARCHAR,
       	order_event_timestamp TIMESTAMP,
       	items STRUCT(
		product_id VARCHAR,
	       	quantity INTEGER,
	       	price FLOAT
	)
);

