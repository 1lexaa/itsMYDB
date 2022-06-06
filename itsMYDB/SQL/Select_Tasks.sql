-- SELECT практика
/*
-- Из таблицы Products вывести товары (название и цену) по алфавиту
SELECT
	P.Name   [Название],
	P.Price  [Цена]
FROM
	Products P
ORDER BY
	P.Name ASC
	
-- Вывести 5 самых дорогих товара
SELECT TOP 5
	P.Name  [Название],
	P.Price [Цена]
FROM
	Products P
ORDER BY
	P.Price DESC
*/
-- Вывести информацию (название, цена, код) о всех шурупах
SELECT	
	P.Name  [Название],
	P.Price [Цена],
	P.Id    [Код]
FROM
	Products P
WHERE
	P.Name LIKE N'шуруп %'
ORDER BY
	P.Price DESC

/*
Из таблицы Products вывести
 Товары из ценовой категории "до 100 грн"
 Товары из ценовой категории "от 100 до 500 грн"
 Результат поискового запроса "вер"
 Первую страницу - 10 товаров по алфавиту
 Самый дешевый товар
 Три самых дешевых товара
 * Товар с самым длинным названием
*/

---------------------- HOMEWORK ----------------------
-- Товары из ценовой категории "до 100 грн"
SELECT 
	P.Name [Название],
	P.Price [Цена],
	P.Id [Код]
FROM 
	Products P
WHERE 
	P.Price < 100

-- Товары из ценовой категории "от 100 до 500 грн"
SELECT 
	P.Name [Название],
	P.Price [Цена],
	P.Id [Код]
FROM 
	Products P
WHERE 
	P.Price > 100 AND P.Price < 500

-- Результат поискового запроса "вер"
SELECT 
	P.Name [Название],
	P.Price [Цена],
	P.Id [Код]
FROM 
	Products P
WHERE 
	P.Name LIKE N'%вер%'

-- Первую страницу - 10 товаров по алфавиту
SELECT TOP 10 
	P.Name [Название],
	P.Price [Цена],
	P.Id [Код]
FROM 
	Products P
ORDER BY 
	P.Name ASC
	
-- Самый дешевый товар	
SELECT TOP 1 
	P.Name [Название],
	P.Price [Цена],
	P.Id [Код]
FROM 
	Products P
ORDER BY
	P.Price ASC
	
-- Три самых дешевых товара
SELECT TOP 3 
	P.Name [Название],
	P.Price [Цена],
	P.Id [Код]
FROM 
	Products P
ORDER BY
	P.Price ASC

-- Товар с самым длинным названием
SELECT TOP 1 
	P.Name [Название],
	P.Price [Цена],
	P.Id [Код]
FROM 
	Products P
ORDER BY
	LEN(P.Name) DESC
