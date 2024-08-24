USE BlogPlatformDB
GO

-- ==============| TEST | TF_Get_Tags_By_Post |==============--

-- ============================================================
-- Testfall 1			: PostId existiert und hat Tags
-- Erwartetes Ergebnis	: Gibt eine Liste der Tags zur�ck, die dem Blog-Post mit der ID 19 zugeordnet sind.
-- ============================================================
SELECT * FROM dbo.TF_Get_Tags_By_Post(19);



-- ============================================================
-- Testfall 2			: PostId existiert nicht
-- Erwartetes Ergebnis	: Gibt keine Zeilen zur�ck.
-- ============================================================
SELECT * FROM dbo.TF_Get_Tags_By_Post(40);