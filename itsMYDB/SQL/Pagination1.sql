-- Pagination
-- Задание: вывести 4 товара
-- Вариант 1
/* SELECT TOP 4 * FROM Products

-- Вариант 2
SELECT 
	*
FROM
	Products P
ORDER BY
	P.Name
OFFSET 0 ROWS			-- отступ - сколько строк пропустить
FETCH NEXT 4 ROWS ONLY	-- Выбор - сколько строк оставить
-- Задание: вывести "следующие" 4 товара
SELECT TOP 8 * FROM Products P ORDER BY P.Name  
SELECT 
	*
FROM
	Products P
ORDER BY
	P.Name
OFFSET 8 ROWS			-- отступ - сколько строк пропустить
FETCH NEXT 4 ROWS ONLY */

DECLARE @PAGE INT
DECLARE @PERPAGE INT
SET @PAGE = 6
SET @PERPAGE = 4
SELECT
	P.* 
FROM 
	Products P 
ORDER BY P.Name 
OFFSET (@PAGE - 1) * @PERPAGE ROWS 
FETCH NEXT @PERPAGE ROWS ONLY