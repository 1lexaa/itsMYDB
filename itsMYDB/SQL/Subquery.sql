-- Подзапросы. Основы
SELECT Tmp.stamp
FROM 
		(								-- Должен быть взят в скобки
		SELECT							-- Подзапрос - любой SELECT возвращает таблицу
		CURRENT_TIMESTAMP AS [stamp]	-- В подзапросе не должно быть анонимных полей
		) Tmp							-- Временное имя таблицы для внешнего запроса
-------------
/*
SELECT 
	*
FROM
	(SELECT 
		D.*,
		LEN(D.Name) AS [Lenght]
	FROM 
		Departments D 
	WHERE
		LEN(D.Name) < 12
	) Dep12
	JOIN Managers M
		ON Dep12.Id = M.Id_sec_dep */
		
SELECT 
COALESCE(
	MC.Surname + ' ' + SUBSTRING( MC.Name, 1, 1) + '.', '---') AS Manager,
	Dep12.Name AS Department
FROM
	(SELECT 
		D.*,
		LEN(D.Name) AS [Lenght]
	FROM 
		Departments D 
	WHERE
		LEN(D.Name) <
		(SELECT AVG(LEN(DD.Name)) FROM Departments DD)
	) Dep12
	LEFT JOIN
	(	SELECT 
			* 
		FROM 
			Managers M
		WHERE 
			M.Id_chief IS NOT NULL
		) MC
	ON Dep12.Id = MC.Id_sec_dep