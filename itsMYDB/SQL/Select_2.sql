-- SELECT продолжение

SELECT			  
	D.Name  [Название Отдела],		 
	D.Id    [Код Отдела]		 
FROM			  
	Departments D
ORDER BY		     -- Сортировать выборку (результат)
	-- D.Name ASC	 -- по имени, ASC (ascending) - по возрастанию / DESC - по убыванию
	-- 1             -- по первому полю выборки (D.Name) по возрастанию (по умолчанию)
	[Название Отдела] DESC  -- по псевдониму

-- Условия в выборке
SELECT			  
	D.Name  [Название Отдела],		 
	D.Id    [Код Отдела]		 
FROM			  
	Departments D
WHERE                     -- блок (секция) условий - пройдут строки, удовляетв. условиям
	D.Name < N'О'         -- строки сравниваются обычным образом - по алфавиту
	OR D.Name > N'С'      -- составные условия - OR AND NOT

SELECT			  
	D.Name  [Название Отдела],		 
	D.Id    [Код Отдела]		 
FROM			  
	Departments D
WHERE  
	D.Name BETWEEN N'О' AND N'С'  -- условие-диапазон
ORDER BY                          -- сортировка - всегда на последнем месте  
	D.Name DESC

SELECT			  
	D.Name  [Название Отдела],		 
	D.Id    [Код Отдела]		 
FROM			  
	Departments D
WHERE                   -- сравнение строк регистронезависимое
	D.Name LIKE N'%О%'  -- сравнение-шаблон: %-любая группа (здесь - содержит букву "о")
ORDER BY                          
	D.Name DESC

