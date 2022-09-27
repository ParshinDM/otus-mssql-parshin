/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.
Занятие "02 - Оператор SELECT и простые фильтры, JOIN".

Задания выполняются с использованием базы данных WideWorldImporters.

Бэкап БД WideWorldImporters можно скачать отсюда:
https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak

Описание WideWorldImporters от Microsoft:
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-what-is
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-oltp-database-catalog
*/

-- ---------------------------------------------------------------------------
-- Задание - написать выборки для получения указанных ниже данных.
-- ---------------------------------------------------------------------------

USE WideWorldImporters

/*
1. Все товары, в названии которых есть "urgent" или название начинается с "Animal".
Вывести: ИД товара (StockItemID), наименование товара (StockItemName).
Таблицы: Warehouse.StockItems.
*/

SELECT StockItemID, StockItemName
FROM Warehouse.StockItems
WHERE StockItemName like '%urgent%' or StockItemName like 'Animal%'

/*
2. Поставщиков (Suppliers), у которых не было сделано ни одного заказа (PurchaseOrders).
Сделать через JOIN, с подзапросом задание принято не будет.
Вывести: ИД поставщика (SupplierID), наименование поставщика (SupplierName).
Таблицы: Purchasing.Suppliers, Purchasing.PurchaseOrders.
По каким колонкам делать JOIN подумайте самостоятельно.
*/
SELECT s.SupplierID, s.SupplierName FROM Purchasing.Suppliers AS s 
LEFT JOIN Purchasing.PurchaseOrders AS o ON s.SupplierID = o.SupplierID
WHERE o.SupplierID is null

/*
3. Заказы (Orders) с ценой товара (UnitPrice) более 100$ 
либо количеством единиц (Quantity) товара более 20 штук
и присутствующей датой комплектации всего заказа (PickingCompletedWhen).
Вывести:
* OrderID
* дату заказа (OrderDate) в формате ДД.ММ.ГГГГ
* название месяца, в котором был сделан заказ
* номер квартала, в котором был сделан заказ
* треть года, к которой относится дата заказа (каждая треть по 4 месяца)
* имя заказчика (Customer)
Добавьте вариант этого запроса с постраничной выборкой,
пропустив первую 1000 и отобразив следующие 100 записей.

Сортировка должна быть по номеру квартала, трети года, дате заказа (везде по возрастанию).

Таблицы: Sales.Orders, Sales.OrderLines, Sales.Customers.
*/

SELECT o.OrderID, CONVERT(NVARCHAR, o.OrderDate, 104) AS OrderDate, c.CustomerName, DATENAME(MM, o.OrderDate) AS Mounth, DATEPART(QUARTER, o.OrderDate) AS [Quarter],
CASE WHEN MONTH(o.OrderDate) <5 THEN 1 WHEN MONTH(o.OrderDate) > 8 THEN 3 ELSE 2 END [Треть]
FROM Sales.Orders AS o
JOIN Sales.OrderLines AS ol ON o.OrderID = ol.OrderID 
JOIN Sales.Customers AS c ON o.CustomerID = c.CustomerID
WHERE ol.UnitPrice > 100 or ol.Quantity > 20 and ol.PickingCompletedWhen is not null
ORDER BY [Quarter], [Треть], o.OrderDate

SELECT o.OrderID, CONVERT(NVARCHAR, o.OrderDate, 104) AS OrderDate, c.CustomerName, DATENAME(MM, o.OrderDate) AS Mounth, DATEPART(QUARTER, o.OrderDate) AS [Quarter],
CASE WHEN MONTH(o.OrderDate) <5 THEN 1 WHEN MONTH(o.OrderDate) > 8 THEN 3 ELSE 2 END [Треть]
FROM Sales.Orders AS o
JOIN Sales.OrderLines AS ol ON o.OrderID = ol.OrderID 
JOIN Sales.Customers AS c ON o.CustomerID = c.CustomerID
WHERE ol.UnitPrice > 100 or ol.Quantity > 20 and ol.PickingCompletedWhen is not null
ORDER BY [Quarter], [Треть], o.OrderDate OFFSET 1000 rows fetch first 100 rows only

/*
4. Заказы поставщикам (Purchasing.Suppliers),
которые должны быть исполнены (ExpectedDeliveryDate) в январе 2013 года
с доставкой "Air Freight" или "Refrigerated Air Freight" (DeliveryMethodName)
и которые исполнены (IsOrderFinalized).
Вывести:
* способ доставки (DeliveryMethodName)
* дата доставки (ExpectedDeliveryDate)
* имя поставщика
* имя контактного лица принимавшего заказ (ContactPerson)

Таблицы: Purchasing.Suppliers, Purchasing.PurchaseOrders, Application.DeliveryMethods, Application.People.
*/
SELECT d.DeliveryMethodName, po.ExpectedDeliveryDate, s.SupplierName ,p.FullName
FROM Purchasing.Suppliers as s
JOIN Purchasing.PurchaseOrders as po on po.SupplierID = s.SupplierID
JOIN Application.DeliveryMethods as d on d.DeliveryMethodID = po.DeliveryMethodID
JOIN Application.People as p on p.PersonID = po.ContactPersonID
where month(po.ExpectedDeliveryDate) = 1 and year(po.ExpectedDeliveryDate) = 2013
	and d.DeliveryMethodName = 'Air Freight' or d.DeliveryMethodName = 'Refrigerated Air Freight'
	and po.IsOrderFinalized = 1

/*
5. Десять последних продаж (по дате продажи) с именем клиента и именем сотрудника,
который оформил заказ (SalespersonPerson).
Сделать без подзапросов.
*/
SELECT TOP 10 o.OrderDate, c.CustomerName, p.FullName
FROM [Sales].[Orders] AS o
JOIN Sales.Customers AS c ON o.CustomerID = c.CustomerID
JOIN [Application].[People] AS p ON (p.PersonID = o.SalespersonPersonID and p.IsSalesperson = 1)
order by o.OrderDate desc

/*
6. Все ид и имена клиентов и их контактные телефоны,
которые покупали товар "Chocolate frogs 250g".
Имя товара смотреть в таблице Warehouse.StockItems.
*/
SELECT o.OrderID, c.CustomerName, c.PhoneNumber FROM Sales.Orders AS o
JOIN Sales.Customers AS c ON o.CustomerID = c.CustomerID
JOIN Sales.OrderLines AS ol ON o.OrderID = ol.OrderID 
JOIN Warehouse.StockItems AS si ON si.StockItemID = ol.StockItemID
WHERE si.StockItemName = 'Chocolate frogs 250g'

