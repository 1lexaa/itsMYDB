CREATE OR ALTER TRIGGER
	uniAccumulator ON Sales
AFTER INSERT, DELETE, UPDATE	-- universal trigger
AS
BEGIN
	SET NOCOUNT ON				-- NO "0 row(s) affected"
	
	DECLARE @cnt INT			-- checks cnt
	DECLARE @pcs INT			-- sold items
	DECLARE @sum FLOAT			-- sum
	DECLARE @lastsale DATETIME	-- last sale date time

	SET @cnt = (SELECT COUNT(id) FROM inserted) - (SELECT COUNT(id) FROM deleted)
	SET @pcs = COALESCE((SELECT SUM(Cnt) FROM inserted), 0) - COALESCE((SELECT SUM(Cnt) FROM deleted), 0)	
	SET @sum = ROUND(COALESCE((
	SELECT SUM(S.Cnt * P.Price)
		FROM inserted S JOIN Products P ON S.ID_product = P.Id),0) -
					COALESCE((
	SELECT SUM(S.Cnt * P.Price) 
		FROM deleted S JOIN Products P ON S.ID_product = P.Id),0), 2)
		
	SET @lastsale = (SELECT MAX(S.Moment) FROM inserted S)
	
	UPDATE accu_sales			-- update accu_sales table
	SET
		total_sum += @sum,		-- update
		total_cnt += @cnt,		-- update
		total_pcs += @pcs,		-- update
		lastsale = @lastsale	-- lastsale date time
	WHERE 
		id = 1
END

DROP TRIGGER uniTrigger