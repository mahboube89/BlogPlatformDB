USE BlogPlatformDB
GO

--==========| TEST | SF_Get_Like_Count_By_Post|==========--



--=========================================================
-- Testfall 1			: PostId existiert und hat Likes
-- Erwartetes Ergebnis	: Gibt die Anzahl der Likes f�r den Post zur�ck.
--=========================================================
DECLARE @PostId INT = 11;
DECLARE @LikeCount INT;

SET @LikeCount = dbo.SF_Get_Like_Count_By_Post(@PostId);

PRINT 'Number of likes for post ' + '"'+ CAST(@PostId AS NVARCHAR) +'"' + ' : ' + CAST(@LikeCount AS NVARCHAR);


--=========================================================
-- Testfall 2			: PostId existiert, aber keine Likes
-- Erwartetes Ergebnis	: Gibt 0 zur�ck.
--=========================================================
--DECLARE @PostId INT = 29;
--DECLARE @LikeCount INT;

--SET @LikeCount = dbo.SF_Get_Like_Count_By_Post(@PostId);

--PRINT 'Number of likes for post ' + '"'+ CAST(@PostId AS NVARCHAR) +'"' + ' : ' + CAST(@LikeCount AS NVARCHAR);



--=========================================================
-- Testfall 3			: PostId existiert nicht
-- Erwartetes Ergebnis	: Gibt 0 zur�ck.
--=========================================================

--DECLARE @PostId INT = 40;
--DECLARE @LikeCount INT;

--SET @LikeCount = dbo.SF_Get_Like_Count_By_Post(@PostId);

--PRINT 'Anzahl der Likes f�r den Post ' + '"'+ CAST(@PostId AS NVARCHAR) +'"' + ' : ' + CAST(@LikeCount AS NVARCHAR);
