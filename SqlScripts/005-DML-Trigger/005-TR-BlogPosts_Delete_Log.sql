USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ============| TR_BlogPosts_Delete_Log |============= --
-- ======================================================

-- Description:	Trigger für Soft Deletes: Dieser Trigger 
--				markiert einen Blog-Post als gelöscht (is_deleted = 1),
--				anstatt ihn vollständig aus der Datenbank zu entfernen.
--				Zusätzlich wird ein Log-Eintrag in der PostUpdateLog-Tabelle
--				erstellt, der Informationen über den gelöschten Post, 
--				den Zeitpunkt der Löschung und den Benutzer, der die
--				Löschung durchgeführt hat, speichert.

-- ======================================================

CREATE OR ALTER TRIGGER TR_BlogPosts_Delete_Log
   ON dbo.BlogPosts
   INSTEAD OF DELETE -- Verhindert das tatsächliche Löschen und führt stattdessen eine alternative Aktion aus
AS 
BEGIN

	SET NOCOUNT ON;

	-- Setzt das is_deleted-Flag des Blogposts auf 1, um ihn als gelöscht zu markieren
    UPDATE BlogPosts
    SET 
		is_deleted = 1
    WHERE 
		post_id 
		IN (SELECT post_id FROM deleted);


    -- Fügt einen Eintrag in der PostUpdateLog-Tabelle hinzu, um das Löschen des Posts zu protokollieren
	INSERT INTO dbo.PostUpdateLog
		 (
		 action_type,
		 post_id,
		 updated_at,
		 updated_by,
		 log_description
		 )
	SELECT
		'DELETE',
		deleted.post_id,
		GETDATE(),
		ORIGINAL_LOGIN(),
		'Post marked as deleted'

	FROM
		deleted;

END
GO
