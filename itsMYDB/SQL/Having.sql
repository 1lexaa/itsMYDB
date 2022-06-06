-- HAVING - условия на агрегационные поля
-- примерно то же самое, что WHERE, только применяется к результатам агр. функций

/*
SELECT
	name, SUM(cnt)
FROM T					
WHERE					условия на значения ячеек T
GROUP BY name			группировка + применение агрегаторов (SUM)
HAVING					условия на SUM(cnt)
	SUM(cnt) > 100

	WHERE( (SELECT SUM() ... ) > 100 )
*/

-- Выбарть товары, у которых продажи за сегодня больше 70 единиц
/*
SELECT
	P.Name		AS [Товар],
	SUM(S.Cnt)	AS [Кол-во]
FROM
	Sales S
	JOIN Products P ON S.Id_product = P.Id
WHERE
	CAST( S.Moment AS DATE) = CAST(( CURRENT_TIMESTAMP + (DATEADD(YEAR, -1, 0) )) AS DATE)
GROUP BY
	P.Name
HAVING
	SUM(S.Cnt) > 70
ORDER BY 2 DESC 

-- Средний чек - среднее значение по суммам (грн) всех чеков
-- Вывести данные средних чеков по сотрудникам !за месяц!, отобрать тех, у кого средний чек
-- меньше 1500 грн
SELECT
	MAX(M.Surname + ' ' + SUBSTRING( M.Name, 1, 1) + '.') AS [Сотрудник],
	SUM(S.Cnt)	AS [Кол-во],
	AVG(S.Cnt * P.Price) AS [Средний чек]
FROM
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id
WHERE
	MONTH(S.Moment) = 5
GROUP BY
	S.Id_manager
HAVING (AVG(S.Cnt * P.Price)) < 1500
ORDER BY 3 

-- Вывести: менеджер - кол-во подчинненых. Отобрать тех, у кого больше 1 подчиненного
SELECT
	*
FROM	
	Managers M					-- Сотрудник (шеф)
	JOIN Managers MC 			-- Та же таблица в роли подчиненных
		ON M.Id = MC.Id_chief	-- условие: у подчиненного Id_chief - это у шефа Id
ORDER BY
	M.Id 

SELECT
	MAX(M.Surname + ' ' + M.[Name] ) AS [Шеф],
	COUNT (MC.Id) AS [Кол-во подчиненых]
FROM
	Managers M
	JOIN Managers MC 			
		ON M.Id = MC.Id_chief	
GROUP BY
	M.Id
HAVING
	COUNT( MC.Id ) > 1
ORDER BY
	2 DESC

SELECT
	Buhs.Surname,
	COALESCE(CAST(Chiefs.SubCnt AS CHAR), '-') [Более одного подчиненного]
FROM
	( 
	SELECT *
	FROM
		Managers M
	WHERE
		M.Id_main_dep = (SELECT Id FROM Departments WHERE Name = N'Бухгалтерия')
	) Buhs
	LEFT JOIN
	(	 SELECT
			M.Id,
			COUNT (MC.Id) [SubCnt]
		 FROM
			Managers M
			JOIN Managers MC
				ON M.Id = MC.Id_chief
		 GROUP BY
			M.Id
		 HAVING
			COUNT( MC.Id ) > 1
		 ) Chiefs
			ON Buhs.Id = Chiefs.Id
ORDER BY 2 DESC  

-- Топ 3 худших менеджера за сегодня
SELECT TOP 3
	MAX(M.Surname)			[Претенденты на увольнение],
	SUM(S.Cnt * P.Price)	[Их продажи]
FROM 
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Products P ON S.Id_product = P.Id 
WHERE 
	CAST( S.Moment AS DATE) = CAST(( CURRENT_TIMESTAMP + (DATEADD(YEAR, -1, 0) )) AS DATE)
GROUP BY
	P.Id
ORDER BY
	2 ASC 

-- Топ 3 худших товара по количеству продаж за месяц
SELECT TOP 3
	MAX(P.Name)				[Не продаваемые товары],
	SUM(S.Cnt * P.Price)	[Их продажи]
FROM 
	Sales S
	JOIN Products P ON S.Id_product = P.Id 
WHERE 
	MONTH(S.Moment) = 5
GROUP BY
	P.Id
ORDER BY
	2 ASC */
	
