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