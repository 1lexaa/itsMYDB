-- Триггеры, аккумуляторы
-- Таблица - аккумулятор
--DROP TABLE accu_sales
--CREATE TABLE accu_sales (
--	id INT UNIQUE,		-- Айди
--	total_cnt INT,		-- Чеков
--	total_pcs INT,		-- Товаров
--	total_sum FLOAT,	-- Оборот
--  lastsale DATETIME		-- Последняя продажа
--)

-- Начальное заполнение. Задача: написать запрос помещающий в аккумулятор 
-- суммарные значения по таблице Sales

--INSERT INTO accu_sales (id,total_cnt,total_sum,total_pcs,lastsale)
-- SELECT 1,
-- 		SUM(S.Cnt),				-- чеков
-- 		SUM(S.Cnt * P.Price),	-- оборот
-- 		COUNT(S.ID),			-- товаров
-- 		MAX(S.Moment)			-- послед. продажа
-- FROM Sales S JOIN Products P ON P.Id = S.ID_product

-- Задача: Внести изменения - округлить
-- UPDATE accu_sales SET total_sum = ROUND(total_sum, 2) WHERE id = 1

-- SELECT * FROM accu_sales
-- DROP TRIGGER onInsert
/*
CREATE OR ALTER TRIGGER 
	onInsert ON Sales 
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON 
	DECLARE @sum FLOAT
	DECLARE @cnt INT
	
	SET @cnt = (SELECT cnt FROM inserted) 									 
	SET @sum = (SELECT S.Cnt * P.Price FROM inserted S JOIN Products P ON S.ID_product = P.Id)
	SET @sum = ROUND(@sum, 2)
											
	UPDATE
		accu_sales
		SET total_sum += @sum,								-- оборот
			total_cnt += (SELECT COUNT(id) FROM inserted),	-- сумма чеков
			total_pcs += @cnt								-- товаров продано
			lastsale = (SELECT S.Moment FROM inserted)		-- последняя продажа
	WHERE id = 1
END
		*/

-- Для проверки триггера нужно внести в sales доп данные и мониторить значения аккумулята:
-- до старта cnt:100000, total_sum:185047424,27, after: cnt:100010, total_sum: 185057195,52
--INSERT INTO Sales 
--		( Id_manager, Id_product, Moment, Cnt) 
--	VALUES
--	(
--		( SELECT TOP 1 Id FROM Managers ORDER BY NEWID() ),				
--		( SELECT TOP 1 Id FROM Products ORDER BY NEWID() ),				
--		('2022-01-01'													
--			+ DATEADD( day,    ( ABS( CHECKSUM( NEWID() ) ) % 365 ), 0) 
--			+ DATEADD( hour,   ( ABS( CHECKSUM( NEWID() ) ) % 24  ), 0) 
--			+ DATEADD( minute, ( ABS( CHECKSUM( NEWID() ) ) % 60  ), 0) 
--		),
--		5						
--	)
