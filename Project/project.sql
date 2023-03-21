USE [dbadmin]
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

    INSERT INTO [dbo].[tsk$Tasks](	
		[IdTaskType],[TaskName],[IdSmartTask],[BeginDate],[PlanDate],[FactDate],[IdAuthor],
		[IdImplementor],[IdCustomer],[IdModule],[Result],[IdTaskStatus],[TaskReady],[IdParent],
		[ParentReady],[IdPriority],[Comment],[IDRecStatus],[CreateDate], 
		[CreateUser],[ChangeDate],[ChangeUser])
    VALUES(	
		@IDTaskType,@TaskName,@IdSmartTask,@BeginDate,@PlanDate,@FactDate,@idUserGuid,@IdImplementor,
		@IdCustomer,@IdModule,@Result,@IdTaskStatus,@TaskReady,@IdParent,@ParentReady,@IdPriority,
		@Comment,0, GETDATE(), @User,NULL,NULL);

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


