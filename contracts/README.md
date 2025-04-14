MonMaya - Samples - Data contracts
==================================

# Table of Content (ToC)

# Overview
This folder contains the data contracts in several formats, and instructions
on how to convert from one format/standard to another, for instance,
from Open Data Contract Standard (ODCS) to Data Contract Specification (DCS).

# References

## Open Data Contract Standard (ODCS)
* GitHub: https://github.com/bitol-io/open-data-contract-standard
* Human-reading-friendly:
  https://bitol-io.github.io/open-data-contract-standard/latest/#example

## Data Contract Specification (DCS)

## DataContract.com CLI
* Home page: https://cli.datacontract.com/
* GitHub: https://github.com/datacontract/datacontract-cli

# Getting started

## Lint the schema
* Check that the schema is compliant:
```bash
datacontract lint contracts/odcs/order_event.yml
```
```txt
╭────────┬──────────────────────────────────────────┬───────┬─────────╮
│ Result │ Check                                    │ Field │ Details │
├────────┼──────────────────────────────────────────┼───────┼─────────┤
│ passed │ Data contract is syntactically valid     │       │         │
│ passed │ Linter 'Objects have descriptions'       │       │         │
│ passed │ Linter 'Field references existing field' │       │         │
│ passed │ Linter 'Quality check(s) use model'      │       │         │
│ passed │ Linter 'Fields use valid constraints'    │       │         │
│ passed │ Linter 'noticePeriod in ISO8601 format'  │       │         │
│ passed │ Linter 'Field pattern is correct regex'  │       │         │
╰────────┴──────────────────────────────────────────┴───────┴─────────╯
🟢 data contract is valid. Run 7 checks. Took 0.009891 seconds.
```

## Translate from PostgreSQL DDL to ODCS
```bash
datacontract import --format sql --source data/schemas/postgres/table_order_event.sql --dialect postgres --output contracts/dcspec/order_event.yml
```

## Derive the MarkDown (MD) documentation
* Derive the MarkDown (MD) documentation for a specific data contract:
```bash
datacontract export contracts/odcs/order_event.yml --format markdown --output contracts/md/order_event.md
```

## Translate from ODCS to DCS
* Translate a specific data contract, from ODCS to DCS:
```bash
datacontract import --format odcs --source contracts/odcs/order_event.yml --output contracts/dcspec/order_event.yml
```

## Translate from DCS to ODCS
* Translate a specific data contrct, from DCS to ODCS:
```bash
datacontract export contracts/dcspec/order_event.yml --format odcs --output contracts/odcs/order_event.yml
```

# Installation

## DataContract.com CLI
* Install the datacontract CLI:
```bash
python -mpip install -U datacontract-cli[all]
```

# Maintenance

## Fill-in the DuckDB database
* If not already done so, initialize the Python environment:
```bash
make clean install-dev init
```

* If not already done so, launch SQLMesh:
```bash
make plan-prod
```

* Check that the DuckDB database has been correctly filled:
```bash
make list-tables-prod
make check-data-prod
```

## Generate DuckDB schemas
* Generate the full snapshot of the DuckDB
```bash
make export-db
```

* Check the generated DDL/schemas (expressed in the DuckDB dialect):
```bash
cat data/snapshots/current/schema.sql
```

## Extract DuckDB schemas for specific tables
* If not already done so, extract, from the export file with all the DuckDB
  tables
  ([`data/snapshots/current/schema.sql`](https://github.com/monmaya/samples/blob/main/data/snapshots/current/schema.sql)),
  the DDL for specific tables and write them into dedicated DDL files,
  for instance
  [`data/schemas/duckdb/table_order_event.sql`](https://github.com/monmaya/samples/blob/main/data/schemas/duckdb/table_order_event.sql)

* Those specific DuckDB DDL files are then used (see the next sub-section below)
  by SQLGlot to transpile them into PostgreSQL DDL files

## Transpile DDL/schemas
* Transpile the DuckDB schemas into PostgreSQL schemas:
```bash
make contract-transpile-ddb2pg
```

* Check that the generated PostgreSQL DDL/schema seems correct:
```bash
cat data/schemas/postgres/table_order_event.sql && echo
CREATE TABLE incremental_order_event_model (order_id VARCHAR, customer_id VARCHAR, order_event_timestamp TIMESTAMP, items STRUCT<product_id VARCHAR, quantity INT, price REAL>)

```
