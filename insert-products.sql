-- Insert products from product_translations.csv
-- Fixed version that properly inserts all products

BEGIN;

-- Ensure uuid extension is available
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- First, insert all localized strings
INSERT INTO i18n.localized_string (id, code) VALUES
    (uuid_generate_v5(uuid_ns_dns(), 'product.shampoo.name'), 'product.shampoo.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.toothpaste.name'), 'product.toothpaste.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.soap.name'), 'product.soap.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.deodorant.name'), 'product.deodorant.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.lipstick.name'), 'product.lipstick.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.mascara.name'), 'product.mascara.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.foundation.name'), 'product.foundation.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.moisturizer.name'), 'product.moisturizer.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.nail_polish.name'), 'product.nail_polish.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.laundry_detergent.name'), 'product.laundry_detergent.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.dish_soap.name'), 'product.dish_soap.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.paper_towels.name'), 'product.paper_towels.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.toilet_paper.name'), 'product.toilet_paper.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.tissues.name'), 'product.tissues.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.ballpoint_pen.name'), 'product.ballpoint_pen.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.notebook.name'), 'product.notebook.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.adhesive_tape.name'), 'product.adhesive_tape.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.lip_balm.name'), 'product.lip_balm.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.bandages.name'), 'product.bandages.name'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.vacuum_cleaner.name'), 'product.vacuum_cleaner.name')
ON CONFLICT (code) DO NOTHING;

-- Insert products
INSERT INTO pc.product (id, name_id, sku, price) VALUES
    (uuid_generate_v5(uuid_ns_dns(), 'product.SHP-001'), uuid_generate_v5(uuid_ns_dns(), 'product.shampoo.name'), 'SHP-001', 12.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.TTP-001'), uuid_generate_v5(uuid_ns_dns(), 'product.toothpaste.name'), 'TTP-001', 4.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.SOP-001'), uuid_generate_v5(uuid_ns_dns(), 'product.soap.name'), 'SOP-001', 3.49),
    (uuid_generate_v5(uuid_ns_dns(), 'product.DEO-001'), uuid_generate_v5(uuid_ns_dns(), 'product.deodorant.name'), 'DEO-001', 6.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.LPS-001'), uuid_generate_v5(uuid_ns_dns(), 'product.lipstick.name'), 'LPS-001', 15.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.MSC-001'), uuid_generate_v5(uuid_ns_dns(), 'product.mascara.name'), 'MSC-001', 18.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.FND-001'), uuid_generate_v5(uuid_ns_dns(), 'product.foundation.name'), 'FND-001', 24.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.MST-001'), uuid_generate_v5(uuid_ns_dns(), 'product.moisturizer.name'), 'MST-001', 19.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.NPL-001'), uuid_generate_v5(uuid_ns_dns(), 'product.nail_polish.name'), 'NPL-001', 8.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.LDT-001'), uuid_generate_v5(uuid_ns_dns(), 'product.laundry_detergent.name'), 'LDT-001', 14.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.DSP-001'), uuid_generate_v5(uuid_ns_dns(), 'product.dish_soap.name'), 'DSP-001', 3.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.PTW-001'), uuid_generate_v5(uuid_ns_dns(), 'product.paper_towels.name'), 'PTW-001', 9.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.TPR-001'), uuid_generate_v5(uuid_ns_dns(), 'product.toilet_paper.name'), 'TPR-001', 12.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.TSS-001'), uuid_generate_v5(uuid_ns_dns(), 'product.tissues.name'), 'TSS-001', 2.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.PEN-001'), uuid_generate_v5(uuid_ns_dns(), 'product.ballpoint_pen.name'), 'PEN-001', 1.49),
    (uuid_generate_v5(uuid_ns_dns(), 'product.NTB-001'), uuid_generate_v5(uuid_ns_dns(), 'product.notebook.name'), 'NTB-001', 4.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.ATP-001'), uuid_generate_v5(uuid_ns_dns(), 'product.adhesive_tape.name'), 'ATP-001', 3.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.LPB-001'), uuid_generate_v5(uuid_ns_dns(), 'product.lip_balm.name'), 'LPB-001', 3.49),
    (uuid_generate_v5(uuid_ns_dns(), 'product.BND-001'), uuid_generate_v5(uuid_ns_dns(), 'product.bandages.name'), 'BND-001', 5.99),
    (uuid_generate_v5(uuid_ns_dns(), 'product.VCL-001'), uuid_generate_v5(uuid_ns_dns(), 'product.vacuum_cleaner.name'), 'VCL-001', 149.99)
