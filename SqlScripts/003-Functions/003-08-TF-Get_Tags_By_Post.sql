USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- ==============| TF_Get_Tags_By_Post |==============--
-- =====================================================

-- Beschreibung: Diese Funktion gibt alle Tags zurück, die einem bestimmten 
--               Blog-Post zugeordnet sind. Sie akzeptiert die Post-ID als 
--               Parameter und gibt eine Tabelle mit den Tag-IDs und Tag-Namen zurück.

-- Parameter:    
--	- @PostId INT - Die ID des Blog-Posts, für den die Tags abgefragt werden.

-- Rückgabewert:
--	Eine Tabelle mit den Spalten:
--		- tag_id (INT)			: Die ID des Tags.
--		- tag_name (NVARCHAR)	: Der Name des Tags.

-- ========================================================

CREATE OR ALTER FUNCTION dbo.TF_Get_Tags_By_Post(@PostId INT)
RETURNS TABLE 
AS
RETURN 
(
	-- Abfrage zur Rückgabe der Tags, die dem angegebenen Blog-Post zugeordnet sind
	SELECT
		Tags.tag_id,
		Tags.tag_name
	FROM
		Tags
	INNER JOIN
		PostTags
		ON PostTags.tag_id = Tags.tag_id
	WHERE
		PostTags.post_id = @PostId

)
GO
