# Materialized Translations POC Setup

## Quick Start

1. Start the containers:

```bash
docker-compose up -d
```

2. Wait for both services to be healthy, then set up PostgreSQL publication:

```bash
docker exec -i postgres_db psql -U postgres -d product_catalog < postgres-publication.sql
```

3. Restart PostgreSQL to apply replication settings:

```bash
docker-compose restart postgres
```

4. Connect to Materialize and run the setup:

```bash
docker exec -i materialize_db psql -U materialize -p 6875 -h localhost < materialize-setup.sql
```

## Verify the Setup

Connect to Materialize and query the materialized view:

```bash
docker exec -it materialize_db psql -U materialize -p 6875 -h localhost
```

Then run:

```sql
SELECT * FROM materialized_product;
```

## Architecture

- **PostgreSQL**: Contains the source data in two schemas:
  - `pc` schema: Product catalog with `product` table
  - `i18n` schema: Internationalization tables (`localized_string`,
    `translation`, `approval`)

- **Materialize**: Creates a materialized view `materialized_product` that:
  - Joins all product data with translations
  - Aggregates translations into a JSONB column
  - Updates automatically when source data changes

## Sample Data

The setup includes sample products with translations:

- Laptop Computer (English, Spanish, French)
- Wireless Mouse (English, Spanish)
- Mechanical Keyboard (English only)
