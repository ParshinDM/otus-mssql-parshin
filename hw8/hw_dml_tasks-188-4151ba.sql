/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "10 - Операторы изменения данных".

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
1. Довставлять в базу пять записей используя insert в таблицу Customers или Suppliers 
*/

    INSERT INTO [Purchasing].[Suppliers]
    (	[SupplierID]
	  ,[SupplierName]
      ,[SupplierCategoryID]
      ,[PrimaryContactPersonID]
      ,[AlternateContactPersonID]
      ,[DeliveryMethodID]
      ,[DeliveryCityID]
      ,[PostalCityID]
      ,[SupplierReference]
      ,[BankAccountName]
      ,[BankAccountBranch]
      ,[BankAccountCode]
      ,[BankAccountNumber]
      ,[BankInternationalCode]
      ,[PaymentDays]
      ,[InternalComments]
      ,[PhoneNumber]
      ,[FaxNumber]
      ,[WebsiteURL]
      ,[DeliveryAddressLine1]
      ,[DeliveryAddressLine2]
      ,[DeliveryPostalCode]
      ,[DeliveryLocation]
      ,[PostalAddressLine1]
      ,[PostalAddressLine2]
      ,[PostalPostalCode]
      ,[LastEditedBy]    
    )
    SELECT TOP 5
		[CustomerID]+13
	  ,[CustomerName]
      ,[BillToCustomerID]
      ,[CustomerCategoryID]
      ,[AlternateContactPersonID]
      ,[DeliveryMethodID]
      ,[DeliveryCityID]
      ,[PostalCityID]
      ,[CreditLimit]
      ,[AccountOpenedDate]
      ,[StandardDiscountPercentage]
      ,[IsStatementSent]
      ,[IsOnCreditHold]
      ,[PhoneNumber]
	  ,[PaymentDays]
      ,[FaxNumber]
      ,[DeliveryRun]
      ,[RunPosition]
      ,[WebsiteURL]
      ,[DeliveryAddressLine1]
      ,[DeliveryAddressLine2]
      ,[DeliveryPostalCode]
      ,[DeliveryLocation]
      ,[PostalAddressLine1]
      ,[PostalAddressLine2]
      ,[PostalPostalCode]
      ,[LastEditedBy]
  FROM [Sales].[Customers]
  	
	SELECT * FROM [Purchasing].[Suppliers]

/*
2. Удалите одну запись из Customers, которая была вами добавлена
*/

	DELETE FROM [Purchasing].[Suppliers]
	WHERE SupplierID = 18

	SELECT * FROM [Purchasing].[Suppliers]


/*
3. Изменить одну запись, из добавленных через UPDATE
*/

	UPDATE [Purchasing].[Suppliers]
	SET SupplierName = 'TestUpdate'
	WHERE SupplierID = 17

	SELECT * FROM [Purchasing].[Suppliers]

