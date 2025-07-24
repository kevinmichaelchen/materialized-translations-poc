-- PostgreSQL publication setup
-- Run this in PostgreSQL after the initial setup

-- Enable logical replication
ALTER SYSTEM SET wal_level = logical;

-- Create publication for Materialize
CREATE PUBLICATION mz_source FOR TABLE 
    pc.product,
    i18n.localized_string,
    i18n.translation,
    i18n.approval;

-- You may need to restart PostgreSQL after changing wal_level
-- docker-compose restart postgres