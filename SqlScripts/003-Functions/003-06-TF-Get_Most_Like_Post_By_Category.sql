USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ==============| TF_Get_Most_Like_Post_By_Category |==============--
-- ===================================================================
-- Description:	Diese Funktion gibt den Blog-Post mit den 
--              meisten Likes innerhalb einer bestimmten 
--              Kategorie zurück. Die Funktion liefert 
--              Informationen wie den Post-Titel, den Inhalt, 
--              den Autorennamen, das Erstellungsdatum, den 
--              Premium-Status und die Anzahl der Likes.
-- Parameter:    
--   - @CategoryId INT: Die ID der Kategorie, für die der 
--                      beliebteste Post abgerufen werden soll.

-- Rückgabewert: Ein Tabellenwert, der den Post mit den meisten 
--               Likes innerhalb der angegebenen Kategorie enthält.

-- ===================================================================


CREATE OR ALTER FUNCTION dbo.TF_Get_Most_Like_Post_By_Category( @CategoryId INT )
RETURNS TABLE 
AS
RETURN 
(
	SELECT TOP 1 
		dbo.Categories.category_name,												-- Kategorie-Name
		COUNT(DISTINCT dbo.Likes.like_id)  AS like_count,							-- Anzahl der Likes
		dbo.BlogPosts.post_id,														-- Blog-Post-ID
		dbo.BlogPosts.post_title,													-- Blog-Post-Titel
		dbo.BlogPosts.post_content,													-- Blog-Post-Inhalt
		dbo.BlogPosts.is_premium,													-- Premium-Status
		dbo.BlogPosts.create_at,													-- Erstellungsdatum
		dbo.UserProfile.first_name + ' ' + dbo.UserProfile.last_name AS author_name -- Autorenname
        
	FROM            
		dbo.AuthorProfile
	INNER JOIN
        dbo.BlogPosts 
		ON dbo.AuthorProfile.author_id = dbo.BlogPosts.author_id 
	LEFT OUTER JOIN
        dbo.Likes 
		ON dbo.BlogPosts.post_id = dbo.Likes.post_id 
	INNER JOIN
        dbo.UserAccount 
		ON dbo.AuthorProfile.account_id = dbo.UserAccount.account_id 
	INNER JOIN
        dbo.UserProfile 
		ON dbo.UserAccount.account_id = dbo.UserProfile.account_id 
	INNER JOIN
        dbo.Categories 
		ON dbo.BlogPosts.category_id = dbo.Categories.category_id
	WHERE
		dbo.BlogPosts.category_id = @CategoryId  -- Filter auf die angegebene Kategorie

	GROUP BY 
		dbo.BlogPosts.post_title,
		dbo.BlogPosts.post_content,
		dbo.UserProfile.first_name + ' ' + dbo.UserProfile.last_name,
		dbo.BlogPosts.is_premium,
		dbo.BlogPosts.post_id,
		dbo.Categories.category_name,
		dbo.BlogPosts.create_at

	ORDER BY
		like_count DESC	 -- Sortierung nach der Anzahl der Likes	
)
GO
