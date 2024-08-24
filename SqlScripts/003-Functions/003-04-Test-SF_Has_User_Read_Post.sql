USE BlogPlatformDB
GO

--==========| TEST | SF_Has_User_Read_Post |==========--


--======================================================
-- Testfall 1			: Benutzer hat den Post gelesen
-- Erwartetes Ergebnis	: Gibt 1 zurück.
--======================================================

--DECLARE @AccountId INT = 4;
--DECLARE @PostId INT = 16;
--DECLARE @HasReadPost BIT;

--SET @HasReadPost = dbo.SF_Has_User_Read_Post(@AccountId, @PostId);

--PRINT @HasReadPost;



--======================================================
-- Testfall 2			: Benutzer hat den Post nicht gelesen
-- Erwartetes Ergebnis	: Gibt 0 zurück.
--======================================================

DECLARE @AccountId INT = 6;
DECLARE @PostId INT = 16;
DECLARE @HasReadPost BIT;

SET @HasReadPost = dbo.SF_Has_User_Read_Post(@AccountId, @PostId);

PRINT @HasReadPost;