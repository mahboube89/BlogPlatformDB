USE [BlogPlatformDB]
GO

/****** Object:  UserDefinedFunction [dbo].[SF_Get_Like_Count_By_Post]    Script Date: 8/13/2024 10:37:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ==============| SF_Get_Like_Count_By_Post |==============--
-- ===========================================================

-- Beschreibung: Diese Funktion berechnet die Gesamtzahl der Likes 
--               f�r einen bestimmten Blog-Post.

-- Parameter:
--	- @PostId INT	- Die ID des Blog-Posts, 
--					f�r den die Likes gez�hlt werden sollen.

-- R�ckgabewert:
--	- INT			- Die Anzahl der Likes f�r den angegebenen Blog-Post.

-- ============================================================

CREATE OR ALTER   FUNCTION [dbo].[SF_Get_Like_Count_By_Post](@PostId INT)
RETURNS INT
AS
BEGIN
	
	-- Deklarieren der Variablen, um die Anzahl der Likes zu speichern
	DECLARE @LikeCount INT;
	
	-- Abfrage zur Z�hlung der Likes f�r den angegebenen Blog-Post
	SELECT @LikeCount = COUNT(dbo.Likes.post_id)

	FROM dbo.Likes 
	
	WHERE dbo.Likes.post_id = @PostId

	-- R�ckgabe der Anzahl der Likes
	RETURN @LikeCount

END
GO


