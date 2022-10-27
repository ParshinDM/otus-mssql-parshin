/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "05 - Операторы CROSS APPLY, PIVOT, UNPIVOT".

Задания выполняются с использованием базы данных WideWorldImporters.

Бэкап БД можно скачать отсюда:
https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0
Нужен WideWorldImporters-Full.bak

Описание WideWorldImporters от Microsoft:
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-what-is
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-oltp-database-catalog
*/

-- ---------------------------------------------------------------------------
-- Задание - написать выборки для получения указанных ниже данных.
-- ---------------------------------------------------------------------------

USE WideWorldImporters

/*
1. Требуется написать запрос, который в результате своего выполнения 
формирует сводку по количеству покупок в разрезе клиентов и месяцев.
В строках должны быть месяцы (дата начала месяца), в столбцах - клиенты.

Клиентов взять с ID 2-6, это все подразделение Tailspin Toys.
Имя клиента нужно поменять так чтобы осталось только уточнение.
Например, исходное значение "Tailspin Toys (Gasport, NY)" - вы выводите только "Gasport, NY".
Дата должна иметь формат dd.mm.yyyy, например, 25.12.2019.

Пример, как должны выглядеть результаты:
-------------+--------------------+--------------------+-------------+--------------+------------
InvoiceMonth | Peeples Valley, AZ | Medicine Lodge, KS | Gasport, NY | Sylvanite, MT | Jessie, ND
-------------+--------------------+--------------------+-------------+--------------+------------
01.01.2013   |      3             |        1           |      4      |      2        |     2
01.02.2013   |      7             |        3           |      4      |      2        |     1
-------------+--------------------+--------------------+-------------+--------------+------------
*/

SELECT * FROM (
	SELECT distinct convert(varchar,DATEADD(dd,-(day(InvoiceDate)-1),InvoiceDate), 104) as InvoiceMonth, SUM(Quantity) as tot, 
	LEFT(Right(CustomerName,len(CustomerName)-15),len(Right(CustomerName,len(CustomerName)-15))-1) as nm
	FROM [Sales].[Invoices] as i
	JOIN [Sales].[InvoiceLines] as l on l.InvoiceID=i.InvoiceID
	JOIN [Sales].[Customers] as c on c.CustomerID = i.CustomerID
	where i.CustomerID in(2,3,4,5,6)
	group by InvoiceDate, CustomerName) as dt
PIVOT (sum(tot) for nm in(
	[Sylvanite, MT],
	[Peeples Valley, AZ],
	[Medicine Lodge, KS],
	[Gasport, NY],
	[Jessie, ND]
)) as pvt
ORDER BY InvoiceMonth


/*
2. Для всех клиентов с именем, в котором есть "Tailspin Toys"
вывести все адреса, которые есть в таблице, в одной колонке.

Пример результата:
----------------------------+--------------------
CustomerName                | AddressLine
----------------------------+--------------------
Tailspin Toys (Head Office) | Shop 38
Tailspin Toys (Head Office) | 1877 Mittal Road
Tailspin Toys (Head Office) | PO Box 8975
Tailspin Toys (Head Office) | Ribeiroville
----------------------------+--------------------
*/
SELECT CustomerName, AddressLine FROM(
SELECT CustomerName as CustomerName, [DeliveryAddressLine1], [DeliveryAddressLine2], [PostalAddressLine1], [PostalAddressLine2]
FROM [Sales].[Customers]
where CustomerName like '%Tailspin Toys%') as t
UNPIVOT (AddressLine for adr IN([DeliveryAddressLine1],
								[DeliveryAddressLine2],
								[PostalAddressLine1],
								[PostalAddressLine2])) as unpvt



/*
3. В таблице стран (Application.Countries) есть поля с цифровым кодом страны и с буквенным.
Сделайте выборку ИД страны, названия и ее кода так, 
чтобы в поле с кодом был либо цифровой либо буквенный код.

Пример результата:
--------------------------------
CountryId | CountryName | Code
----------+-------------+-------
1         | Afghanistan | AFG
1         | Afghanistan | 4
3         | Albania     | ALB
3         | Albania     | 8
----------+-------------+-------
*/
SELECT CountryId, CountryName, Code FROM (
SELECT CountryId, CountryName, cast([IsoAlpha3Code] as varchar) as al, cast([IsoNumericCode] as varchar) as nu
FROM Application.Countries) as t
UNPIVOT (Code for c in([al],[nu])) as unp

/*
4. Выберите по каждому клиенту два самых дорогих товара, которые он покупал.
В результатах должно быть ид клиета, его название, ид товара, цена, дата покупки.
*/

SELECT  c.CustomerID, c.CustomerName, t.StockItemID, t.UnitPrice,  t.InvoiceDate
FROM   [Sales].[Customers] as c 
CROSS APPLY (SELECT TOP 2 *
				FROM	(SELECT I.CustomerID, C.CustomerName, I.InvoiceDate, IL.UnitPrice, il.StockItemID
						FROM Sales.Invoices as i
						JOIN Sales.InvoiceLines as il on I.InvoiceID = IL.InvoiceID
						JOIN Sales.Customers as c on I.CustomerID=C.CustomerID
						) as l
				WHERE C.CustomerID = l.CustomerID
				ORDER BY UnitPrice DESC
			)AS t
order by c.CustomerID
