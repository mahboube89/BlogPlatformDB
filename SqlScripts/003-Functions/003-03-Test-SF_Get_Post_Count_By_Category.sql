USE BlogPlatformDB
GO

--==========| TEST | SF_Get_Post_Count_By_Category |==========--


--==============================================================
-- Testfall 1			: CategoryId 2 existiert und enthält Posts.
-- Erwartetes Ergebnis	: Gibt die Anzahl der Posts in der Kategorie mit der CategoryId 2 zurück.
--==============================================================
SELECT dbo.SF_Get_Post_Count_By_Category(2) AS AnzahlPosts;


--================================================================
-- Testfall 2			: CategoryId 11 existiert, aber es wurden noch keine Posts in dieser Kategorie veröffentlicht.
-- Erwartetes Ergebnis	: Gibt "0" zurück, da keine Posts in der Kategorie mit der CategoryId 11 existieren.
--================================================================
SELECT dbo.SF_Get_Post_Count_By_Category(11) AS AnzahlPosts;



--================================================================
-- Testfall 3			: CategoryId 14 existiert nicht in der Datenbank.
-- Erwartetes Ergebnis	: Gibt "0" zurück, da keine Kategorie mit der CategoryId 14 existiert.
--================================================================

SELECT dbo.SF_Get_Post_Count_By_Category(14) AS AnzahlPosts;