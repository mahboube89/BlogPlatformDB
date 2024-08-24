USE BlogPlatformDB
GO

-- ==============| TEST | TF_Get_Comment_And_Like_Count |==============--


-- ======================================================================
-- Testfall 1			: AccountId existiert und hat sowohl Likes als auch Kommentare
-- Erwartetes Ergebnis	: Code-koala 2 Kommentare und 8 Likes
-- ======================================================================
SELECT * FROM [dbo].[TF_Get_Comment_And_Like_Count](4);


-- ======================================================================
-- Testfall 2			: AccountId existiert, aber hat keine Likes und keine Kommentare
-- Erwartetes Ergebnis	: Es wird eine Zeile mit dem Benutzernamen zurückgegeben, aber die Like_count und Comment_count sollten beide 0 sein.
-- ======================================================================
SELECT * FROM [dbo].[TF_Get_Comment_And_Like_Count](1);


-- ======================================================================
-- Testfall 3			: AccountId existiert nicht
-- Erwartetes Ergebnis	: Es wird keine Zeile zurückgegeben, da die account_id nicht existiert.
-- ======================================================================
SELECT * FROM [dbo].[TF_Get_Comment_And_Like_Count](100);