use WideWorldImporters;
GO

ALTER DATABASE [WideWorldImporters] ADD FILEGROUP [YearData]
GO


ALTER DATABASE [WideWorldImporters] ADD FILE( 
NAME = N'Years', FILENAME = N'C:\Users\dmitrymp\Desktop\otus-mssql-parshin\hw19\YearData.ndf', 
SIZE = 109715KB , FILEGROWTH = 65536KB ) TO FILEGROUP [YearData]
GO


CREATE PARTITION FUNCTION [fnYearPartition](DATE) AS RANGE RIGHT FOR VALUES
('20120101','20130101','20140101','20150101','20160101', '20170101','20180101','20190101','20200101','20210101');																																																									
GO

CREATE PARTITION SCHEME [schmYearPartition] AS PARTITION [fnYearPartition] 
ALL TO ([YearData])
GO

SELECT * INTO Sales.OrdersPartitioned
FROM Sales.Orders;

--создадим партиционированную таблицу
CREATE TABLE [Sales].[OrdersYears](
	[OrderID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[SalespersonPersonID] [int] NOT NULL,
	[PickedByPersonID] [int] NULL,
	[ContactPersonID] [int] NOT NULL,
	[BackorderOrderID] [int] NULL,
	[OrderDate] [date] NOT NULL,
	[ExpectedDeliveryDate] [date] NOT NULL,
	[CustomerPurchaseOrderNumber] [nvarchar](20) NULL,
	[IsUndersupplyBackordered] [bit] NOT NULL,
	[Comments] [nvarchar](max) NULL,
	[DeliveryInstructions] [nvarchar](max) NULL,
	[InternalComments] [nvarchar](max) NULL,
	[PickingCompletedWhen] [datetime2](7) NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL,
) ON [schmYearDataPartition]([OrderDate])
GO
--создаем ключ
ALTER TABLE [Sales].[OrdersYears] ADD CONSTRAINT PK_Sales_OrdersYears 
PRIMARY KEY CLUSTERED ([OrderDate],[OrderID])
ON [schmYearDataPartition]([OrderDate]);
GO

EXEC sp_configure 'show advanced options', 1;  
GO  
-- To update the currently configured value for advanced options.  
RECONFIGURE;  
GO  
-- To enable the feature.  
EXEC sp_configure 'xp_cmdshell', 1;  
GO  
-- To update the currently configured value for this feature.  
RECONFIGURE;  
GO  

SELECT @@SERVERNAME

-- copy data to from non-partitioned table to file 
EXEC master..xp_cmdshell 'bcp "[WideWorldImporters].[Sales].[Orders]" out "C:\Users\dmitrymp\Desktop\otus-mssql-parshin\hw19 - Partitioning_tables\Orders.txt" -T -w -t "@eu&$" -S localhost'

-- insert data to partitioned table
DECLARE 
	@Path VARCHAR(256),
	@FileName VARCHAR(256),
	@Query	NVARCHAR(MAX),
	@Dbname VARCHAR(255),
	@BatchSize INT
	
	SET @Path = 'C:\Users\dmitrymp\Desktop\otus-mssql-parshin\hw19 - Partitioning_tables\';
	SET @FileName = 'Orders.txt';
	SELECT @Dbname = DB_NAME();
	SET @Batchsize = 1000;

BEGIN TRY

		IF @FileName IS NOT NULL
		BEGIN
			SET @query = 'BULK INSERT ['+@dbname+'].[Sales].[OrdersYears]
				   FROM "'+@path+@FileName+'"
				   WITH 
					 (
						BATCHSIZE = '+CAST(@batchsize AS VARCHAR(255))+', 
						DATAFILETYPE = ''widechar'',
						FIELDTERMINATOR = ''@eu&$'',
						ROWTERMINATOR =''\n'',
						KEEPNULLS,
						TABLOCK        
					  );'

			EXEC sp_executesql @query 
		END;
	END TRY

	BEGIN CATCH
		SELECT   
			ERROR_NUMBER() AS [ErrorNumber]  
			,ERROR_MESSAGE() AS [ErrorMessage];
	END CATCH

 --смотрим какие таблицы партиционированы
select distinct t.name
from sys.partitions p
inner join sys.tables t
	on p.object_id = t.object_id
where p.partition_number <> 1

--смотрим как конкретно по диапазонам распределились данные

SELECT  $PARTITION.fnYearPartition(OrderDate) AS Partition,
		COUNT(*)		AS [COUNT],
		MIN(OrderDate)	AS [MinDate],
		MAX(OrderDate)	AS [MaxDate]
FROM Sales.OrdersYears
GROUP BY $PARTITION.fnYearPartition(OrderDate) 
ORDER BY Partition ; 