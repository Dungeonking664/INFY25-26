import { DatabaseSync } from "node:sqlite";

const db = new DatabaseSync("w3schools.sqlite");

db.exec(`
  CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INTEGER PRIMARY KEY AUTOINCREMENT,
    CustomerName TEXT,
    ContactName TEXT,
    Address TEXT,
    City TEXT,
    PostalCode TEXT,
    Country TEXT
  )
`);

const insert = db.prepare(
  "INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country) VALUES (?, ?, ?, ?, ?, ?)",
);
const updateAddress = db.prepare(
  "UPDATE Customers SET Address = ? WHERE ContactName = ?",
);
const deleteByName = db.prepare("DELETE FROM Customers WHERE CustomerName = ?");
const selectByContact = db.prepare(
  "SELECT * FROM Customers WHERE ContactName = ?",
);

insert.run("Robert", "Danke", "Spengergasse", "Vienna", "1050", "Austria");
console.log("Nach Einfügen:", selectByContact.all("Danke"));

updateAddress.run("Kärntnerstrasse", "Danke");
console.log("Nach Update:", selectByContact.all("Danke"));

deleteByName.run("Robert");
console.log("Nach Löschen:", selectByContact.all("Danke"));
