USE BlogPlatformDB
GO
-- ============| TEST | SP_Backup_All_DB |============ --


--====================================================
-- Testfall 1: Erfolgreicher Backup-Prozess

-- Erwartetes Ergebnis: Die Datenbank wird erfolgreich gesichert und eine 
--                      entsprechende Erfolgsmeldung wird zur�ckgegeben.
--====================================================

DECLARE @Result NVARCHAR(MAX);
EXEC dbo.SP_Backup_All_DB @Path = 'C:\Backup\', @ResultMessage = @Result OUTPUT;
PRINT @Result;



--====================================================
-- Testfall 2: Ung�ltiger Pfad

-- Erwartetes Ergebnis: Eine Fehlermeldung wird zur�ckgegeben, die besagt, 
--                      dass der angegebene Pfad ung�ltig ist.
--====================================================

--DECLARE @Result NVARCHAR(MAX);
--EXEC dbo.SP_Backup_All_DB @Path = 'G:\Backup\', @ResultMessage = @Result OUTPUT;
--PRINT @Result;



--====================================================
-- Testfall 3: Der Pfad ist eine Datei

-- Erwartetes Ergebnis: Eine Fehlermeldung wird zur�ckgegeben, die besagt, 
--                      dass der angegebene Pfad eine Datei und kein Verzeichnis ist.
--====================================================

--DECLARE @Result NVARCHAR(MAX);
--EXEC dbo.SP_Backup_All_DB @Path = 'C:\ABC.txt', @ResultMessage = @Result OUTPUT;
--PRINT @Result;

