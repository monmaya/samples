--
-- File: https://github.com/monmaya/samples/blob/main/models/incremental_data_product_model.sql
--
-- References:
-- * https://github.com/monmaya/base-impl/blob/main/docs/relational_model.md
--

MODEL (
  name sqlmesh.incremental_data_product_model,
  kind INCREMENTAL_BY_UNIQUE_KEY (
  unique_key id
  ),
  start '2025-01-01',
  cron '@daily',
  grain (id)
);

SELECT
	id,
	description,
	contract_id,
	created_at_utc,
	updated_at_utc
FROM
	sqlmesh.seed_data_product_model
;

