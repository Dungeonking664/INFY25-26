 create table leser (

     id INTEgER PRIMARY KEY AUTOINCREMENT,
     name TEXT NOT NULL,
     email TEXT NOT NULL UNIQUE,
    mitglied_seit TEXT NOT NULL);

 create table buch ( 

    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titel TEXT NOT NULL,
    autor TEXT NOT NULL,
    isbn TEXT UNIQUE,
    erscheinungsjahr INTEGER);

 create table ausleihe(

     leser_id INTEGER NOT NULL,
     buch_id INTEGER NOT NULL, 
     ausleih_datum TEXT NOT NULL,
    rueckgabe_datum TEXT,
    anzahl_tage INTEGER NOT NULL,
    PRIMARY KEY (leser_id, buch_id, ausleih_datum),
    FOREIGN KEY (leser_id) REFERENCES leser(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (buch_id) REFERENCES buch(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (anzahl_tage > 0));

 create index idx_leser_name on leser(name);
 create index idx_buch_titel on buch(titel);
 create index idx_buchausgeliehen on ausleihe(rueckgabe_datum);

 Eine Bibliothek hat ja viele Leser und Bücher bei einer so großen menege an Lesern ist es sinnvoll
 den Index auf den Namen der Leser zu setzen damit man schnell die Leser findet. Genauso ist es bei den
 Büchern. Ausßerdem werden Bücher und Namen sicher auch öfter in Joints gebraucht.
 Der driite Index ist auch wichtig damit man nicht die ganze Tabelle durchsuchen muss damit
 man die ausgeliehenen Bücher findet.

 
 insert into leser (name, email, mitglied_seit) values ('Max Mustermann', 'max@email.de', '2023-01-15');
 insert into leser (name, email, mitglied_seit) values ('Maria Musterfrau', 'maria@email.de', '2023-03-20');
 insert into leser (name, email, mitglied_seit) values ('Peter Schmidt', 'peter@email.de', '2024-01-10');

 insert into buch (titel, autor, isbn, erscheinungsjahr) values ('Der Herr der Ringe', 'J.R.R. Tolkien', '978-3608939791', 1954);
 insert into buch (titel, autor, isbn, erscheinungsjahr) values ('Harry Potter 1', 'J.K. Rowling', '978-3551551679', 1997);
 insert into buch (titel, autor, isbn, erscheinungsjahr) values ('Die Verwandlung', 'Franz Kafka', '978-3150099007', 1915);
 insert into buch (titel, autor, isbn, erscheinungsjahr) values ('1984', 'George Orwell', '978-3548234106', 1949);

 insert into ausleihe (leser_id, buch_id, ausleih_datum, rueckgabe_datum, anzahl_tage) values (1, 1, '2024-01-10', '2024-01-24', 14);
 insert into ausleihe (leser_id, buch_id, ausleih_datum, rueckgabe_datum, anzahl_tage) values (1, 2, '2024-02-01', NULL, 10);
 insert into ausleihe (leser_id, buch_id, ausleih_datum, rueckgabe_datum, anzahl_tage) values (2, 4, '2024-01-15', '2024-01-22', 7);
 insert into ausleihe (leser_id, buch_id, ausleih_datum, rueckgabe_datum, anzahl_tage) values (2, 1, '2024-02-05', NULL, 21);
 insert into ausleihe (leser_id, buch_id, ausleih_datum, rueckgabe_datum, anzahl_tage) values (3, 3, '2024-01-20', '2024-01-25', 5);


select l.name,b.titel, a.anzahl_tage from ausleihe a join leser l on a.leser_id = l.id join buch b on a.buch_id = b.id order by a.ausleih_datum;

select b.titel, l.name, a.ausleih_datum from ausleihe a join buch b on a.buch_id = b.id join leser l on a.leser_id = l.id where a.rueckgabe_datum IS NULL; 

select b.titel,count(a.ausleih_datum) from ausleihe a right  join buch b on a.buch_id = b.id group by buch_id;

select l.name as Lesername, count(a.buch_id) as anzahlbuecher from ausleihe a join leser l on a.leser_id = l.id  group by leser_id order by count(a.buch_id) desc limit 1;


create view aktuelle_ausleihen as
select l.name as Lesername, b.titel as Buchtitel, a.ausleih_datum from ausleihe a join leser l on a.leser_id = l.id join buch b on a.buch_id = b.id where a.rueckgabe_datum IS NULL;

