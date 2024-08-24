USE BlogPlatformDB
GO

-- =============| TEST | SP_Add_Comment |==============--


--=====================================================
-- Testfall 1			: Benutzer hat den Blog-Post nicht gelesen
-- Erwartetes Ergebnis	: `Sie k�nnen keinen Kommentar hinzuf�gen, da Sie diesen Blog-Post nicht gelesen haben.`
--=====================================================

DECLARE @ResultMessage NVARCHAR(255);

EXEC dbo.SP_Add_Comment 
	@AccountId			= 5,	-- Benutzer-ID
	@PostId				= 16,   -- Post-ID, den der Benutzer nicht gelesen hat  
	@CommentText		= 'Das ist ein Kommentar.', 
	@ParentCommentId	= NULL, 
	@ResultMessage		= @ResultMessage OUTPUT; 

PRINT @ResultMessage;
------------------------------------------------------


--=====================================================
-- Testfall 2			: Kommentartext ist leer
-- Erwartetes Ergebnis	: `Der Kommentartext darf nicht leer sein.`
--=====================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Add_Comment 
--	@AccountId			= 10, 
--	@PostId				= 14,     
--	@CommentText		= ' ', -- Leerer Kommentartext
--	@ParentCommentId	= NULL, 
--	@ResultMessage		= @ResultMessage OUTPUT; 

--PRINT @ResultMessage;
------------------------------------------------------


--=====================================================
-- Testfall 3			: Kommentartext �berschreitet die maximale L�nge
-- Erwartetes Ergebnis	: `Der Kommentartext �berschreitet die zul�ssige L�nge von 250 Zeichen.`
--=====================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Add_Comment 
--	@AccountId			= 9, 
--	@PostId				= 19,     
--	@CommentText		= 'Web-Entwicklung ist ein faszinierendes und dynamisches Gebiet, das st�ndig neue M�glichkeiten bietet. Mit den Fortschritten in Technologien wie HTML, CSS und JavaScript k�nnen Entwickler beeindruckende Websites und Anwendungen erstellen. Es ist erstaunlich zu sehen, wie sich das Web entwickelt hat und wie Tools und Frameworks wie React, Angular und Vue dabei helfen, Effizienz und Benutzerfreundlichkeit zu verbessern.', -- Kommentartext mit 501 Zeichen
--	@ParentCommentId	= NULL, 
--	@ResultMessage		= @ResultMessage OUTPUT; 

--PRINT @ResultMessage;
------------------------------------------------------


--=====================================================
-- Testfall 4			: G�ltiger Kommentar ohne parent_comment_id
-- Erwartetes Ergebnis	: `Der Kommentar wurde erfolgreich hinzugef�gt.`
--=====================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Add_Comment 
--	@AccountId			= 11, 
--	@PostId				= 25,     
--	@CommentText		= 'Das ist ein g�ltiger Kommentar ohne parent_comment_id.',
--	@ParentCommentId	= NULL,
--	@ResultMessage		= @ResultMessage OUTPUT; 

--PRINT @ResultMessage;
------------------------------------------------------


--=====================================================
-- Testfall 5			: G�ltiger Kommentar mit g�ltigem parent_comment_id
-- Erwartetes Ergebnis	: `Der Kommentar wurde erfolgreich hinzugef�gt.`
--=====================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Add_Comment 
--	@AccountId			= 22, 
--	@PostId				= 11,     
--	@CommentText		= 'Das ist eine Antwort auf einen anderen Kommentar.',
--	@ParentCommentId	= 10, -- einer vorhandenen Kommentar
--	@ResultMessage		= @ResultMessage OUTPUT; 

--PRINT @ResultMessage;
------------------------------------------------------


--====================================================
-- Testfall 6			: Ung�ltiger parent_comment_id
-- Erwartetes Ergebnis	: `Ung�ltige parent_comment_id. Kommentar konnte nicht hinzugef�gt werden.`
--====================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Add_Comment 
--	@AccountId			= 13, 
--	@PostId				= 18,     
--	@CommentText		= 'Versuch, einen Kommentar mit ung�ltigem parent_comment_id hinzuzuf�gen.',
--	@ParentCommentId	= 999, -- Ung�ltige Kommentar-ID, die nicht existiert
--	@ResultMessage		= @ResultMessage OUTPUT; 

--PRINT @ResultMessage;
------------------------------------------------------


--====================================================
-- Testfall 7			: �bergabe eines ung�ltigen Datentyps f�r den AccountId-Parameter.
-- Erwartetes Ergebnis	: Es wird eine entsprechende Fehlermeldung ausgegeben.
--====================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Add_Comment 
--	@AccountId			= 'Invalid',	-- Ung�ltiger Datentyp f�r die ID
--	@PostId				= 20,     
--	@CommentText		= 'Dies sollte einen Fehler verursachen.',
--	@ParentCommentId	= 17, 
--	@ResultMessage		= @ResultMessage OUTPUT; 

--PRINT @ResultMessage;