/*
4. Написать MERGE, который вставит вставит запись в клиенты, если ее там нет, и изменит если она уже есть
*/

	MERGE [Sales].[Customers] AS target 
	USING (SELECT  [SupplierID]+1048
				 ,[SupplierName]
				 ,[SupplierCategoryID]
				 ,[PrimaryContactPersonID]
				 ,[AlternateContactPersonID]
				 ,[DeliveryMethodID]
				 ,[DeliveryCityID]
				 ,[PostalCityID]
				 ,[SupplierReference]
				 ,[BankAccountName]
				 ,[BankAccountBranch]
				 ,[BankAccountCode]
				 ,[BankAccountNumber]
				 ,[BankInternationalCode]
				 ,[PaymentDays]
				 ,[InternalComments]
				 ,[PhoneNumber]
				 ,[FaxNumber]
				 ,[WebsiteURL]
				 ,[DeliveryAddressLine1]
				 ,[DeliveryAddressLine2]
				 ,[DeliveryPostalCode]
				 ,[DeliveryLocation]
				 ,[PostalAddressLine1]
				 ,[PostalAddressLine2]
				 ,[PostalPostalCode]
				 ,[LastEditedBy]
	FROM [Purchasing].[Suppliers] 
	where [SupplierID]>16
		) 
		AS source (	 [SupplierID]
					,[SupplierName]
					,[SupplierCategoryID]
					,[PrimaryContactPersonID]
					,[AlternateContactPersonID]
					,[DeliveryMethodID]
					,[DeliveryCityID]
					,[PostalCityID]
					,[SupplierReference]
					,[BankAccountName]
					,[BankAccountBranch]
					,[BankAccountCode]
					,[BankAccountNumber]
					,[BankInternationalCode]
					,[PaymentDays]
					,[InternalComments]
					,[PhoneNumber]
					,[FaxNumber]
					,[WebsiteURL]
					,[DeliveryAddressLine1]
					,[DeliveryAddressLine2]
					,[DeliveryPostalCode]
					,[DeliveryLocation]
					,[PostalAddressLine1]
					,[PostalAddressLine2]
					,[PostalPostalCode]
					,[LastEditedBy]) 
		ON
	 (target.[CustomerName] = source.[SupplierName] and target.[CustomerID] = source.[SupplierID]) 
	WHEN MATCHED 
		THEN UPDATE SET  [CustomerID]					= source.[SupplierID]
						,[CustomerName]					= source.[SupplierName]
						,[BillToCustomerID]				= source.[SupplierCategoryID]
						,[PrimaryContactPersonID]		= 3
						,[CustomerCategoryID]			= source.[PrimaryContactPersonID]
						,[AlternateContactPersonID]		= source.[AlternateContactPersonID]
						,[DeliveryMethodID]				= source.[DeliveryMethodID]
						,[DeliveryCityID]				= source.[DeliveryCityID]
						,[PostalCityID]					= source.[PostalCityID]
						,[CreditLimit]					= source.[SupplierReference]
						,[AccountOpenedDate]			= source.[BankAccountName]
						,[StandardDiscountPercentage]	= source.[BankAccountBranch]
						,[IsStatementSent]				= source.[BankAccountCode]
						,[IsOnCreditHold]				= source.[BankAccountNumber]
						,[PhoneNumber]					= source.[BankInternationalCode]
						,[PaymentDays]					= source.[PaymentDays]
						,[FaxNumber]					= source.[InternalComments]
						,[DeliveryRun]					= source.[PhoneNumber]
						,[RunPosition]					= source.[FaxNumber]
						,[WebsiteURL]					= source.[WebsiteURL]
						,[DeliveryAddressLine1]			= source.[DeliveryAddressLine1]
						,[DeliveryAddressLine2]			= source.[DeliveryAddressLine2]
						,[DeliveryPostalCode]			= source.[DeliveryPostalCode]
						,[DeliveryLocation]				= source.[DeliveryLocation]
						,[PostalAddressLine1]			= source.[PostalAddressLine1]
						,[PostalAddressLine2]			= source.[PostalAddressLine2]
						,[PostalPostalCode]				= source.[PostalPostalCode]
						,[LastEditedBy]					= source.[LastEditedBy] 
	WHEN NOT MATCHED 
		THEN INSERT (	 [CustomerID]					
						,[CustomerName]					
						,[BillToCustomerID]				
						,[CustomerCategoryID]
						,[PrimaryContactPersonID]
						,[AlternateContactPersonID]		
						,[DeliveryMethodID]				
						,[DeliveryCityID]				
						,[PostalCityID]					
						,[CreditLimit]					
						,[AccountOpenedDate]			
						,[StandardDiscountPercentage]	
						,[IsStatementSent]				
						,[IsOnCreditHold]				
						,[PhoneNumber]					
						,[PaymentDays]					
						,[FaxNumber]					
						,[DeliveryRun]					
						,[RunPosition]					
						,[WebsiteURL]					
						,[DeliveryAddressLine1]			
						,[DeliveryAddressLine2]			
						,[DeliveryPostalCode]			
						,[DeliveryLocation]				
						,[PostalAddressLine1]			
						,[PostalAddressLine2]			
						,[PostalPostalCode]				
						,[LastEditedBy]	) 
			VALUES (source.[SupplierID]
					,source.[SupplierName]
					,source.[SupplierCategoryID]
					,3
					,source.[PrimaryContactPersonID]
					,source.[AlternateContactPersonID]
					,source.[DeliveryMethodID]
					,source.[DeliveryCityID]
					,source.[PostalCityID]
					,source.[SupplierReference]
					,source.[BankAccountName]
					,source.[BankAccountBranch]
					,source.[BankAccountCode]
					,source.[BankAccountNumber]
					,source.[BankInternationalCode]
					,source.[PaymentDays]
					,source.[InternalComments]
					,source.[PhoneNumber]
					,source.[FaxNumber]
					,source.[WebsiteURL]
					,source.[DeliveryAddressLine1]
					,source.[DeliveryAddressLine2]
					,source.[DeliveryPostalCode]
					,source.[DeliveryLocation]
					,source.[PostalAddressLine1]
					,source.[PostalAddressLine2]
					,source.[PostalPostalCode]
					,source.[LastEditedBy]) 
	OUTPUT deleted.*, $action, inserted.*;
	

	MERGE [Sales].[Customers] AS target 
	USING (SELECT  [SupplierID]
				 ,[SupplierName]
				 ,[SupplierCategoryID]
				 ,[PrimaryContactPersonID]
				 ,[AlternateContactPersonID]
				 ,[DeliveryMethodID]
				 ,[DeliveryCityID]
				 ,[PostalCityID]
				 ,[SupplierReference]
				 ,[BankAccountName]
				 ,[BankAccountBranch]
				 ,[BankAccountCode]
				 ,[BankAccountNumber]
				 ,[BankInternationalCode]
				 ,[PaymentDays]
				 ,[InternalComments]
				 ,[PhoneNumber]
				 ,[FaxNumber]
				 ,[WebsiteURL]
				 ,[DeliveryAddressLine1]
				 ,[DeliveryAddressLine2]
				 ,[DeliveryPostalCode]
				 ,[DeliveryLocation]
				 ,[PostalAddressLine1]
				 ,[PostalAddressLine2]
				 ,[PostalPostalCode]
				 ,[LastEditedBy]
	FROM [Purchasing].[Suppliers] 
	where [SupplierID]>13
		) 
		AS source (	 [SupplierID]
					,[SupplierName]
					,[SupplierCategoryID]
					,[PrimaryContactPersonID]
					,[AlternateContactPersonID]
					,[DeliveryMethodID]
					,[DeliveryCityID]
					,[PostalCityID]
					,[SupplierReference]
					,[BankAccountName]
					,[BankAccountBranch]
					,[BankAccountCode]
					,[BankAccountNumber]
					,[BankInternationalCode]
					,[PaymentDays]
					,[InternalComments]
					,[PhoneNumber]
					,[FaxNumber]
					,[WebsiteURL]
					,[DeliveryAddressLine1]
					,[DeliveryAddressLine2]
					,[DeliveryPostalCode]
					,[DeliveryLocation]
					,[PostalAddressLine1]
					,[PostalAddressLine2]
					,[PostalPostalCode]
					,[LastEditedBy]) 
		ON
	 (target.[CustomerName] = source.[SupplierName]) 
	WHEN MATCHED 
		THEN UPDATE SET  [CustomerID]					= source.[SupplierID]
						,[CustomerName]					= source.[SupplierName]
						,[BillToCustomerID]				= source.[SupplierCategoryID]
						,[CustomerCategoryID]			= source.[PrimaryContactPersonID]
						,[AlternateContactPersonID]		= source.[AlternateContactPersonID]
						,[DeliveryMethodID]				= source.[DeliveryMethodID]
						,[DeliveryCityID]				= source.[DeliveryCityID]
						,[PostalCityID]					= source.[PostalCityID]
						,[CreditLimit]					= source.[SupplierReference]
						,[AccountOpenedDate]			= source.[BankAccountName]
						,[StandardDiscountPercentage]	= source.[BankAccountBranch]
						,[IsStatementSent]				= source.[BankAccountCode]
						,[IsOnCreditHold]				= source.[BankAccountNumber]
						,[PhoneNumber]					= source.[BankInternationalCode]
						,[PaymentDays]					= source.[PaymentDays]
						,[FaxNumber]					= source.[InternalComments]
						,[DeliveryRun]					= source.[PhoneNumber]
						,[RunPosition]					= source.[FaxNumber]
						,[WebsiteURL]					= source.[WebsiteURL]
						,[DeliveryAddressLine1]			= source.[DeliveryAddressLine1]
						,[DeliveryAddressLine2]			= source.[DeliveryAddressLine2]
						,[DeliveryPostalCode]			= source.[DeliveryPostalCode]
						,[DeliveryLocation]				= source.[DeliveryLocation]
						,[PostalAddressLine1]			= source.[PostalAddressLine1]
						,[PostalAddressLine2]			= source.[PostalAddressLine2]
						,[PostalPostalCode]				= source.[PostalPostalCode]
						,[LastEditedBy]					= source.[LastEditedBy] 
	WHEN NOT MATCHED 
		THEN INSERT ([SupplierID]
					 ,[SupplierName]
					 ,[SupplierCategoryID]
					 ,[PrimaryContactPersonID]
					 ,[AlternateContactPersonID]
					 ,[DeliveryMethodID]
					 ,[DeliveryCityID]
					 ,[PostalCityID]
					 ,[SupplierReference]
					 ,[BankAccountName]
					 ,[BankAccountBranch]
					 ,[BankAccountCode]
					 ,[BankAccountNumber]
					 ,[BankInternationalCode]
					 ,[PaymentDays]
					 ,[InternalComments]
					 ,[PhoneNumber]
					 ,[FaxNumber]
					 ,[WebsiteURL]
					 ,[DeliveryAddressLine1]
					 ,[DeliveryAddressLine2]
					 ,[DeliveryPostalCode]
					 ,[DeliveryLocation]
					 ,[PostalAddressLine1]
					 ,[PostalAddressLine2]
					 ,[PostalPostalCode]
					 ,[LastEditedBy]) 
			VALUES (source.[SupplierID]
					,source.[SupplierName]
					,source.[SupplierCategoryID]
					,source.[PrimaryContactPersonID]
					,source.[AlternateContactPersonID]
					,source.[DeliveryMethodID]
					,source.[DeliveryCityID]
					,source.[PostalCityID]
					,source.[SupplierReference]
					,source.[BankAccountName]
					,source.[BankAccountBranch]
					,source.[BankAccountCode]
					,source.[BankAccountNumber]
					,source.[BankInternationalCode]
					,source.[PaymentDays]
					,source.[InternalComments]
					,source.[PhoneNumber]
					,source.[FaxNumber]
					,source.[WebsiteURL]
					,source.[DeliveryAddressLine1]
					,source.[DeliveryAddressLine2]
					,source.[DeliveryPostalCode]
					,source.[DeliveryLocation]
					,source.[PostalAddressLine1]
					,source.[PostalAddressLine2]
					,source.[PostalPostalCode]
					,source.[LastEditedBy]) 
	OUTPUT deleted.*, $action, inserted.*;

	SELECT * FROM [Sales].[Customers]
