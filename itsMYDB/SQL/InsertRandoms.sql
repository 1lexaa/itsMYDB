-- DML
INSERT INTO					   -- Команда внесения (записи) данных
	randoms					   -- в какую таблицу
VALUES (					   -- перечень значений - в порядке объявления таблицы
	NEWID(),				   -- попадет в id
	CHECKSUM( NEWID() )		   -- попадет в rnd
)							   -- 
								
INSERT INTO					   -- указываем перечень и порядок полей при внесении
	randoms( rnd, id )		   --
VALUES (					   --
	CHECKSUM( NEWID() ),	   -- на 1м месте рнд
	NEWID()					   -- на 2м айди
)

DELETE FROM randoms WHERE id = '88425C78-3CFA-465E-A2A7-997048E7F5FA'

INSERT INTO					  
	randoms( id, rnd )
VALUES (
	'88425C78-3CFA-465E-A2A7-997048E7F5FA',
	100500
)