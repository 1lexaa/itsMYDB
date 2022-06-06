-- Соединение нескольких таблиц
-- Задача: вывести весь журнал "за сегодня" - за 23.05.2021
/*
SELECT
	S.Moment	AS [Дата],
	P.Name		AS [Товар],
	S.Cnt		AS [Кол-во],
	M.Surname	AS [Продал]
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
WHERE
	-- S.Moment = '2021-05-23' -- = '2021-05-23 00:00:00.000'
	-- S.Moment BETWEEN '2021-05-23' AND '2021-05-24'
	-- S.Moment BETWEEN '2021-05-23' AND DATEADD(DAY, 1, '2021-05-24')
	CAST( S.Moment AS DATE) = CAST(( CURRENT_TIMESTAMP + (DATEADD(YEAR, -1, 0) )) AS DATE)
ORDER BY S.Moment ASC
*/

-- HOMEWORK --
-- Только одна штука товара
/*
SELECT 
	S.Moment	AS [Дата],
	P.Name		AS [Товар],
	S.Cnt		AS [Кол-во],
	M.Surname	AS [Продал]
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
WHERE 
	CAST(S.Moment AS DATE) = CAST(CURRENT_TIMESTAMP - DATEADD(YEAR,1,0) AS DATE) 
	 AND S.Cnt =1
ORDER BY 1 ASC 
*/
 
-- В которых продано от 4 до 7 шт
/*
SELECT 
	S.Moment	AS [Дата],
	P.Name		AS [Товар],
	S.Cnt		AS [Кол-во],
	M.Surname	AS [Продал]
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
WHERE 
	CAST(S.Moment AS DATE) = CAST(CURRENT_TIMESTAMP - DATEADD(YEAR,1,0) AS DATE) 
	 AND S.Cnt BETWEEN 4 AND 7
ORDER BY 1 ASC  */

-- В которых продавец Баранова
/*
SELECT 
	S.Moment	AS [Дата],
	P.Name		AS [Товар],
	S.Cnt		AS [Кол-во],
	M.Surname	AS [Продал]
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
WHERE 
	CAST(S.Moment AS DATE) = CAST(CURRENT_TIMESTAMP - DATEADD(YEAR,1,0) AS DATE) 
	 AND M.Surname = N'Баранова'
ORDER BY 1 ASC */

-- Продавец Баранова
/*
SELECT 
	S.Moment	AS [Дата],
	P.Name		AS [Товар],
	S.Cnt		AS [Кол-во],
	M.Surname	AS [Продал]
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
WHERE 
	CAST(S.Moment AS DATE) = CAST(CURRENT_TIMESTAMP - DATEADD(YEAR,1,0) AS DATE) 
	 AND M.Surname = N'Баранова'
ORDER BY 1 ASC */

-- Только те, которые продавали гвозди (все виды гвоздей)
/*
SELECT 
	S.Moment	AS [Дата],
	P.Name		AS [Товар],
	S.Cnt		AS [Кол-во],
	M.Surname	AS [Продал]
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
WHERE 
	CAST(S.Moment AS DATE) = CAST(CURRENT_TIMESTAMP - DATEADD(YEAR,1,0) AS DATE) 
	 AND P.Name LIKE N'%гвозд%'
ORDER BY 1 ASC */

-- В которых продавец - сотрудник Отдела продаж

SELECT 
	S.Moment [Дата],
	P.Name [Продукт],
	S.Cnt [Количество],
	M.Surname [Продавец],
	D.Name [Отдел],
	(P.Price * S.Cnt) [Сумма чека]
FROM
	Sales S
		JOIN Managers M ON S.ID_manager = M.Id
		JOIN Products P ON S.ID_product = P.Id
		JOIN Departments D  ON M.Id_main_dep = D.Id
WHERE
	 CAST(S.Moment AS DATE) = CAST(CURRENT_TIMESTAMP - DATEADD(YEAR,1,0) AS DATE) 
	 AND D.Name = N'Отдел продаж'
ORDER BY 6 DESC