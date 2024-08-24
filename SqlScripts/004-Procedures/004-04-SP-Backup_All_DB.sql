USE [BlogPlatformDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ============| SP_Backup_All_DB |============ --
-- =============================================
-- Beschreibung: Erstellt eine vollständige Sicherung (Backup) aller Datenbanken auf dem SQL Server. 
--               Die Backups werden in einem angegebenen Verzeichnis gespeichert.
--
-- Parameter:    
--   - @BackupDirectory NVARCHAR(255): Das Verzeichnis, in dem die Datenbank-Backups gespeichert werden sollen.
--
-- Rückgabewert: Keiner (die Prozedur erstellt die Backups und speichert sie im angegebenen Verzeichnis).
-- =============================================

CREATE OR ALTER PROCEDURE dbo.SP_Backup_All_DB

	@Path NVARCHAR(256),				-- Pfad für die Backup-Dateien
	@ResultMessage NVARCHAR(MAX) OUTPUT -- Rückmeldung über den Erfolg oder Fehler
AS
BEGIN
	SET NOCOUNT ON;

	-- Variablen-Deklaration
	DECLARE @dbname NVARCHAR(30);				-- Datenbankname
	DECLARE @BackupFileName NVARCHAR(50);		-- Backup-Dateiname
	DECLARE @FullDBBackupName NVARCHAR(256);	-- Vollständiger Dateipfad für das Backup
	DECLARE @msg NVARCHAR(100);					-- Fehlermeldung

	BEGIN TRY
	
		-- Prüfen, ob der Pfad existiert, wenn nicht, Ordner erstellen
		DECLARE @tb_fileexist TABLE (FileExists BIT, FileIsDir BIT, ParentDirExists BIT);

		INSERT INTO @tb_fileexist EXEC master.dbo.xp_fileexist @Path;

		 -- Prüfen, ob der Pfad eine Datei ist
		IF (SELECT FileIsDir FROM @tb_fileexist) = 0 AND (SELECT FileExists FROM @tb_fileexist) = 0
		
		BEGIN
			SET @ResultMessage = 'Der angegebene Pfad ist eine Datei, kein Verzeichnis.';
			THROW 50000, @ResultMessage, 1;
		END
		ELSE IF ((SELECT FileIsDir FROM @tb_fileexist) = 0) 
			AND ((SELECT FileExists FROM @tb_fileexist) = 0) 
		BEGIN -- Ordner existiert nicht und ist keine Datei

			-- Prüfen, ob der Pfad korrekt formatiert ist
			IF (@Path NOT LIKE '[A-Z]:\%')
			BEGIN
				SET @ResultMessage = 'Der angegebene Pfad ist ungültig.';
				THROW 50001, @ResultMessage, 1;
			END
			ELSE -- Prüfen, ob das Laufwerk existiert
			BEGIN
			
				DECLARE @driveTable TABLE (DRIVE CHAR(1), MBfrei INT);

				INSERT INTO @driveTable EXEC master.sys.xp_fixeddrives; -- Laufwerke ohne Wechseldatenträger

				DECLARE @Drive CHAR(1) = LEFT(@Path, 1);				-- Laufwerk extrahieren

				IF @Drive NOT IN (SELECT DRIVE FROM @driveTable)
				BEGIN
					SET @msg =  'Das Laufwerk '  + @Drive + ' existiert nicht.';
					THROW 50102,  @msg, 1;
				END
				ELSE -- Laufwerk existiert, Ordner erstellen
				BEGIN	
					EXEC master.sys.xp_create_subdir @Path;
				END
			END
		END

		-- Alle Datenbanken sichern, außer den Systemdatenbanken
		DECLARE db_cursor CURSOR FOR 
			SELECT name 
			FROM MASTER.dbo.sysdatabases
			WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb', 'DWConfiguration', 'DWDiagnostics', 'DWQueue')
			ORDER BY name;

		OPEN db_cursor;
			FETCH NEXT FROM db_cursor INTO @dbname;
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @BackupFileName = @dbname + '-' + FORMAT(GETDATE(), 'yyyyMMddHHmmss') + '.bak'; -- Zeitstempel direkt in der Prozedur generieren
				SET @FullDBBackupName = @Path + @BackupFileName;
				BACKUP DATABASE @dbname TO DISK = @FullDBBackupName;

				FETCH NEXT FROM db_cursor INTO @dbname;
			END
		CLOSE db_cursor;
		DEALLOCATE db_cursor;

		SET @ResultMessage = 'Backup erfolgreich abgeschlossen.';
	END TRY
	BEGIN CATCH
	
		SET @ResultMessage = 
			'Fehler: ' + ERROR_MESSAGE() + ' | Fehlernummer: ' + CONVERT(VARCHAR, ERROR_NUMBER()) + 
			' | Prozedur: '  + ERROR_PROCEDURE() + ' | Zeile: ' + CONVERT(VARCHAR,  ERROR_LINE());

		THROW;

	END CATCH;  			
END
GO
