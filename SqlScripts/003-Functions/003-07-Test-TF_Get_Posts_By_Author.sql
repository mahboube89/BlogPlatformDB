USE BlogPlatformDB
GO

-- ==============| TEST | TF_Get_Posts_By_Author |==============--



-- ===============================================================
-- Testfall 1			: AuthorId existiert und hat Posts
-- Erwartetes Ergebnis	: Gibt alle Posts des Autors mit der AuthorId 203 ("Laura Brown") zur�ck
-- ===============================================================
SELECT * FROM [dbo].[TF_Get_Posts_By_Author](203);


-- ===============================================================
-- Testfall 2			: AuthorId existiert, aber der Autor hat keine Posts
-- Erwartetes Ergebnis	: Gibt eine Zeile zur�ck, die die Autorendetails (author_id, username) von ("CodeWithLukas") anzeigt,
--						  mit post_id = 0, post_title = 'No Posts' und create_at = NULL, da der Autor keine Posts hat.
-- ===============================================================
SELECT * FROM TF_Get_Posts_By_Author(211);


-- ===============================================================
-- Testfall 3			: AuthorId existiert nicht
-- Erwartetes Ergebnis	: Gibt keine Zeilen zur�ck
-- ===============================================================
SELECT * FROM [dbo].[TF_Get_Posts_By_Author](209);
