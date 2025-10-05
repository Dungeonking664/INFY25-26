import { DatabaseSync } from "node:sqlite";
const db = new DatabaseSync("2ahwii.db");
let stmt = db.prepare("SELECT * FROM students");
const rows = stmt.all();

stmt = db.prepare("INSERT INTO students (name, birthdate) VALUES (?, ?)");
stmt.run("Soso", "2011-08-23");

stmt = db.prepare("SELECT * FROM students");
const rows2 = stmt.all();
console.log(rows2);