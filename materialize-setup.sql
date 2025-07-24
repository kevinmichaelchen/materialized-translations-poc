-- Materialize setup script
-- Run this after both containers are up

-- Create secret for the password (drop if exists)
DROP SECRET IF EXISTS postgres_password CASCADE;
CREATE SECRET postgres_password AS 'postgres';

-- Create a connection to PostgreSQL (drop if exists)
DROP CONNECTION IF EXISTS postgres_conn CASCADE;
CREATE CONNECTION postgres_conn TO POSTGRES (
    HOST 'postgres',
    PORT 5432,
    USER 'postgres',
    PASSWORD SECRET postgres_password,
    DATABASE 'product_catalog'
);

-- Create source from PostgreSQL using PUBLICATION
DROP SOURCE IF EXISTS postgres_source CASCADE;
CREATE SOURCE postgres_source
FROM POSTGRES CONNECTION postgres_conn (PUBLICATION 'mz_source')
FOR ALL TABLES;

-- Create the materialized view with product translations
DROP MATERIALIZED VIEW IF EXISTS materialized_product CASCADE;
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
FROM 
    product p
    INNER JOIN localized_string ls ON p.name_id = ls.id
    LEFT JOIN translation t ON ls.id = t.localized_string_id
    LEFT JOIN approval a ON t.id = a.translation_id
GROUP BY 
    p.id, p.sku, p.price, p.created_at, p.updated_at, p.name_id, ls.code;