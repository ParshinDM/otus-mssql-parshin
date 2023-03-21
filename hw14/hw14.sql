USE master
GO

ALTER DATABASE WideWorldImporters
SET ENABLE_BROKER WITH NO_WAIT;

ALTER DATABASE WideWorldImporters 
SET TRUSTWORTHY ON;

ALTER AUTHORIZATION    
ON DATABASE::WideWorldImporters TO [sa];

USE WideWorldImporters
CREATE MESSAGE TYPE
[//WWI/SB/RequestMessage]
VALIDATION=WELL_FORMED_XML;

CREATE MESSAGE TYPE
[//WWI/SB/ReplyMessage]
VALIDATION=WELL_FORMED_XML; 

GO

CREATE CONTRACT [//WWI/SB/Contract](
	  [//WWI/SB/RequestMessage]
         SENT BY INITIATOR,
       [//WWI/SB/ReplyMessage]
         SENT BY TARGET);
GO


CREATE QUEUE TargetQueueWWI;

CREATE SERVICE [//WWI/SB/TargetService]
       ON QUEUE TargetQueueWWI
       ([//WWI/SB/Contract]);
GO


CREATE QUEUE InitiatorQueueWWI;

CREATE SERVICE [//WWI/SB/InitiatorService]
       ON QUEUE InitiatorQueueWWI
       ([//WWI/SB/Contract]);
GO


CREATE TABLE sales.cust_orders_cnt
(
    customer_id	INT,
    orders_cnt	INT,
    date_start  DATE,
    date_end	DATE
)
GO

Create PROCEDURE Sales.Send_Order
	@invoiceId		INT,
	@date_start		DATE,
	@date_end		DATE
AS
BEGIN
	DECLARE @InitDlgHandle UNIQUEIDENTIFIER;
	DECLARE @RequestMessage NVARCHAR(4000);
	
	BEGIN TRAN 
	SELECT @RequestMessage = (SELECT 
								InvoiceID,
								CustomerID,
								@date_start		AS date_start,
								@date_end		AS date_end
							  FROM Sales.Invoices AS Inv
							  WHERE InvoiceID = @invoiceId
							  FOR XML AUTO, root('RequestMessage'));
	BEGIN DIALOG @InitDlgHandle
	FROM SERVICE
	[//WWI/SB/InitiatorService]
	TO SERVICE
	'//WWI/SB/TargetService'
	ON CONTRACT
	[//WWI/SB/Contract]
	WITH ENCRYPTION=OFF; 

	SEND ON CONVERSATION @InitDlgHandle 
	MESSAGE TYPE
	[//WWI/SB/RequestMessage]
	(@RequestMessage);
	COMMIT TRAN 
END
GO


CREATE PROCEDURE Sales.Get_Order
AS
BEGIN

	DECLARE @TargetDlgHandle UNIQUEIDENTIFIER,
			@Message			NVARCHAR(4000),
			@MessageType		SYSNAME,
			@ReplyMessage		NVARCHAR(4000),
			@ReplyMessageName	SYSNAME,
			@CustomerID			INT,
			@date_start			DATE,
			@date_end			DATE,
			@xml				XML; 
	
	BEGIN TRAN; 
	RECEIVE TOP(1)
		@TargetDlgHandle = Conversation_Handle,
		@Message = Message_Body,
		@MessageType = Message_Type_Name
	FROM dbo.TargetQueueWWI; 

	SELECT @Message;

	SET @xml = CAST(@Message AS XML);

	SELECT @CustomerID = R.Iv.value('@CustomerID','INT'),
		   @date_start = R.Iv.value('@date_start','DATE'),
		   @date_end = R.Iv.value('@date_end','DATE')
	FROM @xml.nodes('/RequestMessage/Inv') as R(Iv);

	IF EXISTS (select CustomerID  From Sales.Orders	where CustomerID = @CustomerID)
	BEGIN
		MERGE Sales.cust_orders_cnt AS target 
			USING (SELECT 
						o.CustomerID
						,count (o.OrderID)	AS cnt_order
						,@date_start		AS date_start
						,@date_end			AS date_end
					FROM Sales.Orders AS o
					WHERE o.CustomerID = @CustomerID
					and o.OrderDate between  @date_start and @date_end
					GROUP BY o.CustomerID
				) 
				AS source (CustomerID,cnt_order,date_start,date_end) 
				ON (target.customer_id = source.CustomerID) 
			WHEN MATCHED 
				THEN UPDATE SET customer_id = source.CustomerID,
								orders_cnt = source.cnt_order,
								date_start = source.date_start,
								date_end = source.date_end
			WHEN NOT MATCHED 
				THEN INSERT (customer_id,orders_cnt,date_start,date_end) 
					VALUES (source.CustomerID,source.cnt_order,source.date_start,source.date_end) 
			OUTPUT deleted.*, $action, inserted.*;
	END;
	
	SELECT @Message AS ReceivedRequestMessage, @MessageType; 
	
	IF @MessageType=N'//WWI/SB/RequestMessage'
	BEGIN
		SET @ReplyMessage =N'<ReplyMessage> Message received</ReplyMessage>'; 
	
		SEND ON CONVERSATION @TargetDlgHandle
		MESSAGE TYPE
		[//WWI/SB/ReplyMessage]
		(@ReplyMessage);
		END CONVERSATION @TargetDlgHandle;
	END 
	
	SELECT @ReplyMessage AS SentReplyMessage; 
	COMMIT TRAN;
END
go


CREATE PROCEDURE Sales.ConfirmInvoice
AS
BEGIN	
	DECLARE @InitiatorReplyDlgHandle UNIQUEIDENTIFIER,
			@ReplyReceivedMessage NVARCHAR(1000) 	
	BEGIN TRAN; 
		RECEIVE TOP(1)
			@InitiatorReplyDlgHandle=Conversation_Handle
			,@ReplyReceivedMessage=Message_Body
		FROM dbo.InitiatorQueueWWI; 	
		END CONVERSATION @InitiatorReplyDlgHandle; 
		
		SELECT @ReplyReceivedMessage AS ReceivedRepliedMessage; 
	COMMIT TRAN; 
END


ALTER QUEUE [dbo].[InitiatorQueueWWI] WITH STATUS = ON , RETENTION = OFF , POISON_MESSAGE_HANDLING (STATUS = OFF), 
	ACTIVATION (STATUS = ON ,PROCEDURE_NAME = Sales.ConfirmInvoice, MAX_QUEUE_READERS = 1, EXECUTE AS OWNER) ; 
GO
ALTER QUEUE [dbo].[TargetQueueWWI] WITH STATUS = ON , RETENTION = OFF , POISON_MESSAGE_HANDLING (STATUS = OFF), 
	ACTIVATION (STATUS = ON , PROCEDURE_NAME = Sales.Get_Order, MAX_QUEUE_READERS = 1, EXECUTE AS OWNER); 
GO



SELECT *
FROM  Sales.cust_orders_cnt;

--Отправить
EXEC Sales.Send_Order
	@invoiceId = 61236,
	@date_start = '2013-01-01',
	@date_end = '2014-01-01';

SELECT CAST(message_body AS XML),*
FROM dbo.TargetQueueWWI;

SELECT CAST(message_body AS XML),*
FROM dbo.InitiatorQueueWWI;

--Получатель
EXECUTE Sales.Get_Order;
--Отправитель
EXECUTE Sales.ConfirmInvoice;