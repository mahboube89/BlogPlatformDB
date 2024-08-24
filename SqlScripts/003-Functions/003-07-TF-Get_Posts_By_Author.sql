USE [BlogPlatformDB]
GO

/****** Object:  UserDefinedFunction [dbo].[TF_Get_Posts_By_Author]    Script Date: 8/12/2024 5:21:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ==============| TF_Get_Posts_By_Author |==============--
-- ========================================================

-- Description:	Diese Funktion gibt eine Tabelle mit den Posts eines bestimmten Autors zurück.
--				Wenn der Autor keine Posts hat, gibt die Funktion eine Zeile mit den Autorendetails 
--				und Standardwerten für die Post-Informationen zurück (post_id = 0, post_title = 'No Posts').

-- Parameter:
--   - @AuthorId			: Die eindeutige ID des Autors, dessen Posts abgerufen werden sollen.

-- Rückgabewert:
--   Eine Tabelle mit den folgenden Spalten:
--     - author_id			: Die eindeutige ID des Autors.
--     - author_username	: Der Benutzername des Autors.
--     - post_id			: Die ID des Posts (oder 0, wenn keine Posts vorhanden sind).
--     - post_title			: Der Titel des Posts (oder 'No Posts', wenn keine Posts vorhanden sind).
--     - create_at			: Das Erstellungsdatum des Posts (NULL, wenn keine Posts vorhanden sind).

-- =============================================

CREATE OR ALTER   FUNCTION [dbo].[TF_Get_Posts_By_Author](@AuthorId INT)
RETURNS TABLE 
AS
RETURN 
(	
	SELECT
		AuthorProfile.author_id,
		UserAccount.username AS author_username,
		ISNULL(BlogPosts.post_id, 0) AS post_id,				-- Setzt den Wert auf 0, wenn kein Post vorhanden ist
        ISNULL(BlogPosts.post_title, 'No Posts') AS post_title,	-- Setzt den Wert auf 'No Posts', wenn kein Post vorhanden ist
		BlogPosts.create_at										-- Bleibt NULL, wenn kein Post vorhanden ist
	
	FROM
        dbo.AuthorProfile 
    INNER JOIN
        dbo.UserAccount  
		ON AuthorProfile.account_id = UserAccount.account_id
    LEFT JOIN
        dbo.BlogPosts  
		ON AuthorProfile.author_id = BlogPosts.author_id

    WHERE 
        AuthorProfile.author_id = @AuthorId
		AND (BlogPosts.is_deleted = 0 OR BlogPosts.is_deleted IS NULL) -- Nur nicht gelöschte Posts berücksichtigen
);
GO


