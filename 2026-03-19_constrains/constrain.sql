-- Aufgabe 1: E-Commerce Inventar Schema
CREATE TABLE categories (
    id int primary key,
    name text not null
);

CREATE TABLE products (
    id int primary key,
    name text not null,
    price number default 0.0 check (price > 0),
    category_id number not null CONSTRAINT fk_category REFERENCES categories(id)
);

-- Aufgabe 3: Foreign Keys testen
PRAGMA foreign_keys = ON;

-- Erst eine gültige Kategorie einfügen
INSERT INTO categories (id, name) VALUES (1, 'Electronics');
INSERT INTO categories (id, name) VALUES (2, 'Furniture');

-- Gültige Produkte einfügen (sollten funktionieren)
INSERT INTO products (id, name, price, category_id) VALUES (1, 'Laptop', 999.99, 1);
INSERT INTO products (id, name, price, category_id) VALUES (2, 'Desk Chair', 199.50, 2);

-- Versuchen, ein Produkt mit ungültiger category_id einzufügen
-- INSERT INTO products (id, name, price, category_id) VALUES (3, 'Invalid Product', 50.0, 999);
-- Fehlermeldung: FOREIGN KEY constraint failed

-- Überprüfe erfolgreiche Inserts
SELECT * FROM categories;
SELECT * FROM products; 