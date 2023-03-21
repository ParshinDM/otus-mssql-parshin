CREATE ASSEMBLY xp_hello from 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2017\MSSQL\Binn\xp_hello.dll' WITH PERMISSION_SET = SAFE
GO

--DROP ASSEMBLY xp_hello

SELECT * FROM sys.assemblies
GO

declare @txt varchar(33)
exec xp_hello @txt OUTPUT
select @txt AS OUTPUT_Parameter
go