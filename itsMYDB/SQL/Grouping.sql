-- Grouping
/*
SELECT
	P.Name [Продукт],
	COUNT(S.Id) [Кол-во чеков, шт.],
	MAX(P.Id)
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
WHERE
	CAST( S.Moment AS DATE) = CAST(( CURRENT_TIMESTAMP + (DATEADD(YEAR, -1, 0) )) AS DATE)
GROUP BY
	P.Name
ORDER BY 
	1 ASC
	
SELECT
	MAX(P.Name) [Продукт],
	COUNT(S.Id) [Кол-во чеков, шт.],
	P.Id
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
WHERE
	CAST( S.Moment AS DATE) = CAST(( CURRENT_TIMESTAMP + (DATEADD(YEAR, -1, 0) )) AS DATE)
GROUP BY
	P.Id
ORDER BY 
	1 ASC

SELECT
	MAX(P.Name) AS [Продукт],
	COUNT(S.Id) AS [Кол-во чеков, шт.],
	SUM(S.Cnt) AS [Продано],
	CONCAT(SUM(P.Price * S.Cnt), ' UAH') AS [Сумма, грн.]
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
WHERE
	CAST( S.Moment AS DATE) = CAST(( CURRENT_TIMESTAMP + (DATEADD(YEAR, -1, 0) )) AS DATE)
GROUP BY
	P.Id
ORDER BY 
	3 DESC */
	
-- ФИО, Чеков, Штук, ГРН
SELECT
	MAX(CONCAT(M.Name, ' ', M.Surname)) AS [ФИО],
	MAX(CONCAT(M.Name, ' ', M.Surname)) AS [ФИО],
	COUNT(S.Id) AS [Кол-во чеков, шт.],
	SUM(S.Cnt) AS [Продано],
	CONCAT(SUM(P.Price * S.Cnt), ' UAH') AS [Сумма, грн.]
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
WHERE
	CAST( S.Moment AS DATE) = CAST(( CURRENT_TIMESTAMP + (DATEADD(YEAR, -1, 0) )) AS DATE)
	AND P.Name LIKE N'%гвозд%'
GROUP BY
	M.Id
ORDER BY 
	3 DESC

-- HOMEWORK
-- Вывести данные о продажах (кол-во чеков, кол-во штук, сумма грн) "за сегодня" по отделам

SELECT
	MAX(D.Name) AS [Отдел],
	COUNT(S.Id) AS [Кол-во чеков, шт.],
	SUM(S.Cnt) AS [Продано],
	CONCAT(SUM(P.Price * S.Cnt), ' UAH') AS [Сумма, грн.]
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
	JOIN Departments D ON M.Id_main_dep = D.Id
WHERE
	CAST( S.Moment AS DATE) = CAST(( CURRENT_TIMESTAMP + (DATEADD(YEAR, -1, 0) )) AS DATE)
GROUP BY
	D.Id
ORDER BY 
	4 DESC