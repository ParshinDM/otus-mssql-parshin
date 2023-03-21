USE [dbadmin]
GO

/****** Object:  Table [dbo].[tsk$Module]    Script Date: 21.03.2023 21:10:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tsk$Module](
	[IDModule] [uniqueidentifier] NOT NULL,
	[ModuleName] [varchar](255) NOT NULL,
	[IDRecStatus] [int] NOT NULL,
	[CreateUser] [varchar](255) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ChangeUser] [varchar](255) NULL,
	[ChangeDate] [datetime] NULL,
	[IdModuleGroup] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDModule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [dbadmin]
GO

/****** Object:  Table [dbo].[tsk$Priority]    Script Date: 21.03.2023 21:10:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tsk$Priority](
	[IDPriority] [uniqueidentifier] NOT NULL,
	[PriorityName] [varchar](255) NOT NULL,
	[IDRecStatus] [int] NOT NULL,
	[CreateUser] [varchar](255) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ChangeUser] [varchar](255) NULL,
	[ChangeDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPriority] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [dbadmin]
GO

/****** Object:  Table [dbo].[tsk$Tasks]    Script Date: 21.03.2023 21:10:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tsk$Tasks](
	[IdTask] [int] IDENTITY(1,1) NOT NULL,
	[IdTaskType] [uniqueidentifier] NOT NULL,
	[TaskName] [varchar](1000) NOT NULL,
	[BeginDate] [date] NOT NULL,
	[PlanDate] [date] NULL,
	[FactDate] [date] NULL,
	[IdAuthor] [uniqueidentifier] NOT NULL,
	[IdImplementor] [uniqueidentifier] NOT NULL,
	[IdCustomer] [uniqueidentifier] NULL,
	[IdModule] [uniqueidentifier] NOT NULL,
	[Result] [varchar](1000) NULL,
	[IdTaskStatus] [uniqueidentifier] NOT NULL,
	[TaskReady] [int] NULL,
	[IdParent] [int] NULL,
	[IdPriority] [uniqueidentifier] NOT NULL,
	[Comment] [varchar](1000) NULL,
	[IdRecStatus] [int] NOT NULL,
	[CreateUser] [varchar](255) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ChangeUser] [varchar](255) NULL,
	[ChangeDate] [datetime] NULL,
	[ParentReady] [int] NULL,
	[IdModuleGroup] [int] NULL,
	[client] [varchar](255) NULL,
	[IdSmartTask] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTask] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [dbadmin]
GO

/****** Object:  Table [dbo].[tsk$TasksParent]    Script Date: 21.03.2023 21:11:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tsk$TasksParent](
	[IdTaskParent] [int] IDENTITY(1,1) NOT NULL,
	[TaskParentName] [varchar](1000) NOT NULL,
	[BeginDateParent] [date] NOT NULL,
	[PlanDateParent] [date] NULL,
	[FactDateParent] [date] NULL,
	[TaskParentReady] [int] NULL,
	[CommentParent] [varchar](1000) NULL,
	[IdRecStatus] [int] NOT NULL,
	[CreateUser] [varchar](255) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ChangeUser] [varchar](255) NULL,
	[ChangeDate] [datetime] NULL,
	[IdParentGroup] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTaskParent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [dbadmin]
GO

/****** Object:  Table [dbo].[tsk$TasksParentCheckPoint]    Script Date: 21.03.2023 21:11:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tsk$TasksParentCheckPoint](
	[IDCheckPoint] [uniqueidentifier] NOT NULL,
	[IdTaskCP] [int] NULL,
	[IdTaskParentCP] [int] NULL,
	[CheckPointDate] [date] NULL,
	[ParentReadyCP] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCheckPoint] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [dbadmin]
GO

/****** Object:  Table [dbo].[tsk$TasksStek]    Script Date: 21.03.2023 21:11:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tsk$TasksStek](
	[IdTasksStek] [uniqueidentifier] NOT NULL,
	[TasksStekName] [varchar](255) NOT NULL,
	[IDTasksStekPriority] [uniqueidentifier] NOT NULL,
	[TasksStekComment] [varchar](1000) NULL,
	[TasksStekDate] [date] NULL,
	[IDRecStatus] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreateUser] [varchar](255) NOT NULL,
	[ChangeUser] [varchar](255) NULL,
	[ChangeDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTasksStek] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [dbadmin]
GO

/****** Object:  Table [dbo].[tsk$TaskStatus]    Script Date: 21.03.2023 21:11:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tsk$TaskStatus](
	[IDTaskStatus] [uniqueidentifier] NOT NULL,
	[TaskStatusName] [varchar](255) NOT NULL,
	[IDRecStatus] [int] NOT NULL,
	[CreateUser] [varchar](255) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ChangeUser] [varchar](255) NULL,
	[ChangeDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDTaskStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [dbadmin]
GO

/****** Object:  Table [dbo].[tsk$TaskType]    Script Date: 21.03.2023 21:11:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tsk$TaskType](
	[IDTaskType] [uniqueidentifier] NOT NULL,
	[TaskTypeName] [varchar](255) NOT NULL,
	[IDRecStatus] [int] NOT NULL,
	[CreateUser] [varchar](255) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ChangeUser] [varchar](255) NULL,
	[ChangeDate] [datetime] NULL,
	[IdTypeGroup] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDTaskType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [dbadmin]
GO

/****** Object:  Table [dbo].[UsersList]    Script Date: 21.03.2023 21:12:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UsersList](
	[IDUser] [uniqueidentifier] NOT NULL,
	[EMail] [varchar](150) NULL,
	[CreateDate] [smalldatetime] NOT NULL,
	[IDUserGuid] [uniqueidentifier] NOT NULL,
	[FirstName] [varchar](255) NULL,
	[MiddleName] [varchar](255) NULL,
	[LastName] [varchar](255) NOT NULL,
	[FullName]  AS ((isnull([LastName],'')+isnull(' '+[FirstName],''))+isnull(' '+[MiddleName],'')),
	[ShortName]  AS ((isnull([LastName],'')+isnull((' '+left([FirstName],(1)))+'.',''))+isnull((' '+left([MiddleName],(1)))+'.','')),
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[IDUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [dbadmin]
GO

/****** Object:  View [dbo].[tsk$Implementor]    Script Date: 21.03.2023 21:12:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[tsk$Implementor]
AS
	SELECT IDUserGuid, FullName 
	FROM dbo.UsersList
	WHERE IDUserGuid = '17419062-14de-4a3c-b7a3-aa39d516c19c' OR IDUserGuid  =  '7361e272-28d1-43ee-98ab-8c007f5d240e'
GO

USE [dbadmin]
GO

/****** Object:  View [dbo].[tsk$Tasks_List]    Script Date: 21.03.2023 21:12:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[tsk$Tasks_List]
AS
	SELECT 
		T.[IdTask]				AS [IdTask],
		TT.[IdTaskType]			AS [IdTaskType],
		TT.[TaskTypeName]		AS [TaskTypeName],
		T.[TaskName]			AS [TaskName],
		T.[BeginDate]			AS [BeginDate],
		T.[PlanDate]			AS [PlanDate],	
		T.[FactDate]			AS [FactDate],
		T.[IdAuthor]			AS [IdAuthor],
		UA.[FullName]			AS [AuthorName],
		T.[IdImplementor]		AS [IdImplementor],	
		UI.[FullName]			AS [ImplementorName],
		T.[IdCustomer]			AS [IdCustomer],
		UC.[FullName]			AS [CustomerName],
		M.[IdModule]			AS [IdModule],
		M.[ModuleName]			AS [ModuleName],
		M.[idModuleGroup]		AS [idModuleGroup],
		T.[Result]				AS [Result],
		TS.[IDTaskStatus]		AS [IdTaskStatus],
		TS.[TaskStatusName]		AS [TaskStatusName],
		T.[TaskReady]			AS [TaskReady],
		T.[IdParent]			AS [IdParent],
		TP.[TaskParentName]		AS [TaskParentName],
		P.[IdPriority]			AS [IdPriority],
		P.[PriorityName]		AS [PriorityName],
		T.[Comment]				AS [Comment],
		CP.[CheckPointDate]		AS [CheckPointDate],
		CP.[ParentReadyCP]		AS [ParentReady]

	FROM [dbo].[tsk$Tasks] AS T WITH ( NOLOCK )
		JOIN [dbo].[tsk$Priority] AS P WITH ( NOLOCK ) ON T.[IdPriority] = P.[IdPriority]
		JOIN [dbo].[tsk$TaskStatus] AS TS WITH ( NOLOCK ) ON T.[IdTaskStatus] = TS.[IdTaskStatus]
		JOIN [dbo].[tsk$TaskType] AS TT WITH ( NOLOCK ) ON T.[IdTaskType] = TT.[IdTaskType]
		JOIN [dbo].[UsersList] AS UI WITH ( NOLOCK ) ON T.[IdImplementor] = UI.[IdUserGuid]
		JOIN [dbo].[UsersList] AS UA WITH ( NOLOCK ) ON T.[IdAuthor] = UA.[IdUserGuid]
		LEFT JOIN [dbo].[UsersList] AS UC WITH ( NOLOCK ) ON T.[IdCustomer] = UC.[IdUserGuid]
		JOIN [dbo].[tsk$Module] AS M WITH ( NOLOCK ) ON T.[IdModule] = M.[IdModule]
		LEFT JOIN [dbo].[tsk$TasksParent] AS TP WITH ( NOLOCK ) ON T.[IdParent] = TP.[IdTaskParent]
		LEFT JOIN [dbo].[tsk$TasksParentCheckPoint] AS CP WITH ( NOLOCK ) ON  T.[IdTask] = CP.[IdTaskCP]

	WHERE	T.IDRecStatus = 0
		AND	P.IDRecStatus = 0
		AND	TS.IDRecStatus = 0
		AND TT.IDRecStatus = 0
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$Module_Delete]    Script Date: 21.03.2023 21:12:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$Module_Delete]
	@IDModule			UNIQUEIDENTIFIER,
	@idUserGuid		    UNIQUEIDENTIFIER
AS 
BEGIN
SET NOCOUNT ON
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$Module_Delete;

	DECLARE @User VARCHAR(255);
	SELECT @User = [ShortName]
	FROM  [dbo].[UsersList]
	WHERE [IDUserGuid] = @idUserGuid;

    UPDATE [dbo].[tsk$Module]
	SET [IDRecStatus]	= -1,
        [ChangeUser]	= @User,
        [ChangeDate]	= GETDATE()
    WHERE [IDModule]	= @IDModule;

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$Module_Delete;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$Module_Insert]    Script Date: 21.03.2023 21:13:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$Module_Insert]
	@ModuleName		 VARCHAR(255),
	@idUserGuid		 UNIQUEIDENTIFIER,
	@idModuleGroup	 INT	
AS
BEGIN
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$Module_Insert;

	DECLARE @User VARCHAR(255);
    SELECT	@User = [ShortName]
    FROM [dbo].[UsersList]
    WHERE [IDUserGuid] = @idUserGuid;

    INSERT INTO [dbo].[tsk$Module]
    (	[IDModule],
		[ModuleName],
		[idModuleGroup],
        [IDRecStatus],
        [CreateDate],
        [CreateUser],
		[ChangeDate],
		[ChangeUser]     
    )
    VALUES
    (	NEWID(),
		@ModuleName,
		@idModuleGroup,
        0,
        GETDATE(),
        @User,
		NULL,
		NULL
     );

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$Module_Insert;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$Module_Update]    Script Date: 21.03.2023 21:13:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$Module_Update]
	@IDModule		UNIQUEIDENTIFIER,
	@ModuleName		VARCHAR(255),
	@idModuleGroup	INT,
	@idUserGuid		UNIQUEIDENTIFIER
AS 
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$Module_Update;

	DECLARE @User VARCHAR(255);
	SELECT	@User = [ShortName]
	FROM [dbo].[UsersList]
	WHERE [IDUserGuid] = @idUserGuid;

	UPDATE [dbo].[tsk$Module]
	SET [ModuleName]	= @ModuleName,
		[idModuleGroup] = @idModuleGroup,
		[ChangeUser]	= @User,
		[ChangeDate]	= GETDATE()
	WHERE [IDModule]	= @IDModule;

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$Module_Update;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$Priority_Delete]    Script Date: 21.03.2023 21:13:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$Priority_Delete]
	@IDPriority			UNIQUEIDENTIFIER,
	@idUserGuid		    UNIQUEIDENTIFIER
AS 
BEGIN
SET NOCOUNT ON
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$Priority_Delete;

	DECLARE @User VARCHAR(255);
	SELECT @User = [ShortName]
	FROM  [dbo].[UsersList]
	WHERE [IDUserGuid] = @idUserGuid;

    UPDATE [dbo].[tsk$Priority]
	SET [IDRecStatus]	= -1,
        [ChangeUser]	= @User,
        [ChangeDate]	= GETDATE()
    WHERE [IDPriority]	= @IDPriority;

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$Priority_Delete;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$Priority_Insert]    Script Date: 21.03.2023 21:13:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$Priority_Insert]
	@PriorityName   VARCHAR(255),
	@idUserGuid		UNIQUEIDENTIFIER
AS
BEGIN
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$Priority_Insert;

	DECLARE @User VARCHAR(255);
    SELECT	@User = [ShortName]
    FROM [dbo].[UsersList]
    WHERE [IDUserGuid] = @idUserGuid;

    INSERT INTO [dbo].[tsk$Priority]
    (	[IDPriority],
		[PriorityName],
        [IDRecStatus],
        [CreateDate],
        [CreateUser],
		[ChangeDate],
		[ChangeUser]     
    )
    VALUES
    (	NEWID(),
		@PriorityName,
        0,
        GETDATE(),
        @User,
		NULL,
		NULL
     );

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$Priority_Insert;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$Priority_Update]    Script Date: 21.03.2023 21:13:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$Priority_Update]
	@IDPriority			UNIQUEIDENTIFIER,
	@PriorityName		VARCHAR(255),
	@idUserGuid			UNIQUEIDENTIFIER
AS 
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$Priority_Update;

	DECLARE @User VARCHAR(255);
	SELECT	@User = [ShortName]
	FROM [dbo].[UsersList]
	WHERE [IDUserGuid] = @idUserGuid;

	UPDATE [dbo].[tsk$Priority]
	SET [PriorityName]	= @PriorityName,
		[ChangeUser]	= @User,
		[ChangeDate]	= GETDATE()
	WHERE [IDPriority]	= @IDPriority;

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$Priority_Update;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$Tasks_Delete]    Script Date: 21.03.2023 21:13:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$Tasks_Delete]
	@IDTask			INT,
	@idUserGuid		UNIQUEIDENTIFIER
AS 
BEGIN
SET NOCOUNT ON
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$Tasks_Delete;

	DECLARE @User VARCHAR(255);
	SELECT @User = [ShortName]
	FROM  [dbo].[UsersList]
	WHERE [IDUserGuid] = @IDUserGuid;

    UPDATE [dbo].[tsk$Tasks]
	SET [IDRecStatus]	= -1,
        [ChangeUser]	= @User,
        [ChangeDate]	= GETDATE()
    WHERE [IDTask]		= @IDTask;

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$Tasks_Delete;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$Tasks_Insert]    Script Date: 21.03.2023 21:13:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[tsk$Tasks_Insert]
	@IdTask				INT OUTPUT,
	@IdTaskType			UNIQUEIDENTIFIER,
	@TaskName			VARCHAR(1000),
	@IdSmartTask		UNIQUEIDENTIFIER = NULL,
	@BeginDate			DATE,
	@PlanDate			DATE = NULL,
	@FactDate			DATE = NULL,
	@IdImplementor		UNIQUEIDENTIFIER,
	@IdCustomer			UNIQUEIDENTIFIER = NULL,
	@IdModule			UNIQUEIDENTIFIER,
	@Result				VARCHAR(1000) = NULL,
	@IdTaskStatus		UNIQUEIDENTIFIER,
	@TaskReady			INT = NULL,
	@IdParent			INT = NULL,
	@TaskParentReady	INT = NULL,
	@ParentReady		INT = NULL,
	@IdPriority			UNIQUEIDENTIFIER,
	@Comment			VARCHAR(1000) = NULL,
	@Client				VARCHAR(255) = NULL,
	@idUserGuid			UNIQUEIDENTIFIER

AS
BEGIN
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$Tasks_Insert;

	DECLARE @User VARCHAR(255);
    SELECT	@User = [ShortName]
    FROM [dbo].[UsersList]
    WHERE [IDUserGuid] = @idUserGuid;

    INSERT INTO [dbo].[tsk$Tasks]
    (	
		[IdTaskType],
		[TaskName],
		[IdSmartTask],
		[BeginDate],
		[PlanDate],
		[FactDate],
		[IdAuthor],
		[IdImplementor],
		[IdCustomer],
		[IdModule],	
		[Result],
		[IdTaskStatus],
		[TaskReady],
		[IdParent],
		[ParentReady],
		[IdPriority],
		[Comment],
		[Client],
		[IDRecStatus],
        [CreateDate],
        [CreateUser],
		[ChangeDate],
		[ChangeUser]     
    )
    VALUES
    (	
		@IDTaskType,
		@TaskName,
		@IdSmartTask,
		@BeginDate,
		@PlanDate,
		@FactDate,
		@idUserGuid,
		@IdImplementor,
		@IdCustomer,
		@IdModule,		
		@Result,
		@IdTaskStatus,
		@TaskReady,
		@IdParent,
		@ParentReady,
		@IdPriority,
		@Comment,
		@Client,
		0,
        GETDATE(),
        @User,
		NULL,
		NULL   
     );

BEGIN
	UPDATE [dbo].[tsk$TasksParent]
		SET [TaskParentReady] = @ParentReady,
			[ChangeUser]	= @User,
			[ChangeDate]	= GETDATE()
WHERE IdTaskParent = @IdParent

	SELECT @IdTask = SCOPE_IDENTITY() ;
	INSERT INTO [dbo].[tsk$TasksParentCheckPoint] (
			[ParentReadyCP],
			[IDCheckPoint], 
			[IdTaskParentCP],			
			[CheckPointDate],
			[IdTaskCP]
			)
			Values(
			 @ParentReady,
			NEWID(),
			@IdParent,			
			GETDATE(),
			@IdTask
			)
END
	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$Tasks_Insert;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$Tasks_Update]    Script Date: 21.03.2023 21:14:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$Tasks_Update]
	@IDTask				INT,
	@TaskName			VARCHAR(1000),
	@IdSmartTask		UNIQUEIDENTIFIER = NULL,
	@BeginDate			DATE,
	@PlanDate			DATE = NULL,
	@FactDate			DATE = NULL,
	@IdImplementor		UNIQUEIDENTIFIER,
	@IdCustomer			UNIQUEIDENTIFIER = NULL,
	@IdModule			UNIQUEIDENTIFIER,
	@IdTaskType			UNIQUEIDENTIFIER,
	@Result				VARCHAR(1000) = NULL,
	@IdTaskStatus		UNIQUEIDENTIFIER,
	@TaskReady			INT = NULL,
	@TaskParentReady	INT = NULL,
	@IdParent			INT = NULL,
	@ParentReady		INT = NULL,
	@IdPriority			UNIQUEIDENTIFIER,
	@Comment			VARCHAR(1000) = NULL,
	@Client				VARCHAR(255) = NULL,
	@idUserGuid			UNIQUEIDENTIFIER
AS 
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$Tasks_Update;

	DECLARE @User VARCHAR(255);
	SELECT	@User = [ShortName]
	FROM [dbo].[UsersList]
	WHERE [IDUserGuid] = @idUserGuid;

	UPDATE [dbo].[tsk$Tasks]
	SET [TaskName]		= @TaskName,
		[IdSmartTask]	= @IdSmartTask,
		[BeginDate]		= @BeginDate,
		[PlanDate]		= @PlanDate,
		[FactDate]		= @FactDate,
		[IdAuthor]		= @idUserGuid,
		[IdImplementor]	= @IdImplementor,
		[IdCustomer]	= @IdCustomer,
		[IdModule]		= @IdModule,
		[IdTaskType]	= @IdTaskType,
		[Result]		= @Result,
		[IdTaskStatus]	= @IdTaskStatus,
		[TaskReady]		= @TaskReady,
		[IdParent]		= @IdParent,
		[ParentReady]	= @ParentReady,
		[IdPriority]	= @IdPriority,
		[Comment]		= @Comment,	
		[Client]		= @Client,
		[ChangeUser]	= @User,
		[ChangeDate]	= GETDATE()
		
	WHERE [IDTask]	= @IDTask;

BEGIN
	UPDATE [dbo].[tsk$TasksParent]
		SET [TaskParentReady] = @ParentReady,
			[ChangeUser]	= @User,
			[ChangeDate]	= GETDATE()
WHERE IdTaskParent = @IdParent

DELETE FROM [dbo].[tsk$TasksParentCheckPoint] WHERE IdTaskCP = @IDTask

	INSERT INTO [dbo].[tsk$TasksParentCheckPoint] (
			[ParentReadyCP],
			[IDCheckPoint], 
			[IdTaskParentCP],			
			[CheckPointDate],
			[IdTaskCP]
			)
			Values(
			 @ParentReady,
			NEWID(),
			@IdParent,			
			GETDATE(),
			@IdTask
			)
END

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$Tasks_Update;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TasksParent_Delete]    Script Date: 21.03.2023 21:14:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$TasksParent_Delete]
	@IdTaskParent		int,
	@idUserGuid		    UNIQUEIDENTIFIER
AS 
BEGIN
SET NOCOUNT ON
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$TasksParent_Delete;

	DECLARE @User VARCHAR(255);
	SELECT @User = [ShortName]
	FROM  [dbo].[UsersList]
	WHERE [IDUserGuid] = @idUserGuid;

    UPDATE [dbo].[tsk$TasksParent]
	SET [IDRecStatus]	= -1,
        [ChangeUser]	= @User,
        [ChangeDate]	= GETDATE()
    WHERE [IdTaskParent]	= @IdTaskParent;

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$TasksParent_Delete;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TasksParent_Insert]    Script Date: 21.03.2023 21:14:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$TasksParent_Insert]
	
	@TaskParentName varchar(1000),
	@BeginDateParent date,
	@PlanDateParent date = NULL,
	@FactDateParent date = NULL,
	@TaskParentReady int = NULL,
	@CommentParent varchar(1000) = NULL,
	@idUserGuid		UNIQUEIDENTIFIER,
	@IdParentGroup	int = NULL

AS
BEGIN
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$TasksParent_Insert;

	DECLARE @User VARCHAR(255);
    SELECT	@User = [ShortName]
    FROM [dbo].[UsersList]
    WHERE [IDUserGuid] = @idUserGuid;
	
    INSERT INTO [dbo].[tsk$TasksParent]
    (	
		
		[TaskParentName],
		[BeginDateParent],
		[PlanDateParent],
		[FactDateParent],
		[TaskParentReady],
		[CommentParent],
		[IdParentGroup], 
		[IDRecStatus],
        [CreateDate],
        [CreateUser],
		[ChangeDate],
		[ChangeUser]     
    )
    VALUES
    (			
		@TaskParentName,
		@BeginDateParent,
		@PlanDateParent,
		@FactDateParent,
		@TaskParentReady,
		@CommentParent,
		@IdParentGroup,
		0,
        GETDATE(),
        @User,
		NULL,
		NULL   
     );

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$TasksParent_Insert;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TasksParent_Update]    Script Date: 21.03.2023 21:14:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$TasksParent_Update]
	@IdTaskParent INT,
	@TaskParentName varchar(1000),
	@BeginDateParent date,
	@PlanDateParent date = NULL,
	@FactDateParent date = NULL,
	@TaskParentReady INT = NULL,
	@CommentParent varchar(1000) = NULL,
	@idUserGuid		UNIQUEIDENTIFIER,
	@IdParentGroup	INT =NULL

AS 
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$TasksParent_Update;

	DECLARE @User VARCHAR(255);
	SELECT	@User = [ShortName]
	FROM [dbo].[UsersList]
	WHERE [IDUserGuid] = @idUserGuid;

	UPDATE [dbo].[tsk$TasksParent]
	SET 
		[TaskParentName]	= @TaskParentName,
		[BeginDateParent]	= @BeginDateParent,
		[PlanDateParent]	= @PlanDateParent,
		[FactDateParent]	= @FactDateParent,
		[TaskParentReady]	= @TaskParentReady,
		[CommentParent]		= @CommentParent,
		[IdParentGroup]		= @IdParentGroup,
		[ChangeUser]		= @User,
		[ChangeDate]		= GETDATE()
	WHERE [IdTaskParent] = @IdTaskParent;

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$TasksParent_Update;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TasksParentCheckPoint_CP]    Script Date: 21.03.2023 21:14:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[tsk$TasksParentCheckPoint_CP]
AS
	BEGIN
		INSERT INTO [dbo].[tsk$TasksParentCheckPoint](
			[IDCheckPoint],
			[IdTaskCP],
			[IdTaskParentCP],
			[CheckPointDate],
			[ParentReadyCP])
	SELECT	NEWID()					AS [IDCheckPoint],
			T.[IdTask]				AS [IdTaskCP],
			TP.[IdTaskParent]		AS [IdTaskParentCP],
			GETDATE()				AS [CheckPointDate],
			TP.[TaskParentReady]	AS [ParentReadyCP]

	FROM [dbo].[tsk$TasksParentCheckPoint] AS CP
	JOIN [dbo].[tsk$Tasks] AS T WITH ( NOLOCK ) ON CP.[IdTaskCP] = T.[IdTask]
	JOIN [dbo].[tsk$TasksParent] AS TP  WITH ( NOLOCK ) ON CP.[IdTaskParentCP] = TP.[IdTaskParent]
	

END
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TasksStek_Delete]    Script Date: 21.03.2023 21:14:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$TasksStek_Delete]
	@IdTasksStek uniqueidentifier
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE @ErrorMsg nvarchar(4000),
		@ErrorNum int,
		@ErrorSev int,
		@ProcName nvarchar(128),
		@TranFlag int;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$TasksStekDelete;
		DELETE FROM dbo.tsk$TasksStek
		WHERE 
			IdTasksStek = @IdTasksStek 
	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$TasksStekDelete;
	SELECT @ErrorMsg = ERROR_MESSAGE(),
		@ErrorNum = ERROR_NUMBER(),
		@ErrorSev = ERROR_SEVERITY(),
		@ProcName = ISNULL(ERROR_PROCEDURE(), 'name not detected');
	IF @ErrorNum < 50000
		SET @ErrorMsg = @ErrorMsg + ' (Number: ' + CAST(@ErrorNum AS nvarchar(8)) + ', Severity: ' + CAST(@ErrorSev AS nvarchar(8)) + ', Procedure: ' + @ProcName + ')';
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TasksStek_Modify]    Script Date: 21.03.2023 21:14:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$TasksStek_Modify]
	@Action tinyint,
	@IdTasksStek uniqueidentifier OUTPUT,
	@TasksStekName varchar(255),
	@IdTasksStekPriority uniqueidentifier,
	@TasksStekComment varchar(1000),
	@TasksStekDate date
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE @ErrorMsg nvarchar(4000),
		@ErrorNum int,
		@ErrorSev int,
		@ProcName nvarchar(128),
		@TranFlag int;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$TasksStekModify;
	IF @Action = 1 BEGIN
		SET @IdTasksStek = ISNULL(@IdTasksStek, NEWID());
	END;
	IF @Action = 1 BEGIN
		INSERT INTO [dbo].[tsk$TasksStek]
			(	[IdTasksStek], 
				[TasksStekName], 
				[IdTasksStekPriority], 
				[TasksStekComment], 
				[TasksStekDate], 
				[IDRecStatus], 
				[CreateDate], 
				[CreateUser]
		) 
		VALUES 
			(	@IdTasksStek, 
				@TasksStekName, 
				@IdTasksStekPriority, 
				@TasksStekComment, 
				@TasksStekDate, 
				0,
				GETDATE(),
				ORIGINAL_LOGIN() 
		)
	END
	ELSE IF @Action = 2 BEGIN
		UPDATE dbo.tsk$TasksStek SET 
			TasksStekName = @TasksStekName,
			IdTasksStekPriority = @IdTasksStekPriority,
			TasksStekComment = @TasksStekComment,
			TasksStekDate = @TasksStekDate,
			ChangeUser = ORIGINAL_LOGIN(),
			ChangeDate = GETDATE()
		WHERE 
			IdTasksStek = @IdTasksStek 
	END
	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$TasksStekModify;
	SELECT @ErrorMsg = ERROR_MESSAGE(),
		@ErrorNum = ERROR_NUMBER(),
		@ErrorSev = ERROR_SEVERITY(),
		@ProcName = ISNULL(ERROR_PROCEDURE(), 'name not detected');
	IF @ErrorNum < 50000
		SET @ErrorMsg = @ErrorMsg + ' (Number: ' + CAST(@ErrorNum AS nvarchar(8)) + ', Severity: ' + CAST(@ErrorSev AS nvarchar(8)) + ', Procedure: ' + @ProcName + ')';
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TaskStatus_Delete]    Script Date: 21.03.2023 21:15:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$TaskStatus_Delete]
	@IDTaskStatus		UNIQUEIDENTIFIER,
	@idUserGuid		    UNIQUEIDENTIFIER
AS 
BEGIN
SET NOCOUNT ON
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF  @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$TaskStatus_Delete;

	DECLARE @User VARCHAR(255);
	SELECT  @User = [ShortName]
	FROM [dbo].[UsersList]
	WHERE [IDUserGuid] = @idUserGuid;

    UPDATE [dbo].[tsk$TaskStatus]
	SET [IDRecStatus]	 = -1,
        [ChangeUser]	 = @User,
        [ChangeDate]	 = GETDATE()
    WHERE [IDTaskStatus] = @IDTaskStatus;

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$TaskStatus_Delete;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TaskStatus_Insert]    Script Date: 21.03.2023 21:15:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$TaskStatus_Insert]
	@TaskStatusName 	VARCHAR(255),
	@idUserGuid		    UNIQUEIDENTIFIER
AS
BEGIN
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF  @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$TaskStatus_Insert;

	DECLARE @User VARCHAR(255);
    SELECT  @User = [ShortName]
    FROM [dbo].[UsersList]
    WHERE [IDUserGuid] = @idUserGuid;

    INSERT INTO [dbo].[tsk$TaskStatus]
    (	[IDTaskStatus],
		[TaskStatusName],
        [IDRecStatus],
        [CreateDate],
        [CreateUser],
		[ChangeDate],
		[ChangeUser]     
    )
    VALUES
    (	NEWID(),
		@TaskStatusName,
        0,
        GETDATE(),
        @User,
		NULL,
		NULL
     );

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$TaskStatus_Insert;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TaskStatus_Update]    Script Date: 21.03.2023 21:15:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$TaskStatus_Update]
	@IDTaskStatus			UNIQUEIDENTIFIER,
	@TaskStatusName			VARCHAR(255),
	@idUserGuid			    UNIQUEIDENTIFIER
AS 
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$TaskStatus_Update;

	DECLARE @User VARCHAR(255);
	SELECT @User = [ShortName]
	FROM [dbo].[UsersList]
	WHERE [IDUserGuid] = @idUserGuid;

	UPDATE [dbo].[tsk$TaskStatus]
	SET [TaskStatusName]	= @TaskStatusName,
		[ChangeUser]		= @User,
		[ChangeDate]		= GETDATE()
	WHERE [IDTaskStatus]	= @IDTaskStatus;

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$TaskStatus_Update;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TaskType_Delete]    Script Date: 21.03.2023 21:15:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$TaskType_Delete]
	@IDTaskType			UNIQUEIDENTIFIER,
	@idUserGuid		    UNIQUEIDENTIFIER
AS 
BEGIN
SET NOCOUNT ON
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF  @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$TaskType_Delete;

	DECLARE @User VARCHAR(255);
	SELECT  @User = [ShortName]
	FROM [dbo].[UsersList]
	WHERE [IDUserGuid] = @idUserGuid;

    UPDATE [dbo].[tsk$TaskType]
	SET [IDRecStatus]	= -1,
        [ChangeUser]	= @User,
        [ChangeDate]	= GETDATE()
    WHERE [IDTaskType]	= @IDTaskType;

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$TaskType_Delete;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TaskType_Insert]    Script Date: 21.03.2023 21:15:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$TaskType_Insert]
	@TaskTypeName		VARCHAR(255),
	@IdTypeGroup		INT,
	@idUserGuid		    UNIQUEIDENTIFIER
AS
BEGIN
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF  @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$TaskType_Insert;

	DECLARE @User VARCHAR(255);
    SELECT  @User = [ShortName]
    FROM [dbo].[UsersList]
    WHERE [IDUserGuid] = @idUserGuid;

    INSERT INTO [dbo].[tsk$TaskType]
    (	[IDTaskType],
		[TaskTypeName],
		[IdTypeGroup],
        [IDRecStatus],
        [CreateDate],
        [CreateUser],
		[ChangeDate],
		[ChangeUser]     
    )
    VALUES
    (	NEWID(),
		@TaskTypeName,
		@IdTypeGroup,
        0,
        GETDATE(),
        @User,
		NULL,
		NULL
     );

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$TaskType_Insert;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

USE [dbadmin]
GO

/****** Object:  StoredProcedure [dbo].[tsk$TaskType_Update]    Script Date: 21.03.2023 21:16:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[tsk$TaskType_Update]
	@IDTaskType			UNIQUEIDENTIFIER,
	@TaskTypeName		VARCHAR(255),
	@IdTypeGroup		INT,
	@idUserGuid			UNIQUEIDENTIFIER
AS 
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE @ErrorMsg VARCHAR(4000);
	DECLARE @ErrorNum INT;
	DECLARE @ErrorSev INT;
	DECLARE @TranFlag INT;
	SET @TranFlag = @@TRANCOUNT;
	IF  @TranFlag = 0
		BEGIN TRAN;
	ELSE
		SAVE TRAN sv_tsk$TaskType_Update;

	DECLARE @User VARCHAR(255);
	SELECT  @User = [ShortName]
	FROM [dbo].[UsersList]
	WHERE [IDUserGuid] = @idUserGuid;

	UPDATE [dbo].[tsk$TaskType]
	SET [TaskTypeName]	= @TaskTypeName,
		[IdTypeGroup]	= @IdTypeGroup,
		[ChangeUser]	= @User,
		[ChangeDate]	= GETDATE()
	WHERE [IDTaskType]  = @IDTaskType;

	IF @TranFlag = 0 COMMIT TRAN;
	RETURN 0;
END TRY
BEGIN CATCH
	IF @TranFlag = 0
		ROLLBACK TRAN;
	ELSE IF XACT_STATE() != -1
		ROLLBACK TRAN sv_tsk$TaskType_Update;
	
	SELECT	@ErrorMsg = ERROR_MESSAGE(),
			@ErrorNum = ERROR_NUMBER(),
			@ErrorSev = ERROR_SEVERITY();
	IF @ErrorNum < 50000
	BEGIN
		SET @ErrorMsg = @ErrorMsg + '(' + CAST(@ErrorNum AS VARCHAR(8)) + ', ' + CAST(@ErrorSev AS VARCHAR(8)) + ')';
	END;
	RAISERROR (@ErrorMsg, 16, 1);
	RETURN -1;
END CATCH
END;
GO

