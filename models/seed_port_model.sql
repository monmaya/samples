--
-- File: https://github.com/monmaya/samples/blob/main/models/seed_port_model.sql
--
-- References:
-- * https://github.com/monmaya/base-impl/blob/main/docs/relational_model.md
--

MODEL (
  name sqlmesh.seed_port_model,
  kind SEED (
  path '../seeds/seed_port_data.csv'
  ),
  columns (
    id VARCHAR,
	description VARCHAR,
    data_product_id VARCHAR,
	type VARCHAR,
    created_at_utc TIMESTAMP,
    updated_at_utc TIMESTAMP,
  ),
  grain (id, data_product_id)
);
  
