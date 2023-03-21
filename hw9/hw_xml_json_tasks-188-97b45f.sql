/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "08 - Выборки из XML и JSON полей".

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
Примечания к заданиям 1, 2:
* Если с выгрузкой в файл будут проблемы, то можно сделать просто SELECT c результатом в виде XML. 
* Если у вас в проекте предусмотрен экспорт/импорт в XML, то можете взять свой XML и свои таблицы.
* Если с этим XML вам будет скучно, то можете взять любые открытые данные и импортировать их в таблицы (например, с https://data.gov.ru).
* Пример экспорта/импорта в файл https://docs.microsoft.com/en-us/sql/relational-databases/import-export/examples-of-bulk-import-and-export-of-xml-documents-sql-server
*/


/*
1. В личном кабинете есть файл StockItems.xml.
Это данные из таблицы Warehouse.StockItems.
Преобразовать эти данные в плоскую таблицу с полями, аналогичными Warehouse.StockItems.
Поля: StockItemName, SupplierID, UnitPackageID, OuterPackageID, QuantityPerOuter, TypicalWeightPerUnit, LeadTimeDays, IsChillerStock, TaxRate, UnitPrice 

Загрузить эти данные в таблицу Warehouse.StockItems: 
существующие записи в таблице обновить, отсутствующие добавить (сопоставлять записи по полю StockItemName). 

Сделать два варианта: с помощью OPENXML и через XQuery.
*/

--OPENXML
DROP TABLE IF EXISTS #StockItems
CREATE TABLE #StockItems(
	 StockItemName nvarchar(100) COLLATE Latin1_General_100_CI_AS 
	,SupplierID int
	,UnitPackageID int
	,OuterPackageID int
	,QuantityPerOuter int
	,TypicalWeightPerUnit decimal(18, 3)
	,LeadTimeDays int 
	,IsChillerStock bit 
	,TaxRate decimal(18, 3)
	,UnitPrice decimal(18, 2))

DECLARE @docHandle int
DECLARE @xmlDocument  xml

SELECT @xmlDocument = BulkColumn
FROM OPENROWSET
(BULK 'C:\Users\daniilig\Documents\StockItems.xml', SINGLE_CLOB)
as data
EXEC sp_xml_preparedocument @docHandle OUTPUT, @xmlDocument

--XQuery
DECLARE @x XML
SET @x = ( 
  SELECT * FROM OPENROWSET
  (BULK 'C:\Users\daniilig\Documents\StockItems.xml',
   SINGLE_CLOB) as d)

SELECT  
  t.StockItem.value('(@Name)', 'nvarchar(100)')							   as [StockItemName],
  t.StockItem.value('(SupplierID)[1]', 'int')							   as [SupplierID],
  t.StockItem.value('(Package/UnitPackageID)[1]', 'int')				   as [UnitPackageID],
  t.StockItem.value('(Package/OuterPackageID)[1]', 'int')				   as [OuterPackageID],
  t.StockItem.value('(Package/QuantityPerOuter)[1]', 'int')				   as [QuantityPerOuter],
  t.StockItem.value('(Package/TypicalWeightPerUnit)[1]', 'decimal(18, 3)') as [TypicalWeightPerUnit],
  t.StockItem.value('(LeadTimeDays)[1]', 'int')							   as [LeadTimeDays],
  t.StockItem.value('(IsChillerStock)[1]', 'bit')						   as [IsChillerStock],
  t.StockItem.value('(TaxRate)[1]', 'decimal(18, 3)')					   as [TaxRate],
  t.StockItem.value('(UnitPrice)[1]', 'decimal(18, 2)')					   as [UnitPrice]
FROM @x.nodes('/StockItems/Item') as t(StockItem)

INSERT INTO #StockItems
SELECT *
FROM OPENXML(@docHandle, N'/StockItems/Item') WITH ( 
		[StockItemName]			nvarchar(100)	'@Name',
		[SupplierID]			int				'SupplierID',
		[UnitPackageID]			int				'Package/UnitPackageID',
		[OuterPackageID]		int				'Package/OuterPackageID',
		[QuantityPerOuter]		int				'Package/QuantityPerOuter',
		[TypicalWeightPerUnit]  decimal(18, 3)  'Package/TypicalWeightPerUnit',
		[LeadTimeDays]		    int				'LeadTimeDays',
		[IsChillerStock]		bit				'IsChillerStock',
		[TaxRate]		        decimal(18, 3)  'TaxRate',
		[UnitPrice]		        decimal(18, 2)  'UnitPrice')

