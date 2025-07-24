-- Create schemas
CREATE SCHEMA IF NOT EXISTS pc;
CREATE SCHEMA IF NOT EXISTS i18n;

-- Create i18n.localized_string table
CREATE TABLE i18n.localized_string (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code TEXT NOT NULL UNIQUE
);

-- Create i18n.translation table
CREATE TABLE i18n.translation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    localized_string_id UUID NOT NULL REFERENCES i18n.localized_string(id) ON DELETE CASCADE,
    language VARCHAR(10) NOT NULL,
    translation TEXT NOT NULL,
    UNIQUE(localized_string_id, language)
);

-- Create i18n.approval table
CREATE TABLE i18n.approval (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    translation_id UUID NOT NULL REFERENCES i18n.translation(id) ON DELETE CASCADE,
    approved_by UUID NOT NULL,
    approved_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    UNIQUE(translation_id)
);

-- Create pc.product table
CREATE TABLE pc.product (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name_id UUID NOT NULL REFERENCES i18n.localized_string(id),
    sku VARCHAR(100) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_translation_localized_string_id ON i18n.translation(localized_string_id);
CREATE INDEX idx_translation_language ON i18n.translation(language);
CREATE INDEX idx_approval_translation_id ON i18n.approval(translation_id);
CREATE INDEX idx_product_name_id ON pc.product(name_id);

-- Insert sample data
-- Insert localized strings
INSERT INTO i18n.localized_string (id, code) VALUES 
    ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'product.laptop.name'),
    ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'product.mouse.name'),
    ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'product.keyboard.name');

-- Insert translations
INSERT INTO i18n.translation (id, localized_string_id, language, translation) VALUES
    ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'en', 'Laptop Computer'),
    ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'es', 'Computadora Portátil'),
    ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'fr', 'Ordinateur Portable'),
    ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'en', 'Wireless Mouse'),
    ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'es', 'Ratón Inalámbrico'),
    ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'en', 'Mechanical Keyboard');

-- Insert approvals
INSERT INTO i18n.approval (translation_id, approved_by, approved_at) VALUES
    ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a31', '2024-01-15 10:30:00+00'),
    ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a32', '2024-01-16 14:20:00+00'),
    ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a31', '2024-01-17 09:15:00+00');

-- Insert products
INSERT INTO pc.product (name_id, sku, price) VALUES
    ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'LAP-001', 999.99),
    ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'MOU-001', 29.99),
    ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'KEY-001', 149.99);