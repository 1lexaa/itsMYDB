-- Хранимые процедуры
/*
CREATE PROCEDURE -- можно сокращенно до CREATE PROC
	Get_stat	 -- имя
AS				 -- начало определения
BEGIN		     -- операторные скобки
	SELECT								   -- тело процедуры
		SUM(S.Cnt) AS Total_Cnt			   -- обязательно должно
	FROM								   -- закончиться командой
		Sales S							   -- SELECT
END
*/
-- Вызов процедуры
-- Вне стандарта 
Get_stat 

-- Полный синтаксис
EXECUTE Get_stat 
-- Сокращенный стандарт
EXEC Get_stat 

