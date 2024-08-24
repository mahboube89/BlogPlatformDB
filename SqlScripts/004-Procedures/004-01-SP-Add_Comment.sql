USE [BlogPlatformDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =================| SP_Add_Comment |=================--
-- ======================================================

-- Beschreibung: �berpr�ft, ob ein Benutzer einen Blog-Post 
--               gelesen hat, bevor ein Kommentar hinzugef�gt wird.
--               Zus�tzlich wird �berpr�ft, ob der Kommentartext 
--               nicht leer ist, die zul�ssige L�nge hat und ob 
--               ein g�ltiger parent_comment_id vorliegt.

-- Parameter:    
--   - @account_id INT				: Die ID des Benutzers.
--   - @post_id INT					: Die ID des Blog-Posts.
--   - @comment_text NVARCHAR(MAX)	: Der Kommentartext.
--   - @parent_comment_id INT		: Die ID des �bergeordneten Kommentars (optional).
--	 - @ResultMessage NVARCHAR(255) : Gibt eine Nachricht zur�ck, die den Erfolg oder Misserfolg der Aktion beschreibt.

-- R�ckgabewert: Keine. Die Prozedur gibt jedoch eine Nachricht �ber den 
--               Erfolg oder Misserfolg der Aktion zur�ck, die im 
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

	-- TRY-Block f�r Fehleranf�lligen Code
	BEGIN TRY

		-- �berpr�fen, ob der Blog-Post existiert und nicht gel�scht ist
		IF EXISTS (SELECT 1 FROM dbo.BlogPosts WHERE post_id = @PostId AND is_deleted = 0)
		BEGIN
			-- Maximale L�nge des Kommentars definieren
			DECLARE @MaxCommentLength INT = 250;

			-- �berpr�fen, ob der Benutzer den Blog-Post gelesen hat
			IF dbo.SF_Has_User_Read_Post(@AccountId, @PostId) = 1
			BEGIN

				-- �berpr�fen, ob der Kommentartext leer ist
				IF LEN(LTRIM(RTRIM(@CommentText))) = 0
				BEGIN
					SET @ResultMessage = 'Der Kommentartext darf nicht leer sein.';
				END -- �berpr�fen, ob der Kommentartext leer ist END

				-- �berpr�fen, ob der Kommentartext die zul�ssige L�nge hat
				ELSE IF LEN(@CommentText) > @MaxCommentLength
				BEGIN
					SET @ResultMessage = 'Der Kommentartext �berschreitet die zul�ssige L�nge von ' + CAST(@MaxCommentLength AS NVARCHAR) + ' Zeichen.';
				END -- �berpr�fen, ob der Kommentartext die zul�ssige L�nge hat END
				ELSE
				BEGIN
					-- �berpr�fen, ob parent_comment_id g�ltig ist, falls angegeben
					IF @ParentCommentId IS NULL OR EXISTS (SELECT 1 FROM dbo.Comments WHERE comment_id = @ParentCommentId)
					BEGIN
						INSERT INTO dbo.Comments (account_id, post_id, comment_text, created_at, parent_comment_id)
						VALUES(@AccountId, @PostId, @CommentText, GETDATE(), @ParentCommentId)

						SET @ResultMessage = 'Der Kommentar wurde erfolgreich hinzugef�gt.';
					END -- �berpr�fen, ob parent_comment_id g�ltig ist END
					ELSE
					BEGIN
						SET @ResultMessage = 'Ung�ltige parent_comment_id. Kommentar konnte nicht hinzugef�gt werden.';
					END  -- Ung�ltige parent_comment_id END
				END	
			END
			ELSE
			BEGIN
				SET @ResultMessage = 'Sie k�nnen keinen Kommentar hinzuf�gen, da Sie diesen Blog-Post nicht gelesen haben.';
			END -- �berpr�fen, ob der Benutzer den Blog-Post gelesen hat END
		END 
		ELSE
		BEGIN
			SET @ResultMessage = 'Der Blog-Post existiert nicht oder wurde gel�scht.';
		END -- �berpr�fen, ob der Blog-Post existiert und nicht gel�scht ist END

	END TRY
	BEGIN CATCH
		-- Fehlerbehandlung im CATCH-Block
		SET @ResultMessage = 'Ein Fehler ist aufgetreten: ' + ERROR_MESSAGE();
		THROW;
	END CATCH

END
GO
