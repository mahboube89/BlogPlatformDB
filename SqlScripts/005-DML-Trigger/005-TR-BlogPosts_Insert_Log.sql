USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ============| TR_BlogPosts_Insert_Log |============= --
-- =======================================================

-- Description:	Dieser Trigger protokolliert alle Einfügungen
--				in der BlogPosts-Tabelle. Sobald ein neuer Blog-Post
--				erstellt wird, werden die Details des neuen Beitrags
--				zusammen mit dem Erstellungszeitpunkt und dem Benutzer,
--				der den Beitrag erstellt hat, in einer Log-Tabelle gespeichert.

-- =======================================================

CREATE TRIGGER TR_BlogPosts_Insert_Log 
   ON dbo.BlogPosts
   FOR INSERT
AS 
BEGIN

	SET NOCOUNT ON;

	-- Fügt einen Log-Eintrag in die PostUpdateLog-Tabelle ein, wenn ein neuer Blogpost erstellt wird
	INSERT INTO dbo.PostUpdateLog
		 (
		 action_type,
		 post_id,
		 updated_at,
		 updated_by,
		 log_description
		 )
	SELECT
		'INSERT',
		inserted.post_id,
		GETDATE(),
		ORIGINAL_LOGIN(),
		'New post created'

	FROM
		inserted;
END
GO
