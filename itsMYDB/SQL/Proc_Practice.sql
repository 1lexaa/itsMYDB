--Get_year_stat запрос с статистикой за каждый месяц года, *год передавать как аргумент

/* CREATE OR ALTER PROC
	Get_year_stat
	@month DATETIME
AS
BEGIN
	SELECT
		MonthNames.Name AS [Месяц],
		Stat.Чеков,
		Stat.[Товаров, шт],
		Stat.[Оборот, грн]
	FROM
		(
		SELECT
			MONTH(S.Moment)							AS [Месяц],
		    COUNT(S.ID)								AS [Чеков],
		    SUM(S.Cnt)								AS [Товаров, шт],
		    ROUND(SUM(S.Cnt * P.Price), 2)		    AS [Оборот, грн]
		FROM
		    Sales S
		    JOIN Products P ON S.ID_product = P.Id
		GROUP BY MONTH(S.Moment)) Stat
		JOIN (VALUES
		(1, N'January'), (2, N'February'), 
		(3, N'March'), (4, N'April'), (5, N'May'), 
		(6, N'June'), (7, N'July'), (8, N'August'),
		(9, N'September'), (10, N'October'), (11, N'November'),
		(12, N'December')) MonthNames(Id, Name) 
		ON Stat.[Месяц] = MonthNames.Id
	WHERE Stat.[Месяц] = @month
	ORDER BY Stat.[Месяц]
END
 EXECUTE Get_year_stat 5
 
--Find_prod 'fragment' - поиск среди товаров по заданному фрагменту
CREATE OR ALTER PROC
	Find_prod
	@fragment NVARCHAR(MAX)
AS
BEGIN
	SELECT 
		@fragment, 
		P.*
	FROM 
		Products P 
	WHERE P.Name LIKE CONCAT('%', @fragment, '%')
END
	
-- EXECUTE Find_prod N'гвозд'
--Find_man 'fragment' - поиск менеджеров (и по имени, и по фамилии, *и по отчеству)
CREATE OR ALTER PROC
	Find_man
	@fragment NVARCHAR(MAX)
AS
BEGIN
	SELECT 
		@fragment AS [Fragment], 
		M.*
	FROM 
		Managers M
	WHERE M.Name LIKE CONCAT('%', @fragment, '%') 
	OR M.Surname LIKE CONCAT('%', @fragment, '%')
	OR M.Secname LIKE CONCAT('%', @fragment, '%')
END 
-- EXECUTE Find_man N'Сергей'
--Daily_best_prod 'date' - самый продаваемый товар за указанную дату
CREATE OR ALTER PROC
	Daily_best_prod 
	@date AS DATE
AS
BEGIN
	SELECT TOP 1
		MAX(P.Name) AS [Product],
		COUNT(S.Id_product) AS [Count]
	FROM
		Sales S
		JOIN Products P ON S.Id_product = P.Id
	WHERE CAST(S.Moment AS DATE) = @date
	GROUP BY S.Id_product
	ORDER BY 1 
END
-- EXEC Daily_best_prod '2021-05-31'
-- Daily_best_man 'date' - сотрудник с лучшими показателями продаж (ФИО, отдел)
CREATE OR ALTER PROC
	Daily_best_man 
	@date AS DATE
AS
BEGIN
	SELECT TOP 1
		MAX(D.Name) [Department],
		CONCAT(MAX(M.Name), ' ', MAX(M.Secname), ' ',MAX(M.Surname)) [Name],
		COUNT(S.ID_manager) [Sold]
	FROM
		Sales S
		JOIN Managers M ON S.Id_manager = M.Id
		JOIN Departments D ON M.Id_main_dep = D.Id
	WHERE CAST(S.Moment AS DATE) = @date
	GROUP BY S.Id_manager
	ORDER BY 1 
END*/

EXEC Daily_best_man '2021-05-31'