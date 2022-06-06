--  Передача параметров в процедуру
/*
CREATE OR ALTER PROC
	Get_stat_month	-- имя
	@month INT		-- Параметры следуют после имени через пробел потом через "."
AS 
	SELECT
		SUM(S.Cnt) AS Month_Cnt
	FROM 
		Sales S
	WHERE 
		MONTH(S.Moment) = @month

EXEC Get_stat_month @month = 5
EXEC Get_stat_month 5
	
-- Задание: определить процедуру для приема  параметра @moment типа DATETIME,
-- данные о месяце извлечь из этой переменной
CREATE OR ALTER PROC
	Get_stat_moment
	@moment DATETIME	
AS 
	SELECT
		SUM(S.Cnt) AS Moment_Cnt
	FROM 
		Sales S
	WHERE 
		MONTH(S.Moment) = MONTH(@moment)
	
 EXEC Get_stat_moment '2021-03-21'

 -- Два параметра
CREATE OR ALTER PROC
	Get_Stat_Interval
	@from DATETIME,
	@to DATETIME
AS
SELECT
		SUM(S.Cnt) AS Interval_Cnt
	FROM 
		Sales S
	WHERE 
		S.Moment BETWEEN @from AND @to 
	EXEC Get_stat_Interval '2021-03-21', '2021-04-21'*/

