--Вариант 2
--исходник
SET STATISTICS TIME,IO ON
USE WideWorldImporters
go
Select ord.CustomerID, det.StockItemID, SUM(det.UnitPrice), SUM(det.Quantity), COUNT(ord.OrderID)
FROM Sales.Orders AS ord
	JOIN Sales.OrderLines AS det ON det.OrderID = ord.OrderID
	JOIN Sales.Invoices AS Inv ON Inv.OrderID = ord.OrderID
	JOIN Sales.CustomerTransactions AS Trans ON Trans.InvoiceID = Inv.InvoiceID
	JOIN Warehouse.StockItemTransactions AS ItemTrans ON ItemTrans.StockItemID = det.StockItemID
WHERE Inv.BillToCustomerID != ord.CustomerID
AND (Select SupplierId
	FROM Warehouse.StockItems AS It
	Where It.StockItemID = det.StockItemID) = 12
AND (SELECT SUM(Total.UnitPrice*Total.Quantity)
	FROM Sales.OrderLines AS Total
	Join Sales.Orders AS ordTotal On ordTotal.OrderID = Total.OrderID
	WHERE ordTotal.CustomerID = Inv.CustomerID) > 250000
AND DATEDIFF(dd, Inv.InvoiceDate, ord.OrderDate) = 0
GROUP BY ord.CustomerID, det.StockItemID
ORDER BY ord.CustomerID, det.StockItemID

	/*
 Время работы SQL Server:
 Время ЦП = 422 мс, затраченное время = 640 мс.
	*/

DECLARE @SupplierId INT = 12;
DECLARE @MinCost	INT = 250000;
;with Totals AS(
			SELECT ordTotal.CustomerID
			FROM Sales.OrderLines AS Total
				JOIN Sales.Orders AS ordTotal ON ordTotal.OrderID = Total.OrderID
			GROUP BY ordTotal.CustomerID 
			HAVING SUM(Total.UnitPrice*Total.Quantity)>@MinCost)
Select	ord.CustomerID, 
		det.StockItemID, 
		SUM(det.UnitPrice)	AS TotalCost, 
		SUM(det.Quantity)	AS TotalAmount, 
		COUNT(ord.OrderID)	AS TotalOrders
FROM	Sales.Orders AS ord
		JOIN Sales.OrderLines AS det	ON det.OrderID = ord.OrderID
		JOIN Sales.Invoices	AS Inv		ON Inv.OrderID = ord.OrderID AND Inv.InvoiceDate = Ord.OrderDate
		JOIN Warehouse.StockItems AS It ON It.StockItemID = det.StockItemID
		JOIN Totals						ON Totals.CustomerID = inv.CustomerID
WHERE	Inv.BillToCustomerID != ord.CustomerID
		AND It.SupplierId = @SupplierId
GROUP BY ord.CustomerID, det.StockItemID
ORDER BY ord.CustomerID, det.StockItemID

	/*
Время работы SQL Server:
Время ЦП = 110 мс, затраченное время = 178 мс.
   /*