USE [BlogPlatformDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =================| SP_Add_Comment |=================--
-- ======================================================

-- Beschreibung: Überprüft, ob ein Benutzer einen Blog-Post 
--               gelesen hat, bevor ein Kommentar hinzugefügt wird.
--               Zusätzlich wird überprüft, ob der Kommentartext 
--               nicht leer ist, die zulässige Länge hat und ob 
--               ein gültiger parent_comment_id vorliegt.

-- Parameter:    
--   - @account_id INT				: Die ID des Benutzers.
--   - @post_id INT					: Die ID des Blog-Posts.
--   - @comment_text NVARCHAR(MAX)	: Der Kommentartext.
--   - @parent_comment_id INT		: Die ID des übergeordneten Kommentars (optional).
--	 - @ResultMessage NVARCHAR(255) : Gibt eine Nachricht zurück, die den Erfolg oder Misserfolg der Aktion beschreibt.

-- Rückgabewert: Keine. Die Prozedur gibt jedoch eine Nachricht über den 
--               Erfolg oder Misserfolg der Aktion zurück, die im 
--               @ResultMessage-Parameter gespeichert wird.

-- ========================================================

CREATE OR ALTER PROCEDURE [dbo].[SP_Add_Comment]

	@AccountId INT,
	@PostId INT,
	@CommentText NVARCHAR(MAX),
	@ParentCommentId INT = NULL,
	@ResultMessage NVARCHAR(255) OUTPUT

AS
BEGIN
	SET NOCOUNT ON;

	-- TRY-Block für Fehleranfälligen Code
	BEGIN TRY

		-- Überprüfen, ob der Blog-Post existiert und nicht gelöscht ist
		IF EXISTS (SELECT 1 FROM dbo.BlogPosts WHERE post_id = @PostId AND is_deleted = 0)
		BEGIN
			-- Maximale Länge des Kommentars definieren
			DECLARE @MaxCommentLength INT = 250;

			-- Überprüfen, ob der Benutzer den Blog-Post gelesen hat
			IF dbo.SF_Has_User_Read_Post(@AccountId, @PostId) = 1
			BEGIN

				-- Überprüfen, ob der Kommentartext leer ist
				IF LEN(LTRIM(RTRIM(@CommentText))) = 0
				BEGIN
					SET @ResultMessage = 'Der Kommentartext darf nicht leer sein.';
				END -- Überprüfen, ob der Kommentartext leer ist END

				-- Überprüfen, ob der Kommentartext die zulässige Länge hat
				ELSE IF LEN(@CommentText) > @MaxCommentLength
				BEGIN
					SET @ResultMessage = 'Der Kommentartext überschreitet die zulässige Länge von ' + CAST(@MaxCommentLength AS NVARCHAR) + ' Zeichen.';
				END -- Überprüfen, ob der Kommentartext die zulässige Länge hat END
				ELSE
				BEGIN
					-- Überprüfen, ob parent_comment_id gültig ist, falls angegeben
					IF @ParentCommentId IS NULL OR EXISTS (SELECT 1 FROM dbo.Comments WHERE comment_id = @ParentCommentId)
					BEGIN
						INSERT INTO dbo.Comments (account_id, post_id, comment_text, created_at, parent_comment_id)
						VALUES(@AccountId, @PostId, @CommentText, GETDATE(), @ParentCommentId)

						SET @ResultMessage = 'Der Kommentar wurde erfolgreich hinzugefügt.';
					END -- Überprüfen, ob parent_comment_id gültig ist END
					ELSE
					BEGIN
						SET @ResultMessage = 'Ungültige parent_comment_id. Kommentar konnte nicht hinzugefügt werden.';
					END  -- Ungültige parent_comment_id END
				END	
			END
			ELSE
			BEGIN
				SET @ResultMessage = 'Sie können keinen Kommentar hinzufügen, da Sie diesen Blog-Post nicht gelesen haben.';
			END -- Überprüfen, ob der Benutzer den Blog-Post gelesen hat END
		END 
		ELSE
		BEGIN
			SET @ResultMessage = 'Der Blog-Post existiert nicht oder wurde gelöscht.';
		END -- Überprüfen, ob der Blog-Post existiert und nicht gelöscht ist END

	END TRY
	BEGIN CATCH
		-- Fehlerbehandlung im CATCH-Block
		SET @ResultMessage = 'Ein Fehler ist aufgetreten: ' + ERROR_MESSAGE();
		THROW;
	END CATCH

END
GO
