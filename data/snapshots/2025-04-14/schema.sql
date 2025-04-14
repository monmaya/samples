CREATE SCHEMA sqlmesh;;
CREATE SCHEMA sqlmesh__sqlmesh;;
CREATE TABLE sqlmesh__sqlmesh.sqlmesh__full_order_event_model__807235047(customer_id VARCHAR, num_orders BIGINT);;
CREATE TABLE sqlmesh__sqlmesh.sqlmesh__incremental_order_event_model__3451312283(order_id VARCHAR, customer_id VARCHAR, order_event_timestamp TIMESTAMP, items STRUCT(product_id VARCHAR, quantity INTEGER, price FLOAT));;
CREATE TABLE sqlmesh__sqlmesh.sqlmesh__seed_order_event_model__2482194875(order_id VARCHAR, customer_id VARCHAR, order_event_timestamp TIMESTAMP, items STRUCT(product_id VARCHAR, quantity INTEGER, price FLOAT));;
CREATE VIEW sqlmesh.full_order_event_model AS SELECT * FROM db.sqlmesh__sqlmesh.sqlmesh__full_order_event_model__807235047;;
CREATE VIEW sqlmesh.incremental_order_event_model AS SELECT * FROM db.sqlmesh__sqlmesh.sqlmesh__incremental_order_event_model__3451312283;;
CREATE VIEW sqlmesh.seed_order_event_model AS SELECT * FROM db.sqlmesh__sqlmesh.sqlmesh__seed_order_event_model__2482194875;;

