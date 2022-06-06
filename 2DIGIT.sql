SELECT 
	CONCAT( Faces.Name, ' ', Suits.Name ) AS PlayingCards
FROM 
	(VALUES ('6'), ('7'), ('8'), ('9'), ('10'), ('J'), ('Q'), ('K'), ('A')) AS Faces(Name),
	(VALUES ('Speak'), ('Clubs'), ('Diamonds'), ('Hearts')) AS Suits(Name)
ORDER BY 
	NEWID()