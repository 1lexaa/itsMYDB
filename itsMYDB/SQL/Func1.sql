-- Функции - пользовательские объекты, хранящиеся в СУБД
/*
CREATE OR ALTER FUNCTION 						-- Команда создания
	random( @bound INT)									-- Имя функции, скобки обязательны
	RETURNS INT									-- Тип возврата
AS												-- 
BEGIN											-- Тело функции
	DECLARE @R BIGINT
	SET @R = CHECKSUM( CURRENT_TIMESTAMP )
	SET @R = @R * @R % @bound
	RETURN CAST( ABS(@R) AS INT	)							-- RETURN - обязательно
END								 
	*/
 SELECT dbo.random(100) -- При обращении нужно указать имя БД