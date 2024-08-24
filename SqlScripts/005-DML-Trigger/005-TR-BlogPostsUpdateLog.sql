USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ============| TR_BlogPosts_Update_Log |============= --
-- ====================================================

-- Description:   Dieser Trigger protokolliert Updates an den 
--                BlogPosts, einschließlich Änderungen an den 
--                Feldern post_title, post_content, is_premium und 
--                category_id. Einträge werden in der PostUpdateLog 
--                Tabelle gespeichert.

-- =====================================================

CREATE TRIGGER TR_BlogPosts_Update_Log
   ON  dbo.BlogPosts
   FOR UPDATE
AS 
BEGIN
	
	SET NOCOUNT ON;

	-- Überprüfen, ob eine der relevanten Spalten aktualisiert wurde
	IF UPDATE(post_title)
		OR UPDATE(post_content)
		OR UPDATE(is_premium)
		OR UPDATE(category_id)
	BEGIN

		-- Aktualisiert die update_at-Spalte in BlogPosts mit dem aktuellen Datum und der Uhrzeit
		UPDATE [dbo].[BlogPosts]
		SET update_at = GETDATE()
		FROM inserted
		WHERE dbo.BlogPosts.post_id = inserted.post_id;


		INSERT INTO dbo.PostUpdateLog
			(
			action_type,
			post_id,
			updated_at,
			updated_by,
			log_description
			)

		SELECT
			'UPDATE',
			inserted.post_id,
			GETDATE(),
			ORIGINAL_LOGIN(),
			CASE
				WHEN deleted.post_title <> inserted.post_title THEN 'Title updated'				-- Protokolliert eine Titeländerung
				WHEN deleted.post_content <> inserted.post_content THEN 'Content updated'		-- Protokolliert eine Inhaltsänderung
				WHEN deleted.is_premium <> inserted.is_premium THEN 'Premium status updated'	-- Protokolliert eine Änderung des Premium-Status
				WHEN deleted.category_id <> inserted.category_id THEN 'Category updated'		-- Protokolliert eine Kategoriewechsel
				ELSE 'Multiple updates'															-- Protokolliert, wenn mehrere Felder gleichzeitig geändert wurden
			END

		FROM
			inserted
		JOIN
			deleted 
			ON inserted.post_id = deleted.post_id; -- Stellt sicher, dass die alte und neue Version des Posts verglichen werden

	END
END
GO
