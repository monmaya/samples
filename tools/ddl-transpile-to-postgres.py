#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "cloudpathlib",
#     "sqlglot",
# ]
# ///
import argparse
import cloudpathlib
import sqlglot

def main():
    """Main entry point of the script transpiling a DDL (Data Definition Language) from DuckDB to PostgreSQL"""
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--schema-duckdb-filepath",
        type=str,
        default="data/schemas/duckdb/table_order_event.sql",
        dest="schema_duckdb_filepath",
        help="Path to the DDL file with the schema of the table (expressed with the DuckDB dialect, i.e., the source)",
    )
    parser.add_argument(
        "--schema-postgres-filepath",
        type=str,
        default="data/schemas/postgres/table_order_event.sql",
        dest="schema_postgres_filepath",
        help="Path to the DDL file with the schema of the table (expressed with the Postgres dialect, i.e., the target)",
    )
    args = parser.parse_args()

    # Source: DuckDB schema/DDL
    schema_duckdb_filepath = cloudpathlib.AnyPath(args.schema_duckdb_filepath)
    print(f"DuckDB schema file-path: {schema_duckdb_filepath}")

    if not schema_duckdb_filepath.exists() or not schema_duckdb_filepath.is_file():
        err_msg: str = f"The schema file-path of the source/DuckDB schema/DDL ({schema_duckdb_filepath}) does not seem to exist"
        raise ValueError(err_msg)

    # Read the source schema/DDL
    schema_duckdb: str = ""
    with open(schema_duckdb_filepath) as schema_duckdb_file:
        schema_duckdb = schema_duckdb_file.read()

    # Transpile with SQLGlot (https://github.com/tobymao/sqlglot)
    schema_postgres = sqlglot.transpile(schema_duckdb, write="postgres")
    schema_postgres_str = schema_postgres[0]

    # Target: PostgreSQL schema/DDL
    schema_postgres_filepath = args.schema_postgres_filepath
    print(f"PostgreSQL/target schema file-path: {schema_postgres_filepath}")
    
    # Write the target schema/DDL
    with open(schema_postgres_filepath, 'w') as schema_postgres_file:
        schema_postgres_file.write(schema_postgres_str)

    #
    print(f"Next step: less {schema_postgres_filepath}")
    
if __name__ == "__main__":
    main()

