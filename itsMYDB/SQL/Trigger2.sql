-- Триггеры, продолжение.
-- Событие удаления
--CREATE OR ALTER TRIGGER
--	onDelete ON Sales
--AFTER DELETE
--AS
--BEGIN
--	SET NOCOUNT ON
--	UPDATE accu_sales
--	SET total_cnt -= (SELECT COUNT(id) FROM deleted),
--		total_pcs -= (SELECT SUM(cnt) FROM deleted), 
--		total_sum -= (SELECT ROUND(SUM(S.Cnt * P.Price), 2)
--	FROM
--		deleted S JOIN Products P
--					ON S.ID_product = P.Id)
--	WHERE id = 1
--END

-- SELECT TOP 1 * FROM Sales WHERE Cnt = 10 -- '7827A495-6F40-47C6-8866-0026242CA4C6'

-- SELECT * FROM accu_sales -- 1003 185057248,02 2021-12-31 23:46:00.000

-- DELETE FROM Sales WHERE id = '7827A495-6F40-47C6-8866-0026242CA4C6'

-- повторяем команду удаления - получается 0 строк записано
-- снова запрашиваем аккумулятор - получаем налл 548233	NULL	NULL	2021-12-31 23:46:00.000
-- причина - в триггере, в таблице DELETED было пусто

-- CREATE OR ALTER TRIGGER
-- 	 onDelete ON Sales
-- AFTER DELETE
-- AS
-- BEGIN
-- 	 SET NOCOUNT ON
-- 	 UPDATE accu_sales
-- 	 SET total_cnt -= (SELECT COUNT(id) FROM deleted),
-- 	 	total_pcs -= COALESCE((SELECT SUM(cnt) FROM deleted), 0),
-- 	 	total_sum -= COALESCE((SELECT ROUND(SUM(S.Cnt * P.Price), 2)
-- 	 FROM
-- 	 	deleted S JOIN Products P
-- 	 				ON S.ID_product = P.Id), 0)
-- 	 WHERE 
--		id = 1
-- END

-- Восстанавливаем значения в аккумуляторе
--UPDATE
--	accu_sales
--SET
--	total_cnt = (SELECT COUNT(id) FROM Sales),
--	total_pcs = (SELECT SUM(cnt) FROM Sales),
--	total_sum = ROUND(
--	(SELECT SUM(S.Cnt * P.Price)
--	FROM Sales S JOIN Products P ON S.ID_product = P.Id), 2 )
--WHERE
--	id = 1
