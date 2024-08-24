USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ============| TR_Notify_Subscribers_On_New_Post |============= --
-- ==============================================================

-- Description:	Dieser Trigger wird automatisch ausgelöst,
--				wenn ein neuer Blog-Post erstellt wird.
--				Er verwendet die gespeicherte Prozedur SP_Create_Post_Notifications,
--				um Benachrichtigungen für alle Abonnenten zu
--				generieren. Diese Benachrichtigungen informieren
--				die Abonnenten über den neuen Inhalt, um sicherzustellen,
--				dass sie stets auf dem neuesten Stand der
--				veröffentlichten Beiträge sind.

-- ==============================================================

CREATE OR ALTER TRIGGER dbo.TR_Notify_Subscribers_On_New_Post

   ON dbo.BlogPosts
   AFTER INSERT
AS 
BEGIN
    SET NOCOUNT ON;

    DECLARE @PostId INT;
    DECLARE @PostTitle NVARCHAR(255);
    DECLARE @NotificationMessage NVARCHAR(255);

    
    SELECT 

        @PostId = post_id, 
        @PostTitle = post_title 

    FROM 
        inserted;

    -- Nachricht erstellen, die den Titel des Blog-Posts enthält
    SET @NotificationMessage = 'Ein neuer Blog-Post wurde veröffentlicht: ' + @PostTitle;

    -- Prozedur zur Benachrichtigung der Abonnenten aufrufen
    EXEC dbo.SP_Create_Post_Notifications @PostId, @NotificationMessage;

END

GO
