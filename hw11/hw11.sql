--Создание базы

CREATE DATABASE dbadmin
GO

--Создание таблиц

USE [dbadmin]
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

-- Индексы
USE [dbadmin]
GO
CREATE INDEX idx_Users
ON [dbo].[UsersList] (LastName)
GO

USE [dbadmin]
GO
CREATE INDEX idx_Parent
ON [dbo].[tsk$TasksParent] (TaskParentName)
go

USE [dbadmin]
GO
CREATE INDEX idx_Task
ON [dbo].[tsk$Tasks] (TaskName)
go