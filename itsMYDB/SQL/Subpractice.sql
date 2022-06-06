-- Практика подзапросы/группирование
-- Вывести ВСЕХ менеджеров и кол-во проданных "гвоздей" за сегодня. 0 - если нет продаж
/*
SELECT 
	M.Surname + ' ' + SUBSTRING( M.Name, 1, 1) + '.' AS [Сотрудник],
	COALESCE(ManNails.Pcs, '0') AS [Продано гвоздей]
FROM
	Managers M
	LEFT JOIN 
	(
		SELECT 
			S.Id_manager,
			SUM( S.Cnt )	[Pcs]
		FROM
			Sales S
			JOIN Products P ON S.Id_product = P.Id
		WHERE
			 CAST(S.Moment AS DATE) = CAST(CURRENT_TIMESTAMP - DATEADD(YEAR,1,0) AS DATE) 
			AND S.Id_product IN (SELECT P.Id FROM Products P WHERE P.Name LIKE N'%гвозд%')
		GROUP BY
			S.Id_manager
	) ManNails 
	ON M.Id = ManNails.Id_manager
ORDER BY 2 DESC, 1 ASC */

-- Д.З. Вывести ВСЕ отделы и кол-во проданных "гвоздей" иx сотрудниками за сегодня. 
-- 0 - если нет продаж
SELECT
	MIN(D.Name) [Отдел],
	COALESCE(SUM(DepSales.[Продано гвоздей]), '0') AS [Продано гвоздей]
FROM
	Departments D
	LEFT JOIN (
		SELECT 
			M.Id_main_dep [DepId],
			ManSales.[Продано гвоздей]
		FROM
			Managers M 
			JOIN (SELECT
					S.Id_manager AS [Сотрудник],
					SUM(S.Cnt) AS [Продано гвоздей]
				  FROM Sales S
				  WHERE
					CAST(S.Moment AS DATE) = CAST(CURRENT_TIMESTAMP - DATEADD(YEAR,1,0) AS DATE) 
					AND S.Id_product IN (SELECT P.Id FROM Products P WHERE P.Name LIKE N'%гвозд%')
					GROUP BY S.Id_manager
				) ManSales ON ManSales.Сотрудник = M.Id
	) DepSales ON D.Id = DepSales.DepId
GROUP BY
	DepSales.DepId
ORDER BY
	2 ASC, 1 ASC
	
	