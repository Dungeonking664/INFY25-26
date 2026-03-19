CREATE TABLE categories (
    id int primary key,
    name text not null
)

CREATE TABLE products (
    id int primary key,
    name text,
    price number check (price > 0),
    category_id number not null CONSTRAINT fk_category REFERENCES categories(id)
) 