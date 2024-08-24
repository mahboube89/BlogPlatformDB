USE BlogPlatformDB
GO

-- ==============| TEST | TF_Get_Most_Like_Post_By_Category |==============--



-- ==========================================================================
-- Testfall 1			:  Kategorie existiert und hat Posts mit Likes
-- Erwartetes Ergebnis	: Der Blog-Post mit den meisten Likes in dieser Kategorie wird zurückgegeben
-- ==========================================================================


DECLARE @CategoryId INT = 1; 
SELECT * FROM dbo.TF_Get_Most_Like_Post_By_Category(@CategoryId);


-- ==========================================================================
-- Testfall 2			: Kategorie existiert, aber es gibt keine Posts in dieser Kategorie
-- Erwartetes Ergebnis	: Keine Zeilen werden zurückgegeben
-- ==========================================================================
--DECLARE @CategoryId INT = 11;  
--SELECT * FROM dbo.TF_Get_Most_Like_Post_By_Category(@CategoryId);


-- ==========================================================================
-- Testfall 3			: Kategorie existiert nicht
-- Erwartetes Ergebnis	: Keine Zeilen werden zurückgegeben
-- ==========================================================================
--DECLARE @CategoryId INT = 999; 
--SELECT * FROM dbo.TF_Get_Most_Like_Post_By_Category(@CategoryId);


