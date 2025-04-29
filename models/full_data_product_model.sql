--
-- File: https://github.com/monmaya/samples/blob/main/models/full_data_product_model.sql
--
-- References:
-- * https://github.com/monmaya/base-impl/blob/main/docs/relational_model.md
--

MODEL (
  name sqlmesh.full_data_product_model,
  kind FULL,
  cron '@daily',
  grain id,
);

SELECT
	COUNT(*) AS num_dc
FROM
	sqlmesh.incremental_data_product_model
;
