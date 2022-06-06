SELECT
	M.Surname
FROM
	Managers M
WHERE M.Id NOT IN (
	SELECT DISTINCT	-- исключает повторы в выборке. Действует на все поля (сразу)	
		S.ID_manager [Manager Id]
	FROM
		Sales S	
		JOIN Managers M ON  S.Id_manager  = M.Id
	WHERE
		CAST(S.Moment AS DATE) = CAST(CURRENT_TIMESTAMP - DATEADD(YEAR,1,0) AS DATE)
		AND (S.ID_product = 'B6D20749-B495-4B1A-BA1C-80B88E78B7CD' 
		OR  S.ID_product  = 'DA1E17BB-A90D-4C79-B801-5462FB070F57')
)
	