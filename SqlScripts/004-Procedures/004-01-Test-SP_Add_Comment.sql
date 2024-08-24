USE BlogPlatformDB
GO

-- =============| TEST | SP_Add_Comment |==============--


--=====================================================
-- Testfall 1			: Benutzer hat den Blog-Post nicht gelesen
-- Erwartetes Ergebnis	: `Sie können keinen Kommentar hinzufügen, da Sie diesen Blog-Post nicht gelesen haben.`
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
-- Testfall 3			: Kommentartext überschreitet die maximale Länge
-- Erwartetes Ergebnis	: `Der Kommentartext überschreitet die zulässige Länge von 250 Zeichen.`
--=====================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Add_Comment 
--	@AccountId			= 9, 
--	@PostId				= 19,     
--	@CommentText		= 'Web-Entwicklung ist ein faszinierendes und dynamisches Gebiet, das ständig neue Möglichkeiten bietet. Mit den Fortschritten in Technologien wie HTML, CSS und JavaScript können Entwickler beeindruckende Websites und Anwendungen erstellen. Es ist erstaunlich zu sehen, wie sich das Web entwickelt hat und wie Tools und Frameworks wie React, Angular und Vue dabei helfen, Effizienz und Benutzerfreundlichkeit zu verbessern.', -- Kommentartext mit 501 Zeichen
--	@ParentCommentId	= NULL, 
--	@ResultMessage		= @ResultMessage OUTPUT; 

--PRINT @ResultMessage;
------------------------------------------------------


--=====================================================
-- Testfall 4			: Gültiger Kommentar ohne parent_comment_id
-- Erwartetes Ergebnis	: `Der Kommentar wurde erfolgreich hinzugefügt.`
--=====================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Add_Comment 
--	@AccountId			= 11, 
--	@PostId				= 25,     
--	@CommentText		= 'Das ist ein gültiger Kommentar ohne parent_comment_id.',
--	@ParentCommentId	= NULL,
--	@ResultMessage		= @ResultMessage OUTPUT; 

--PRINT @ResultMessage;
------------------------------------------------------


--=====================================================
-- Testfall 5			: Gültiger Kommentar mit gültigem parent_comment_id
-- Erwartetes Ergebnis	: `Der Kommentar wurde erfolgreich hinzugefügt.`
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
-- Testfall 6			: Ungültiger parent_comment_id
-- Erwartetes Ergebnis	: `Ungültige parent_comment_id. Kommentar konnte nicht hinzugefügt werden.`
--====================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Add_Comment 
--	@AccountId			= 13, 
--	@PostId				= 18,     
--	@CommentText		= 'Versuch, einen Kommentar mit ungültigem parent_comment_id hinzuzufügen.',
--	@ParentCommentId	= 999, -- Ungültige Kommentar-ID, die nicht existiert
--	@ResultMessage		= @ResultMessage OUTPUT; 

--PRINT @ResultMessage;
------------------------------------------------------


--====================================================
-- Testfall 7			: Übergabe eines ungültigen Datentyps für den AccountId-Parameter.
-- Erwartetes Ergebnis	: Es wird eine entsprechende Fehlermeldung ausgegeben.
--====================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Add_Comment 
--	@AccountId			= 'Invalid',	-- Ungültiger Datentyp für die ID
--	@PostId				= 20,     
--	@CommentText		= 'Dies sollte einen Fehler verursachen.',
--	@ParentCommentId	= 17, 
--	@ResultMessage		= @ResultMessage OUTPUT; 

--PRINT @ResultMessage;