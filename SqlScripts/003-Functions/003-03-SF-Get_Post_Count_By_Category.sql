USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ==========| SF_Get_Post_Count_By_Category |==========--
-- ======================================================

-- Description:	Diese Funktion gibt die Anzahl der Blog-Posts in einer bestimmten Kategorie zur�ck.
--				Die Anzahl der Posts wird anhand der `category_id` bestimmt.

-- Parameter:
--	- @CategoryId	: Die eindeutige ID der Kategorie, f�r die die Anzahl der Posts ermittelt werden soll.

-- R�ckgabewert:
--	- INT			: Die Anzahl der Blog-Posts, die der angegebenen Kategorie zugeordnet sind.

-- =====================================================


CREATE OR ALTER FUNCTION dbo.SF_Get_Post_Count_By_Category(@CategoryId INT) 

RETURNS INT
AS
BEGIN
	-- Deklarieren der R�ckgabevariablen
	DECLARE @PostCount INT;


	SELECT @PostCount = COUNT(BlogPosts.post_id)

	FROM
		BlogPosts
	INNER JOIN
		Categories 
		ON BlogPosts.category_id = Categories.category_id
	WHERE 
		BlogPosts.category_id = @CategoryId

	-- Return the result of the function
	RETURN @PostCount

END
GO