--Merge
MERGE Warehouse.StockItems AS target 
	USING (SELECT 
			StockItemName COLLATE DATABASE_DEFAULT,
			SupplierID,
			UnitPackageID,
			OuterPackageID,
			LeadTimeDays
            ,QuantityPerOuter,
			IsChillerStock,
			TaxRate,
			UnitPrice,
			TypicalWeightPerUnit
			FROM #StockItems
			) AS source (
			StockItemName,
			SupplierID,
			UnitPackageID,
			OuterPackageID,
			LeadTimeDays,
			QuantityPerOuter,
			IsChillerStock,
			TaxRate,
			UnitPrice,
			TypicalWeightPerUnit
			) ON (target.StockItemName = source.StockItemName) 
	WHEN MATCHED THEN UPDATE SET  
					 [StockItemName]			= source.[StockItemName],
                     [SupplierID]				= source.[SupplierID],
                     [UnitPackageID]			= source.[UnitPackageID],
                     [OuterPackageID]			= source.[OuterPackageID],
                     [LeadTimeDays]				= source.[LeadTimeDays],
                     [QuantityPerOuter]			= source.[QuantityPerOuter],
                     [IsChillerStock]			= source.[IsChillerStock],
                     [TaxRate]					= source.[TaxRate],
                     [UnitPrice]				= source.[UnitPrice],
                     [TypicalWeightPerUnit]		= source.[TypicalWeightPerUnit],
                     [LastEditedBy]				= 1
	WHEN NOT MATCHED 
		THEN INSERT (
			[StockItemName],
			[SupplierID],
			[UnitPackageID],
			[OuterPackageID],
			[LeadTimeDays],
			[QuantityPerOuter],
			[IsChillerStock],
			[TaxRate],
			[UnitPrice],
			[TypicalWeightPerUnit],
			[LastEditedBy])
		  VALUES (
			 source.[StockItemName],
			 source.[SupplierID],
			 source.[UnitPackageID],
			 source.[OuterPackageID],
			 source.[LeadTimeDays],
			 source.[QuantityPerOuter],
			 source.[IsChillerStock],
			 source.[TaxRate],
			 source.[UnitPrice],
			 source.[TypicalWeightPerUnit],1)
		OUTPUT deleted.*, $action, inserted.*;

/*
2. Выгрузить данные из таблицы StockItems в такой же xml-файл, как StockItems.xml
*/

DECLARE @xmlDocument xml

SELECT @xmlDocument = (SELECT 
StockItemName AS '@Name',
SupplierID,
	(SELECT 
		 UnitPackageID,
		 OuterPackageID,
		 QuantityPerOuter,
		 TypicalWeightPerUnit 
	 FROM Warehouse.StockItems AS st
	 WHERE st.StockItemID = st1.StockItemID
	 FOR XML PATH (''), TYPE, ROOT ('Package')),
LeadTimeDays,
IsChillerStock,
TaxRate,
UnitPrice 
FROM Warehouse.StockItems AS st1
FOR XML PATH ('Item'), TYPE, ROOT ('StockItems'))

SELECT @xmlDocument AS xmldoc


/*
3. В таблице Warehouse.StockItems в колонке CustomFields есть данные в JSON.
Написать SELECT для вывода:
- StockItemID
- StockItemName
- CountryOfManufacture (из CustomFields)
- FirstTag (из поля CustomFields, первое значение из массива Tags)
*/

SELECT
		StockItemID,
		StockItemName,
		JSON_VALUE(CustomFields, '$.CountryOfManufacture') AS COM,
		JSON_VALUE(CustomFields, '$.Tags[1]') AS T
FROM Warehouse.StockItems

/*
4. Найти в StockItems строки, где есть тэг "Vintage".
Вывести: 
- StockItemID
- StockItemName
- (опционально) все теги (из CustomFields) через запятую в одном поле

Тэги искать в поле CustomFields, а не в Tags.
Запрос написать через функции работы с JSON.
Для поиска использовать равенство, использовать LIKE запрещено.

Должно быть в таком виде:
... where ... = 'Vintage'

Так принято не будет:
... where ... Tags like '%Vintage%'
... where ... CustomFields like '%Vintage%' 
*/


SELECT 
	StockItemID,
	StockItemName,
	T.[value]
FROM Warehouse.StockItems
	CROSS APPLY  OPENJSON(CustomFields, '$.Tags') AS T
WHERE 	T.[value] = 'Vintage'

