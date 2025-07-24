-- Materialize setup script
-- Run this after both containers are up

-- Create a connection to PostgreSQL
CREATE CONNECTION postgres_conn TO POSTGRES (
    HOST 'postgres',
    PORT 5432,
    USER 'postgres',
    PASSWORD SECRET postgres_password,
    DATABASE 'product_catalog'
);

-- Create secret for the password
CREATE SECRET postgres_password AS 'postgres';

-- Create source from PostgreSQL using PUBLICATION
CREATE SOURCE postgres_source
FROM POSTGRES CONNECTION postgres_conn
PUBLICATION 'mz_source';

-- Create the materialized view with product translations
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
    pc.product p
    INNER JOIN i18n.localized_string ls ON p.name_id = ls.id
    LEFT JOIN i18n.translation t ON ls.id = t.localized_string_id
    LEFT JOIN i18n.approval a ON t.id = a.translation_id
GROUP BY 
    p.id, p.sku, p.price, p.created_at, p.updated_at, p.name_id, ls.code;