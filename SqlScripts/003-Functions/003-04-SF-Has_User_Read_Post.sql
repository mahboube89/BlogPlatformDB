USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--==========| SF_Has_User_Read_Post |==========--
-- ==============================================
-- Beschreibung:	Diese Funktion überprüft, ob ein Benutzer 
--					einen bestimmten Blog-Post gelesen hat.

-- Parameter:    
--   - @AccountId INT	: Die ID des Benutzerkontos.
--   - @PostId INT		: Die ID des Blog-Posts.

-- Rückgabewert: 
--   - BIT				: Gibt 1 zurück, wenn der Benutzer den Blog-Post gelesen hat,
--							andernfalls 0.
-- ==============================================

CREATE OR ALTER FUNCTION dbo.SF_Has_User_Read_Post
(
	@AccountId INT,
	@PostId INT
)
RETURNS BIT
AS
BEGIN
	-- Deklarieren der Rückgabevariable
	DECLARE @HasRead BIT;

	-- Überprüfen, ob ein Eintrag in der ReadPosts-Tabelle existiert,
	-- der anzeigt, dass der Benutzer den Blog-Post gelesen hat
	IF EXISTS (SELECT 1 FROM dbo.ReadPosts WHERE ReadPosts.account_id = @AccountId AND ReadPosts.post_id = @PostId)
	BEGIN
		SET @HasRead = 1;	-- Benutzer hat den Blog-Post gelesen
	END
	ELSE
	BEGIN
		SET @HasRead = 0;	-- Benutzer hat den Blog-Post nicht gelesen
	END

	
	RETURN @HasRead			-- Rückgabe des Ergebnisses der Funktion
END
GO

