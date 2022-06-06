-- Создать процедуру, возвращающую заданную страницу товаров
-- EXEC ProductPage @page = 3, perpage = 5
--CREATE OR ALTER PROC
--	ProdPage
--	@page INT,
--	@perpage INT
--AS
--	SELECT
--	P.* 
--	FROM 
--	Products P 
--	ORDER BY P.Name 
--	OFFSET (@page - 1) * @perpage ROWS 
--	FETCH NEXT @perpage ROWS ONLY

-- EXEC ProdPage @page = 3, @perpage = 5

-- Сделать процедуру, возвращаю количество страниц товаров при заданной разбивке EXEC ProdPageCount @perpage = 7

 -- EXEC ProdPageCount @perpage = 7


CREATE OR ALTER PROC
 	ProdPageCount
 	@perpage INT
 AS
 BEGIN
    DECLARE @cnt FLOAT
    SET @cnt = (SELECT COUNT(Id) FROM Products) 
	SELECT
	    CEILING(@cnt / @perpage)
END



