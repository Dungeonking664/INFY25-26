-- ============================================
-- AUFGABE 1: E-Commerce Inventar Schema
-- ============================================
CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS products (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    price REAL DEFAULT 0.0 CHECK (price > 0),
    category_id INTEGER NOT NULL,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- ============================================
-- AUFGABE 2: CHECK Constraint Überprüfung
-- ============================================
-- Der CHECK (price > 0) Constraint stellt sicher,
-- dass Preise immer positiv sind

-- ============================================
-- AUFGABE 3: Foreign Keys testen
-- ============================================

-- Aktiviere Foreign Key Enforcement
PRAGMA foreign_keys = ON;

-- Einfügen von gültigen Kategorien
INSERT INTO categories (id, name) VALUES (1, 'Electronics');
INSERT INTO categories (id, name) VALUES (2, 'Furniture');

-- Einfügen von gültigen Produkten (mit existierender category_id)
INSERT INTO products (id, name, price, category_id) VALUES (1, 'Laptop', 999.99, 1);
INSERT INTO products (id, name, price, category_id) VALUES (2, 'Desk Chair', 199.50, 2);

-- DOKUMENTATION DER FEHLERMELDUNG:
-- Wenn wir versuchen, ein Produkt mit ungültiger category_id einzufügen:
-- INSERT INTO products (id, name, price, category_id) VALUES (3, 'Invalid Product', 50.0, 999);
-- 
-- Resultat: FOREIGN KEY constraint failed (Fehlercode 19)
-- 
-- Dies zeigt, dass der Foreign Key korrekt funktioniert und verhindert,
-- dass Produkte mit nicht-existierenden Kategorien eingefügt werden.

-- Abfrage der eingefügten Daten
SELECT '=== CATEGORIES ===' as "RESULT";
SELECT * FROM categories;

SELECT '=== PRODUCTS ===' as "RESULT";
SELECT * FROM products; 