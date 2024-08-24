USE [BlogPlatformDB]
GO

/****** Object:  StoredProcedure [dbo].[SP_Create_Post_Notifications]    Script Date: 8/12/2024 6:55:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ============| SP_Create_Post_Notifications |============ --
-- ===========================================================

-- Beschreibung: Erstellt Benachrichtigungen f�r alle aktiven Abonnenten eines bestimmten Blog-Posts. 
--               Die Benachrichtigungen werden in der Notifications-Tabelle gespeichert.
--
-- Parameter:    
--   - @PostId INT: Die ID des Blog-Posts, f�r den die Benachrichtigungen erstellt werden.
--   - @NotificationMessage NVARCHAR(255): Die Nachricht, die in der Benachrichtigung an die Abonnenten gesendet wird.
--
-- R�ckgabewert: Keiner (die Prozedur f�gt die Benachrichtigungen f�r die Abonnenten direkt in die Notifications-Tabelle ein).

-- ===========================================================

CREATE OR ALTER   PROCEDURE dbo.SP_Create_Post_Notifications

    @PostId INT,						-- Die ID des neuen Blog-Posts
    @NotificationMessage NVARCHAR(255)	-- Die Nachricht, die den Abonnenten gesendet wird

AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @AccountId INT;				-- Variable zur Speicherung der Account-ID w�hrend des Cursors
	DECLARE @PostTitle NVARCHAR(255);	-- Variable zur Speicherung des Post-Titels

	-- Abrufen des Post-Titels
    SELECT 
		@PostTitle = post_title
    FROM 
		dbo.BlogPosts
    WHERE 
		post_id = @PostId;


    -- Cursor zum Durchlaufen aller Abonnenten, die aktiv sind
    DECLARE account_cursor CURSOR FOR
    
	SELECT 
		account_id 
    FROM 
		dbo.Subscriber
    WHERE 
		is_active = 1;					-- Nur aktive Abonnenten ausw�hlen

    OPEN account_cursor;

    FETCH NEXT FROM account_cursor INTO @AccountId;

    WHILE @@FETCH_STATUS = 0			-- Solange noch Datens�tze vorhanden sind
    BEGIN

        -- Benachrichtigung in die Notifications-Tabelle einf�gen
        INSERT INTO dbo.Notifications
			(
			account_id,
			post_id,
			post_title,
			notification_message
			)
        VALUES 
			(
			@AccountId,				-- ID des aktuellen Abonnenten
			@PostId,				-- ID des neuen Blog-Posts
			@PostTitle,				-- Titel des neuen Blog-Posts
			@NotificationMessage	-- Benachrichtigungsnachricht
			);

        FETCH NEXT FROM account_cursor INTO @AccountId; -- N�chsten Abonnenten holen
    END

    CLOSE account_cursor;								-- Cursor schlie�en
    DEALLOCATE account_cursor;							-- Cursor aus dem Speicher freigeben
END
GO


