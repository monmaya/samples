--
-- File: https://github.com/monmaya/samples/blob/main/models/seed_data_contract_model.sql
--
-- References:
-- * https://github.com/monmaya/base-impl/blob/main/docs/relational_model.md
--

MODEL (
  name sqlmesh.seed_data_contract_model,
  kind SEED (
  path '../seeds/seed_data_contract_data.csv'
  ),
  columns (
    id VARCHAR,
	description VARCHAR,
    port_id VARCHAR,
    created_at_utc TIMESTAMP,
    updated_at_utc TIMESTAMP,
  ),
  grain (id, port_id)
);
  
