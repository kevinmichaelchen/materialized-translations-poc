# Materialized Translations POC

A proof of concept demonstrating how to use
[Materialize](https://materialize.com/) to create real-time materialized views
of internationalized product data with PostgreSQL as the source database.

## Overview

This project showcases a pattern for handling multilingual product catalogs
where:

- Product metadata is stored in a normalized schema
- Translations are managed separately with approval workflows
- A materialized view aggregates all translations into a denormalized JSONB
  structure for efficient querying
- Changes to source data are automatically reflected in the materialized view
  via CDC (Change Data Capture)

## Architecture

```
┌─────────────────┐         CDC          ┌──────────────────┐
│   PostgreSQL    │ ◄──────────────────► │   Materialize    │
├─────────────────┤                      ├──────────────────┤
│  Schema: pc     │                      │ Materialized View│
│  - product      │                      │ - materialized_  │
├─────────────────┤                      │   product        │
│  Schema: i18n   │                      │                  │
│  - localized_   │                      │ (Denormalized    │
│    string       │                      │  with JSONB      │
│  - translation  │                      │  translations)   │
│  - approval     │                      └──────────────────┘
└─────────────────┘
```

## Prerequisites

- Docker and Docker Compose
- Basic understanding of PostgreSQL and SQL

## Quick Start

1. **Clone the repository:**

   ```bash
   git clone https://github.com/kevinmichaelchen/materialized-translations-poc.git
   cd materialized-translations-poc
   ```

2. **Start the services:**

   ```bash
   docker-compose up -d
   ```

3. **Set up PostgreSQL replication:**

   ```bash
   # Wait for PostgreSQL to be ready
   docker exec -i postgres_db psql -U postgres -d product_catalog < postgres-publication.sql

   # Restart PostgreSQL to apply replication settings
   docker-compose restart postgres
   ```

4. **Configure Materialize:**

   ```bash
   # Wait for Materialize to be ready
   docker exec -i materialize_db psql -U materialize -p 6875 -h localhost < materialize-setup.sql
   ```

5. **Verify the setup:**
   ```bash
   docker exec -it materialize_db psql -U materialize -p 6875 -h localhost -c "SELECT * FROM materialized_product;"
   ```

## Database Schema

### PostgreSQL Schemas

#### `pc` (Product Catalog) Schema

- **product**: Core product information
  - `id`: UUID primary key
  - `name_id`: Foreign key to `i18n.localized_string`
  - `sku`: Product SKU
  - `price`: Product price
  - `created_at`, `updated_at`: Timestamps

#### `i18n` (Internationalization) Schema

- **localized_string**: String identifiers for translatable content
  - `id`: UUID primary key
  - `code`: Unique identifier (e.g., "product.laptop.name")

- **translation**: Actual translations for each string
  - `id`: UUID primary key
  - `localized_string_id`: Foreign key to `localized_string`
  - `language`: Language code (e.g., "en", "es", "fr")
  - `translation`: The translated text

- **approval**: Translation approval tracking
  - `id`: UUID primary key
  - `translation_id`: Foreign key to `translation`
  - `approved_by`: UUID of the approver
  - `approved_at`: Timestamp of approval

### Materialize View

The `materialized_product` view combines all data into a denormalized structure:

```sql
CREATE MATERIALIZED VIEW materialized_product AS
SELECT
    p.id,
    p.sku,
    p.price,
    p.created_at,
    p.updated_at,
    p.name_id,
    ls.code as name_code,
    COALESCE(
        jsonb_agg(
            CASE
                WHEN t.id IS NOT NULL THEN
                    jsonb_build_object(
                        'language', t.language,
                        'translation', t.translation,
                        'approved_by', a.approved_by,
                        'approved_at', a.approved_at
                    )
                ELSE NULL
            END
        ) FILTER (WHERE t.id IS NOT NULL),
        '[]'::jsonb
    ) as localized_names
FROM pc.product p
    INNER JOIN i18n.localized_string ls ON p.name_id = ls.id
    LEFT JOIN i18n.translation t ON ls.id = t.localized_string_id
    LEFT JOIN i18n.approval a ON t.id = a.translation_id
GROUP BY p.id, p.sku, p.price, p.created_at, p.updated_at, p.name_id, ls.code;
```

## Example Queries

### View all products with translations:

```sql
SELECT * FROM materialized_product;
```

### Get products with approved English translations:

```sql
SELECT
    id,
    sku,
    price,
    localized_names -> 0 ->> 'translation' as english_name
FROM materialized_product
WHERE localized_names @> '[{"language": "en", "approved_at": null}]'::jsonb = false;
```

### Find products missing translations for a specific language:

```sql
SELECT
    id,
    sku,
    name_code
FROM materialized_product
WHERE NOT (localized_names @> '[{"language": "es"}]'::jsonb);
```

## Use Cases

1. **E-commerce Platforms**: Serve product catalogs in multiple languages with
   real-time updates
2. **Content Management Systems**: Manage multilingual content with approval
   workflows
3. **API Backends**: Provide denormalized data for efficient API responses
4. **Reporting Systems**: Generate reports with translated content without
   complex joins

## Benefits

- **Real-time Updates**: Changes in PostgreSQL are immediately reflected in
  Materialize
- **Query Performance**: Denormalized structure eliminates complex joins at
  query time
- **Flexible Schema**: JSONB allows for dynamic translation attributes
- **Audit Trail**: Approval tracking built into the data model

## Testing Changes

Add a new product:

```sql
-- In PostgreSQL
INSERT INTO pc.product (name_id, sku, price)
VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'LAP-002', 1299.99);
```

Add a new translation:

```sql
-- In PostgreSQL
INSERT INTO i18n.translation (localized_string_id, language, translation)
VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'es', 'Teclado Mecánico');
```

The materialized view in Materialize will update automatically!

## Troubleshooting

### PostgreSQL replication not working

- Ensure `wal_level = logical` is set
- Check PostgreSQL logs: `docker logs postgres_db`
- Verify publication exists: `SELECT * FROM pg_publication;`

### Materialize connection issues

- Check Materialize logs: `docker logs materialize_db`
- Verify connection: `SHOW CONNECTIONS;` in Materialize
- Ensure PostgreSQL is accessible from Materialize container

### Data not updating

- Check source status: `SHOW SOURCES;` in Materialize
- Verify materialized view: `SHOW MATERIALIZED VIEWS;`
- Check for errors: `SELECT * FROM mz_internal.mz_source_statuses;`

## License

MIT
