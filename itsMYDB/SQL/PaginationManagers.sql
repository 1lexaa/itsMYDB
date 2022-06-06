-- Создать процедуру, возвращающую заданную страницу сотрудников
-- EXEC ManagersPage @page = 3, perpage = 5

--CREATE OR ALTER PROC
--	ManagersPage                                -- name of proc
--	@page INT,
--	@perpage INT
--AS
--	    SELECT
--	        M.*                                 -- all information from table M
--	    FROM 
--	        Managers M                          -- Managers table
--	    ORDER BY 
--          M.Name 
--	    OFFSET (@page - 1) * @perpage ROWS      -- Indent
--	    FETCH NEXT @perpage ROWS ONLY           -- how many rows select

-- EXEC ManagersPage @page = 3, @perpage = 5


-- Сделать процедуру, возвращаю количество страниц сотрудников при заданной разбивке
 -- EXEC ManagersPageCount @perpage = 7

CREATE OR ALTER PROC
 	ManagersPageCount                               -- name of proc
 	@perpage INT
 AS
 BEGIN
    DECLARE @cnt FLOAT                              -- creating float var count of pages of managers
    SET @cnt = (SELECT COUNT(Id) FROM Managers)     -- setting var
	
	SELECT CEILING(@cnt / @perpage)                 -- rounding up to the greater
END