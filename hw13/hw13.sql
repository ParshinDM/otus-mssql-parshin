/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "12 - Хранимые процедуры, функции, триггеры, курсоры".

Задания выполняются с использованием базы данных WideWorldImporters.

Бэкап БД можно скачать отсюда:
https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0
Нужен WideWorldImporters-Full.bak

Описание WideWorldImporters от Microsoft:
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-what-is
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-oltp-database-catalog
*/

USE WideWorldImporters

/*
Во всех заданиях написать хранимую процедуру / функцию и продемонстрировать ее использование.
*/

/*
1) Написать функцию возвращающую Клиента с наибольшей суммой покупки.
*/

CREATE FUNCTION AmountMax() 
RETURNS TABLE  
AS 
RETURN( 
 SELECT TOP 1 
		c.CustomerID,
		c.CustomerName,  
		sum(il.ExtendedPrice) AS InvSum
    FROM Sales.Customers AS c
		JOIN Sales.Invoices AS i		ON c.CustomerID = i.CustomerID
		JOIN Sales.InvoiceLines AS il	ON i.InvoiceID = il.InvoiceID
	GROUP BY  c.CustomerID, i.InvoiceID, c.CustomerName
    ORDER BY sum(il.ExtendedPrice) DESC);   
GO    

Select * from AmountMax()

/*
2) Написать хранимую процедуру с входящим параметром СustomerID, выводящую сумму покупки по этому клиенту.
Использовать таблицы :
Sales.Customers
Sales.Invoices
Sales.InvoiceLines
*/


CREATE PROCEDURE dbo.CustomersPurchase (
	@CustomerID INT)
AS
BEGIN
    SELECT TOP 1 
		c.CustomerID, 
		c.CustomerName, 
		SUM(il.ExtendedPrice) AS InvSum 
	FROM Sales.InvoiceLines AS il
		JOIN Sales.Invoices AS i	ON i.InvoiceID = il.InvoiceID
		JOIN Sales.Customers AS c	ON c.CustomerID = i.CustomerID
	WHERE i.CustomerID = @CustomerID
	GROUP BY c.CustomerID,i.InvoiceID,c.CustomerName
	ORDER BY sum(il.ExtendedPrice) DESC 
END;

EXECUTE CustomersPurchase @CustomerID=834

/*
3) Создать одинаковую функцию и хранимую процедуру, посмотреть в чем разница в производительности и почему.
*/

CREATE FUNCTION AmountMax() 
RETURNS TABLE  
AS 
RETURN( 
 SELECT TOP 1 
		c.CustomerID,
		c.CustomerName,  
		sum(il.ExtendedPrice) AS InvSum
    FROM Sales.Customers AS c
		JOIN Sales.Invoices AS i		ON c.CustomerID = i.CustomerID
		JOIN Sales.InvoiceLines AS il	ON i.InvoiceID = il.InvoiceID
	GROUP BY  c.CustomerID, i.InvoiceID, c.CustomerName
    ORDER BY sum(il.ExtendedPrice) DESC);   
GO

CREATE PROCEDURE dbo.AmountMaxProc AS
BEGIN
    SELECT TOP 1
		c.CustomerID, 
		c.CustomerName, 
		SUM(il.ExtendedPrice) AS InvSum 
	from Sales.InvoiceLines il
		JOIN Sales.Invoices i ON i.InvoiceID = il.InvoiceID
		JOIN Sales.Customers c ON c.CustomerID = i.CustomerID
	GROUP BY c.CustomerID,i.InvoiceID,c.CustomerName
	ORDER BY sum(il.ExtendedPrice) DESC 
END;


SET STATISTICS TIME,IO ON

Select * from AmountMax()
время ЦП = 31 мс, истекшее время = 38 мс.
EXECUTE dbo.AmountMaxProc
время ЦП = 22 мс, истекшее время = 22 мс.
/*
4) Создайте табличную функцию покажите как ее можно вызвать для каждой строки result set'а без использования цикла. 
*/

CREATE FUNCTION [dbo].[LastPurchaseDate](
	@CustomerId INT)
RETURNS DATE
BEGIN

DECLARE @Date DATE;

SELECT TOP 1
	@Date = i.[InvoiceDate]
FROM [Sales].[Customers] AS c
	JOIN [Sales].[Invoices] AS i ON i.[CustomerID] = c.[CustomerID]
WHERE c.CustomerID = @CustomerId
ORDER BY i.[InvoiceDate] DESC

RETURN @Date
END
GO

SELECT
	c.[CustomerID],
	c.[CustomerName],
	[dbo].[LastPurchaseDate](c.[CustomerID]) AS [LastPurchaseDate]
FROM [Sales].[Customers] AS c

/*
5) Опционально. Во всех процедурах укажите какой уровень изоляции транзакций вы бы использовали и почему. 
*/
