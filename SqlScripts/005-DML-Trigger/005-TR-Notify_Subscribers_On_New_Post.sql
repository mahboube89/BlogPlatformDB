USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ============| TR_Notify_Subscribers_On_New_Post |============= --
-- ==============================================================

-- Description:	Dieser Trigger wird automatisch ausgel�st,
--				wenn ein neuer Blog-Post erstellt wird.
--				Er verwendet die gespeicherte Prozedur SP_Create_Post_Notifications,
--				um Benachrichtigungen f�r alle Abonnenten zu
--				generieren. Diese Benachrichtigungen informieren
--				die Abonnenten �ber den neuen Inhalt, um sicherzustellen,
--				dass sie stets auf dem neuesten Stand der
--				ver�ffentlichten Beitr�ge sind.

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

    -- Nachricht erstellen, die den Titel des Blog-Posts enth�lt
    SET @NotificationMessage = 'Ein neuer Blog-Post wurde ver�ffentlicht: ' + @PostTitle;

    -- Prozedur zur Benachrichtigung der Abonnenten aufrufen
    EXEC dbo.SP_Create_Post_Notifications @PostId, @NotificationMessage;

END

GO