---- HOMEWORK ----

-- Топ 3 худших отдела за сегодня
SELECT TOP 3
	MAX(D.[Name])				[Худший отдел],
	SUM(S.Cnt * P.Price)		[Их продажи]
FROM 
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Departments D ON D.Id = M.Id_main_dep
	JOIN Products P ON S.Id_product = P.Id 
WHERE 
	CAST( S.Moment AS DATE) 
	= CAST(( CURRENT_TIMESTAMP + (DATEADD(YEAR, -1, 0) )) AS DATE) -- "сегодня" год назад
GROUP BY P.Id													   -- группировка по айди продукта
ORDER BY 2 ASC													   -- сортировка по продажам
-- Топ 3 худших отдела за месяц
SELECT TOP 3
	MAX(D.[Name])				[Худший отдел],
	SUM(S.Cnt * P.Price)		[Их продажи]
FROM 
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Departments D ON D.Id = M.Id_main_dep
	JOIN Products P ON S.Id_product = P.Id 
WHERE 
	MONTH(S.Moment) = 5								-- обрабатываем информацию за май 21-22г.
GROUP BY	
	P.Id											-- группируем по айди продукта
ORDER BY
	2 ASC											-- сортируем по продажам
	
-- Вывести отделы, суммы продаж за месяц по которым превышают 100000 грн (цифру подобрать)
SELECT
	MAX(D.[Name])				[Oтдел],			-- колонка с отделами
	SUM(S.Cnt * P.Price)		[Продажи > 85000]	-- колонка с продажами
FROM 
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Departments D ON D.Id = M.Id_main_dep
	JOIN Products P ON S.Id_product = P.Id 
WHERE MONTH(S.Moment) = 5					-- смотрим за май
GROUP BY P.Id							    -- группируем по айди продукта
HAVING
	SUM(S.Cnt * P.Price) > 85000			-- смотрим на то, содержит ли отдел продаж на суммарную стоимость свыше 85000
ORDER BY 2 ASC								-- сортируем по продажам

-- вывести отделы сумма продаж (грн) которых меньше чем в среднем за сегодня (only try)
SELECT
	MAX(D.[Name])				[Oтдел],			-- колонка с отделами
	SUM(S.Cnt * P.Price)		[Продажи > 85000]	-- колонка с продажами
FROM 
	Sales S
	JOIN Managers M ON S.Id_manager = M.Id
	JOIN Departments D ON D.Id = M.Id_main_dep
	JOIN Products P ON S.Id_product = P.Id 
	JOIN (
		SELECT 
			D.Id AS DepartmentId,
			SUM(S.Cnt * P.Price) AS [Продажи за сегодня]
		FROM 
			Sales S
			JOIN Managers M ON S.Id_manager = M.Id
			JOIN Departments D ON D.Id = M.Id_main_dep
			JOIN Products P ON S.Id_product = P.Id 
		WHERE 
			CAST( S.Moment AS DATE) 
			= CAST(( CURRENT_TIMESTAMP + (DATEADD(YEAR, -1, 0) )) AS DATE) 
		GROUP BY P.Id													   
		ORDER BY 2 ASC													   
		) TodaySellings ON TodaySellings.DepartmentId = D.Id
WHERE CAST( S.Moment AS DATE) 
			= CAST(( CURRENT_TIMESTAMP + (DATEADD(YEAR, -1, 0) )) AS DATE) 
GROUP BY P.Id							    -- группируем по айди продукта
HAVING
	TodaySellings.[Продажи за сегодня] > AVG(SUM(S.Cnt * P.Price))
ORDER BY 2									-- сортируем по продажам