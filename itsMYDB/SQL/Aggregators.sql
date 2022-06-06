-- Aggregators
SELECT 
	SUM( S.Cnt )			[Всего продано шт.],
	MIN( S.Cnt * P.Price)	[Минимальный чек, грн.],
	MAX( S.Moment )			[Последняя продажа],
	COUNT( S.Id )			[Всего чеков],
	AVG( P.Price )			[Средняя цена единицы, грн.]
FROM
	Sales S
	JOIN Products P ON S.Id_product = P.Id