# Hausübung: DDL & Constraints – Dokumentation

## Übersicht
Diese Hausübung behandelt SQL-Constraints und Integritätsregeln in SQLite.

---

## Aufgabe 1: E-Commerce Inventar Schema ✅

### Tabellendefinition:
- **categories**: id (PK), name (NOT NULL)
- **products**: id (PK), name (NOT NULL), price (DEFAULT 0.0), category_id (FK, NOT NULL)

### Umsetzung:
```sql
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
```

---

## Aufgabe 2: CHECK Constraint ✅

### Anforderung:
Füge einen CHECK Constraint auf `price` hinzu, damit dieser niemals negativ sein kann.

### Umsetzung:
```sql
price number default 0.0 check (price > 0)
```

**Erklärung:** Der `CHECK (price > 0)` Constraint stellt sicher, dass der Preis immer größer als 0 ist. Der DEFAULT-Wert ist 0.0, kann aber bei Bedarf überschrieben werden.

---

## Aufgabe 3: Foreign Keys testen ✅

### Anforderung:
- Aktiviere Foreign Keys mit `PRAGMA foreign_keys = ON;`
- Versuche ein Produkt mit ungültiger `category_id` (z.B. 999) einzufügen
- Dokumentiere die Fehlermeldung

### Test-Durchführung:

#### Schritt 1: Korrekte Daten einfügen
```sql
PRAGMA foreign_keys = ON;

INSERT INTO categories (id, name) VALUES (1, 'Electronics');
INSERT INTO categories (id, name) VALUES (2, 'Furniture');

INSERT INTO products (id, name, price, category_id) VALUES (1, 'Laptop', 999.99, 1);
INSERT INTO products (id, name, price, category_id) VALUES (2, 'Desk Chair', 199.50, 2);
```

**Ergebnis:** ✅ Erfolgreich – Beide Produkte wurden eingefügt.

#### Schritt 2: Foreign Key Verletzung testen
```sql
INSERT INTO products (id, name, price, category_id) VALUES (3, 'Invalid Product', 50.0, 999);
```

**Fehlermeldung:**
```
Runtime error: FOREIGN KEY constraint failed (19)
```

### Erklärung:
Der Fehler zeigt, dass SQLite die Foreign Key-Constraint erfolgreich durchsetzt. Die `category_id` 999 existiert in der `categories`-Tabelle nicht, daher wird die Einfügung blockiert. Der Fehlercode 19 steht für "Constraint Violation".

---

## Zusammenfassung

| Constraint | Status | Überprüfung |
|-----------|--------|-------------|
| PRIMARY KEY | ✅ | Beide Tabellen haben PK |
| NOT NULL | ✅ | `name` und `category_id` sind NOT NULL |
| CHECK | ✅ | `price > 0` funktioniert |
| FOREIGN KEY | ✅ | Verletzung wird korrekt blockiert |

