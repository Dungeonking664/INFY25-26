-- Join-Abfrage, um die Namen der Personen zusammen mit ihrem Lieblingsessen anzuzeigen
select a.name, b.essen from person a join essen b on a.lieblingsessen = b.id;

-- Abfrage, um die Namen der Personen zu finden, deren Lieblingsessen 'Mohnnudeln' ist
select name from person where lieblingsessen =(select id from essen where essen='Mohnnudeln');