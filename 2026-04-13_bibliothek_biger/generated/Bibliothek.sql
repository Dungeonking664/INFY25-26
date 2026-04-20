CREATE TABLE Leser (
	id int NOT NULL,
	name text NOT NULL,
	email text NOT NULL,
	mitglied_seit text NOT NULL,
	PRIMARY KEY (id)
);
CREATE TABLE Buch (
	id int NOT NULL,
	titel text NOT NULL,
	autor text NOT NULL,
	isbn text NOT NULL,
	erscheinungsjahr int NOT NULL,
	PRIMARY KEY (id)
);
CREATE TABLE Ausleihe (
	id int NOT NULL,
	leser_id int NOT NULL,
	buch_id int NOT NULL,
	ausleihdatum text NOT NULL,
	rueckgabedatum text NOT NULL,
	anzahl_tag int NOT NULL,
	PRIMARY KEY (id)
);
CREATE TABLE relationship1 (
	id2 int NOT NULL,	-- renamed from: id
	id3 int NOT NULL,	-- renamed from: id
	id VARCHAR(255) NOT NULL,	-- added default type
	PRIMARY KEY (id2, id3),
	FOREIGN KEY (id2) REFERENCES Ausleihe (id) ON DELETE CASCADE,
	FOREIGN KEY (id3) REFERENCES Leser (id) ON DELETE CASCADE
);