ON CONFLICT (sku) DO NOTHING;

-- Insert all translations
INSERT INTO i18n.translation (id, localized_string_id, language, translation) VALUES
    -- Shampoo
    (uuid_generate_v5(uuid_ns_dns(), 'product.shampoo.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.shampoo.name'), 'en', 'Shampoo'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.shampoo.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.shampoo.name'), 'es', 'Champú'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.shampoo.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.shampoo.name'), 'fr', 'Shampooing'),
    -- Toothpaste
    (uuid_generate_v5(uuid_ns_dns(), 'product.toothpaste.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.toothpaste.name'), 'en', 'Toothpaste'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.toothpaste.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.toothpaste.name'), 'es', 'Pasta de dientes'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.toothpaste.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.toothpaste.name'), 'fr', 'Dentifrice'),
    -- Soap
    (uuid_generate_v5(uuid_ns_dns(), 'product.soap.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.soap.name'), 'en', 'Soap'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.soap.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.soap.name'), 'es', 'Jabón'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.soap.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.soap.name'), 'fr', 'Savon'),
    -- Deodorant
    (uuid_generate_v5(uuid_ns_dns(), 'product.deodorant.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.deodorant.name'), 'en', 'Deodorant'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.deodorant.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.deodorant.name'), 'es', 'Desodorante'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.deodorant.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.deodorant.name'), 'fr', 'Déodorant'),
    -- Lipstick
    (uuid_generate_v5(uuid_ns_dns(), 'product.lipstick.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.lipstick.name'), 'en', 'Lipstick'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.lipstick.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.lipstick.name'), 'es', 'Lápiz labial'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.lipstick.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.lipstick.name'), 'fr', 'Rouge à lèvres'),
    -- Mascara
    (uuid_generate_v5(uuid_ns_dns(), 'product.mascara.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.mascara.name'), 'en', 'Mascara'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.mascara.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.mascara.name'), 'es', 'Rímel'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.mascara.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.mascara.name'), 'fr', 'Mascara'),
    -- Foundation
    (uuid_generate_v5(uuid_ns_dns(), 'product.foundation.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.foundation.name'), 'en', 'Foundation'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.foundation.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.foundation.name'), 'es', 'Base de maquillaje'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.foundation.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.foundation.name'), 'fr', 'Fond de teint'),
    -- Moisturizer
    (uuid_generate_v5(uuid_ns_dns(), 'product.moisturizer.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.moisturizer.name'), 'en', 'Moisturizer'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.moisturizer.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.moisturizer.name'), 'es', 'Crema hidratante'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.moisturizer.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.moisturizer.name'), 'fr', 'Crème hydratante'),
    -- Nail Polish
    (uuid_generate_v5(uuid_ns_dns(), 'product.nail_polish.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.nail_polish.name'), 'en', 'Nail Polish'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.nail_polish.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.nail_polish.name'), 'es', 'Esmalte para las uñas'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.nail_polish.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.nail_polish.name'), 'fr', 'Vernis à ongles'),
    -- Laundry Detergent
    (uuid_generate_v5(uuid_ns_dns(), 'product.laundry_detergent.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.laundry_detergent.name'), 'en', 'Laundry Detergent'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.laundry_detergent.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.laundry_detergent.name'), 'es', 'Detergente para la ropa'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.laundry_detergent.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.laundry_detergent.name'), 'fr', 'Lessive'),
    -- Dish Soap
    (uuid_generate_v5(uuid_ns_dns(), 'product.dish_soap.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.dish_soap.name'), 'en', 'Dish Soap'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.dish_soap.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.dish_soap.name'), 'es', 'Lavavajillas'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.dish_soap.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.dish_soap.name'), 'fr', 'Liquide vaisselle'),
    -- Paper Towels
    (uuid_generate_v5(uuid_ns_dns(), 'product.paper_towels.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.paper_towels.name'), 'en', 'Paper Towels'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.paper_towels.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.paper_towels.name'), 'es', 'Toallas de papel'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.paper_towels.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.paper_towels.name'), 'fr', 'Essuie-tout'),
    -- Toilet Paper
    (uuid_generate_v5(uuid_ns_dns(), 'product.toilet_paper.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.toilet_paper.name'), 'en', 'Toilet Paper'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.toilet_paper.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.toilet_paper.name'), 'es', 'Papel higiénico'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.toilet_paper.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.toilet_paper.name'), 'fr', 'Papier toilette'),
    -- Tissues
    (uuid_generate_v5(uuid_ns_dns(), 'product.tissues.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.tissues.name'), 'en', 'Tissues'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.tissues.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.tissues.name'), 'es', 'Pañuelos de papel'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.tissues.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.tissues.name'), 'fr', 'Mouchoirs en papier'),
    -- Ballpoint Pen
    (uuid_generate_v5(uuid_ns_dns(), 'product.ballpoint_pen.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.ballpoint_pen.name'), 'en', 'Ballpoint Pen'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.ballpoint_pen.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.ballpoint_pen.name'), 'es', 'Bolígrafo'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.ballpoint_pen.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.ballpoint_pen.name'), 'fr', 'Stylo à bille'),
    -- Notebook
    (uuid_generate_v5(uuid_ns_dns(), 'product.notebook.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.notebook.name'), 'en', 'Notebook'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.notebook.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.notebook.name'), 'es', 'Cuaderno'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.notebook.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.notebook.name'), 'fr', 'Cahier'),
    -- Adhesive Tape
    (uuid_generate_v5(uuid_ns_dns(), 'product.adhesive_tape.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.adhesive_tape.name'), 'en', 'Adhesive Tape'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.adhesive_tape.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.adhesive_tape.name'), 'es', 'Cinta adhesiva'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.adhesive_tape.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.adhesive_tape.name'), 'fr', 'Ruban adhésif'),
    -- Lip Balm
    (uuid_generate_v5(uuid_ns_dns(), 'product.lip_balm.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.lip_balm.name'), 'en', 'Lip Balm'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.lip_balm.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.lip_balm.name'), 'es', 'Bálsamo labial'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.lip_balm.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.lip_balm.name'), 'fr', 'Baume à lèvres'),
    -- Bandages
    (uuid_generate_v5(uuid_ns_dns(), 'product.bandages.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.bandages.name'), 'en', 'Bandages'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.bandages.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.bandages.name'), 'es', 'Vendas'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.bandages.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.bandages.name'), 'fr', 'Pansements'),
    -- Vacuum Cleaner
    (uuid_generate_v5(uuid_ns_dns(), 'product.vacuum_cleaner.name.en'), uuid_generate_v5(uuid_ns_dns(), 'product.vacuum_cleaner.name'), 'en', 'Vacuum Cleaner'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.vacuum_cleaner.name.es'), uuid_generate_v5(uuid_ns_dns(), 'product.vacuum_cleaner.name'), 'es', 'Aspiradora'),
    (uuid_generate_v5(uuid_ns_dns(), 'product.vacuum_cleaner.name.fr'), uuid_generate_v5(uuid_ns_dns(), 'product.vacuum_cleaner.name'), 'fr', 'Aspirateur')
ON CONFLICT (localized_string_id, language) DO NOTHING;

-- Add sample approvals for some English translations
INSERT INTO i18n.approval (id, translation_id, approved_by, approved_at)
SELECT 
    uuid_generate_v5(uuid_ns_dns(), 'approval.' || t.id::text),
    t.id,
    'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a31'::uuid,
    NOW() - (RANDOM() * INTERVAL '30 days')
FROM i18n.translation t
JOIN i18n.localized_string ls ON t.localized_string_id = ls.id
WHERE t.language = 'en' 
AND ls.code IN (
    'product.shampoo.name',
    'product.toothpaste.name',
    'product.soap.name',
    'product.deodorant.name',
    'product.lipstick.name'
)
ON CONFLICT DO NOTHING;

COMMIT;

-- Show counts
SELECT 'Total products:', COUNT(*) FROM pc.product;
SELECT 'Total translations:', COUNT(*) FROM i18n.translation;
SELECT 'Total approvals:', COUNT(*) FROM i18n.approval;