USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ============| TR_BlogPosts_Delete_Log |============= --
-- ======================================================

-- Description:	Trigger f�r Soft Deletes: Dieser Trigger 
--				markiert einen Blog-Post als gel�scht (is_deleted = 1),
--				anstatt ihn vollst�ndig aus der Datenbank zu entfernen.
--				Zus�tzlich wird ein Log-Eintrag in der PostUpdateLog-Tabelle
--				erstellt, der Informationen �ber den gel�schten Post, 
--				den Zeitpunkt der L�schung und den Benutzer, der die
--				L�schung durchgef�hrt hat, speichert.

-- ======================================================

CREATE OR ALTER TRIGGER TR_BlogPosts_Delete_Log
   ON dbo.BlogPosts
   INSTEAD OF DELETE -- Verhindert das tats�chliche L�schen und f�hrt stattdessen eine alternative Aktion aus
AS 
BEGIN

	SET NOCOUNT ON;

	-- Setzt das is_deleted-Flag des Blogposts auf 1, um ihn als gel�scht zu markieren
    UPDATE BlogPosts
    SET 
		is_deleted = 1
    WHERE 
		post_id 
		IN (SELECT post_id FROM deleted);


    -- F�gt einen Eintrag in der PostUpdateLog-Tabelle hinzu, um das L�schen des Posts zu protokollieren
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
