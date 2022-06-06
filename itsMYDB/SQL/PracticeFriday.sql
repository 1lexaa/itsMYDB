-- Вывести всех сотрудников IT отдела (и основных, и заместителей)
/*
SELECT
	ROW_NUMBER() OVER(ORDER BY M.Surname ASC) AS[№ по порядку],
	CONCAT(M.SURNAME, 
		' ', SUBSTRING(M.Name, 1, 1),
		'.', SUBSTRING(M.Secname, 1, 1), '.') AS [ФИО осн]
FROM
	Managers M
WHERE 
	M.Id_main_dep = 'D3C376E4-BCE3-4D85-ABA4-E3CF49612C94'
	OR M.Id_sec_dep = 'D3C376E4-BCE3-4D85-ABA4-E3CF49612C94'
ORDER BY 
	1 ASC
	*/
-- Вывести кол-во сотрудников IT отдела
-- Подзадача: добавить надпись IT Отдел
/*SELECT
	N'IT отдел'	AS [Отдел],
	(
	 SELECT COUNT(M.Id)
	 FROM
		Managers M
		JOIN Departments D ON M.Id_main_dep = D.Id
	 WHERE 
		M.Id_main_dep = 'D3C376E4-BCE3-4D85-ABA4-E3CF49612C94'
	) AS [Основных сотрудников],
	(SELECT COUNT(M.Id)
	 FROM
		Managers M
		JOIN Departments D ON M.Id_sec_dep = D.Id
	 WHERE 
		M.Id_sec_dep = 'D3C376E4-BCE3-4D85-ABA4-E3CF49612C94')  AS [Совместителей сотрудников]
ORDER BY 1 

-- В другой форме: Вывести
-- Форма				Айти отдел		
-- Основных сотр			6
-- Совместит сотр			3
SELECT
	N' Основных сотр'	AS [Форма],
	COUNT(M.Id)			AS [IT отдел]
FROM
	Managers M
WHERE 
	M.Id_main_dep = 'D3C376E4-BCE3-4D85-ABA4-E3CF49612C94'
UNION
SELECT
	N' Совместителей',
	COUNT(M.Id)		
FROM
	Managers M
WHERE 
	M.Id_sec_dep = 'D3C376E4-BCE3-4D85-ABA4-E3CF49612C94' 
	
-- Вывести товары за текущий месяц по сравнению с предыдущим месяцем
SELECT
	MAX(MONTH(S.Moment))					AS [Date],
    COUNT(S.ID)								AS [Чеков],
    SUM(S.Cnt)								AS [Товаров, шт],
    ROUND(SUM(S.Cnt * P.Price), 2)		    AS [Оборот, грн]
FROM
    Sales S
    JOIN Products P ON S.ID_product = P.Id
WHERE
    MONTH(S.Moment) = MONTH(CURRENT_TIMESTAMP)
UNION ALL
SELECT
	MAX(MONTH(S.Moment)),			
    COUNT(S.ID),					
    SUM(S.Cnt),					
    ROUND(SUM(S.Cnt * P.Price), 2)	    
FROM
    Sales S
    JOIN Products P ON S.ID_product = P.Id
WHERE
    MONTH(S.Moment) = MONTH(CURRENT_TIMESTAMP + DATEADD(MONTH, -1, 0))
	



	 */

	/*
	(VALUES
	(1, N'January'), (2, N'February'), 
	(3, N'March'), (4, N'April'), (5, N'May'), 
	(6, N'June'), (7, N'July'), (8, N'August'),
	(9, N'September'), (10, N'October'), (11, N'November'),
	(12, N'December')) MonthNames(Id, Name)
	
-- Вывести статистику за все месяцы года
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
ORDER BY Stat.[Месяц] */

-- Вывести только тех сотрудников, которые не продавали гвозди за сегодня
SELECT 
	MAX(M.Name + ' ' + M.Surname) AS [Имя],
	COUNT(ManSales.pcs) AS [Продаж]
FROM
	Managers M
	 LEFT JOIN
	(
		SELECT            -- таблица сотрудников, продавших гвозди
		  S.Id_manager,
		  SUM(S.Cnt)    AS pcs
		FROM
		  Sales S
		  JOIN Products P ON S.ID_product = P.Id
		WHERE
		  CAST(S.Moment AS DATE) = CAST(CURRENT_TIMESTAMP - DATEADD(YEAR, 1, 0) AS DATE) -- условие: "за сегодня" 
		  AND P.Name LIKE N'%гвозд%' -- и товар гвозди
		GROUP BY
		  S.Id_manager
  ) ManSales
ON M.Id = ManSales.ID_manager
WHERE                
  COALESCE(ManSales.pcs, 0) = 0 -- выводим всех сотрудников, у которых продажи гвоздей = 0
GROUP BY 
	M.Id
ORDER BY 
	1 ASC