/*
5. Напишите запрос, который выгрузит данные через bcp out и загрузить через bulk insert
*/

-- To allow advanced options to be changed.  
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


exec master..xp_cmdshell 'bcp "[WideWorldImporters].Sales.InvoiceLines" out  "C:\Users\dmitrymp\InvL.txt" -T -w -t, -S ROCHWS1027\SQL2017'


-----------
drop table if exists [Sales].[InvoiceLines_BulkDemo]

CREATE TABLE [Sales].[InvoiceLines_BulkDemo](
	[InvoiceLineID] [int] NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[PackageTypeID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[LineProfit] [decimal](18, 2) NOT NULL,
	[ExtendedPrice] [decimal](18, 2) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Sales_InvoiceLines_BulkDemo] PRIMARY KEY CLUSTERED 
(
	[InvoiceLineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
----



	BULK INSERT [WideWorldImporters].[Sales].[InvoiceLines_BulkDemo]
				   FROM "C:\Users\dmitrymp\InvL.txt"
				   WITH 
					 (
						BATCHSIZE = 1000, 
						DATAFILETYPE = 'widechar',
						FIELDTERMINATOR = ',',
						ROWTERMINATOR ='\n',
						KEEPNULLS,
						TABLOCK        
					  );



select Count(*) from [Sales].[InvoiceLines_BulkDemo];

TRUNCATE TABLE [Sales].[InvoiceLines_BulkDemo];