USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================

-- Beschreibung: Diese Prozedur erstellt ein Backup einer spezifischen 
--               Datenbank und speichert die Backup-Datei im angegebenen Verzeichnis.
--
-- Parameter:
--   @DatabaseName NVARCHAR(256)         : Der Name der zu sichernden Datenbank.
--   @Path NVARCHAR(256)                 : Der Pfad, in dem die Backup-Datei gespeichert werden soll.
--   @ResultMessage NVARCHAR(MAX) OUTPUT : Gibt eine Nachricht zurück, die den Erfolg oder Fehler der Backup-Operation beschreibt.

-- =============================================

CREATE OR ALTER PROCEDURE dbo.SP_Backup_Database

    @dbname NVARCHAR(256),				-- Name der Datenbank, die gesichert werden soll
    @path NVARCHAR(256),				-- Pfad für die Sicherungsdatei
    @ResultMessage NVARCHAR(MAX) OUTPUT -- Ausgabe für Fehlermeldungen etc.
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @BackupFileName NVARCHAR(50);		-- Name der Sicherungsdatei
    DECLARE @fullDBBackupName NVARCHAR(256);	-- Vollständiger Sicherungspfad mit Dateiname

    BEGIN TRY

        -- Prüfen, ob der angegebene Pfad existiert
        DECLARE @tb_fileexist TABLE (FileExists BIT, FileIsDir BIT, ParentDirExists BIT);
        INSERT INTO @tb_fileexist EXEC master.dbo.xp_fileexist @path;

        IF (SELECT FileExists FROM @tb_fileexist) = 1 -- Der Pfad ist eine Datei, was ein Fehler ist
        BEGIN
            SET @ResultMessage = 'Der angegebene Pfad ist eine Datei, kein Verzeichnis.';
            THROW 50000, @ResultMessage, 1;
        END
        ELSE IF ((SELECT FileIsDir FROM @tb_fileexist) = 0) 
			AND ((SELECT FileExists FROM @tb_fileexist) = 0) 
        BEGIN
            -- Ordner existiert nicht, erstellen
            IF (@path NOT LIKE '[A-Z]:\%')
            BEGIN
                SET @ResultMessage = 'Der angegebene Pfad ist ungültig.';
                THROW 50001, @ResultMessage, 1;
            END
            ELSE
            BEGIN
                EXEC master.sys.xp_create_subdir @path;
            END
        END

        -- Backup-Dateinamen erstellen
        SET @BackupFileName = @dbname + '-' + CONVERT(NVARCHAR, GETDATE(), 112) + '.bak';
        SET @fullDBBackupName = @path + @BackupFileName;

        -- Datenbank sichern
        BACKUP DATABASE @dbname TO DISK = @fullDBBackupName;

        -- Erfolgsnachricht
        SET @ResultMessage = 'Datenbank ' + @dbname + ' wurde erfolgreich gesichert.';
    END TRY
    BEGIN CATCH
        -- Fehlerbehandlung
        SET @ResultMessage = 
            'Fehler beim Sichern der Datenbank: ' + ERROR_MESSAGE() + ' Fehler Nr. ' + CONVERT(VARCHAR, ERROR_NUMBER())
            + ' Prozedur: ' + ERROR_PROCEDURE() + ' Zeile Nr.: ' + CONVERT(VARCHAR, ERROR_LINE());
        THROW;
    END CATCH
END
GO

