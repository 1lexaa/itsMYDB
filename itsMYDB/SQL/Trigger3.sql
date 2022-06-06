-- Триггер обновления
/*CREATE OR ALTER TRIGGER
	onUpdate ON Sales
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @cnt INT
	DECLARE @pcs INT
	DECLARE @sum FLOAT
	
	SET @cnt = (SELECT COUNT(id) FROM inserted) - (SELECT COUNT(id) FROM deleted)
	SET @pcs = COALESCE((SELECT SUM(Cnt) FROM inserted), 0) - COALESCE((SELECT SUM(Cnt) FROM deleted), 0)	
	SET @sum = ROUND(COALESCE((
	SELECT SUM(S.Cnt * P.Price)
		FROM inserted S JOIN Products P ON S.ID_product = P.Id),0) -
					COALESCE((
	SELECT SUM(S.Cnt * P.Price) 
		FROM deleted S JOIN Products P ON S.ID_product = P.Id),0), 2)
		
	UPDATE
		accu_sales
	SET
		total_cnt += @cnt,
		total_pcs += @pcs,
		total_sum += @sum
	WHERE
		id = 1
END */