USE BlogPlatformDB
GO


DECLARE @ResultMessage NVARCHAR(MAX);

EXEC dbo.SP_Backup_Database 
    @dbname = 'BlogPlatformDB', 
    @path = 'C:\Backups\', 
    @ResultMessage = @ResultMessage OUTPUT;

PRINT @ResultMessage;
