-- табличные функции
--CREATE FUNCTION 
--	Deps()
--	RETURNS TABLE
--AS
--	RETURN ( SELECT * FROM Departments )
	
-- SELECT * FROM dbo.Deps()

--CREATE FUNCTION
--	MonthNames()
--	RETURNS TABLE
--	AS
--	RETURN (SELECT * FROM (VALUES
--	(1, N'Январь'),
--	(2, N'Февраль'),
--	(3, N'Март'),
--	(4, N'Апрель'),
--	(5, N'Май'),
--	(6, N'Июнь'),
--	(7, N'Июль'),
--	(8, N'Август'),
--	(9, N'Сентябрь'),
--	(10,N'Октябрь'),
--	(11,N'Ноябрь'),
--	(12,N'Декабрь') ) Names(Id, Name) )

-- SELECT * FROM dbo.MonthNames() MN WHERE MN.Id = 5

--SELECT
--	MN.Name AS [Месяц],
--	Stat.Чеков,
--	Stat.[Товаров, шт],
--	Stat.[Оборот, грн]
--FROM
--	(
--	SELECT
--		MONTH(S.Moment)							AS [Месяц],
--	    COUNT(S.ID)								AS [Чеков],
--	    SUM(S.Cnt)								AS [Товаров, шт],
--	    ROUND(SUM(S.Cnt * P.Price), 2)		    AS [Оборот, грн]
--	FROM
--	    Sales S
--	    JOIN Products P ON S.ID_product = P.Id
--	GROUP BY MONTH(S.Moment)) Stat
--	JOIN dbo.MonthNames() MN
--	ON Stat.[Месяц] = MN.Id
--ORDER BY Stat.[Месяц]

--CREATE FUNCTION
--	YearStat(
--		@year SMALLINT	-- год передаем аргументом
--		) RETURNS TABLE
--AS
--	RETURN (
--		SELECT
--			MONTH(S.Moment)							AS MonthId,
--		    COUNT(S.ID)								AS TotalSales,
--		    SUM(S.Cnt)								AS TotalCnt,
--		    ROUND(SUM(S.Cnt * P.Price), 2)		    AS TotalSum
--		FROM
--		    Sales S
--		    JOIN Products P ON S.ID_product = P.Id
--		WHERE 
--			YEAR(S.Moment) = @year
--		GROUP BY 
--			MONTH(S.Moment)
--	)

--SELECT
--	MN.Name			AS [Месяц],
--	Stat.TotalCnt	AS [Чеков],
--	Stat.TotalSales AS [Товаров, шт],
--	Stat.TotalSum	AS [Оборот, грн]
--FROM
--	dbo.YearStat(2021) Stat
--	JOIN dbo.MonthNames() MN ON Stat.MonthId = MN.Id
--ORDER BY Stat.MonthId

--CREATE FUNCTION MonthNamesUk() RETURNS TABLE
-- AS
--  RETURN (SELECT * FROM (VALUES
--	(1, N'Січень'),
--	(2, N'Лютий'),
--	(3, N'Березень'),
--	(4, N'Квітень'),
--	(5, N'Травень'),
--	(6, N'Червень'),
--	(7, N'Липень'),
--	(8, N'Серпень'),
--	(9, N'Вересень'),
--	(10,N'Жовтень'),
--	(11,N'Листопад'),
--	(12,N'Грудень') ) Names(Id, Name) )

SELECT
	MN.Name			AS [Месяц],
	Stat.TotalCnt	AS [Чеков],
	Stat.TotalSales AS [Товаров, шт],
	Stat.TotalSum	AS [Оборот, грн]
FROM
	dbo.YearStat(2021) Stat
	JOIN dbo.MonthNamesUK() MN ON Stat.MonthId = MN.Id
ORDER BY Stat.MonthId



