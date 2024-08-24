USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ==============| TF_Get_Comment_And_Like_Count |==============--
-- ===============================================================

-- Beschreibung: Diese Funktion nimmt die `account_id` als Parameter und 
--				 gibt die Anzahl der Kommentare und Likes f�r diesen Benutzer zur�ck.
--				 Wenn die `account_id` nicht existiert oder keine Kommentare bzw. Likes vorhanden sind,
--				 wird 0 zur�ckgegeben.

-- Parameter:
--	- @AccountId		: Die eindeutige ID des Benutzers, dessen Comments und Likes Anzahl abgerufen werden sollen.

-- R�ckgabewert:
--   Eine Tabelle mit den folgenden Spalten:
--		- Username		: Der Benutzername des Benutzers
--		- Comment_count	: Die Anzahl der Kommentare, die der Benutzer abgegeben hat (oder 0)
--		- Like_count	: Die Anzahl der Likes, die der Benutzer abgegeben hat (oder 0)

-- ===============================================================

CREATE OR ALTER FUNCTION TF_Get_Comment_And_Like_Count(@AccountId INT)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
		dbo.UserAccount.account_id,								-- Die eindeutige ID des Benutzers
		dbo.UserAccount.username				AS Username,	-- Der Benutzername des Benutzers
		COUNT(DISTINCT dbo.Comments.comment_id) AS Comment_coun,-- Z�hlt die Anzahl der eindeutigen Kommentare des Benutzers
        COUNT(DISTINCT dbo.Likes.like_id)		AS Like_count	-- Z�hlt die Anzahl der eindeutigen Likes des Benutzers

		FROM
			dbo.UserAccount
		LEFT JOIN
			dbo.Comments 
			ON dbo.UserAccount.account_id = dbo.Comments.account_id
		LEFT JOIN
			dbo.Likes 
			ON dbo.UserAccount.account_id = dbo.Likes.account_id

		WHERE
			dbo.UserAccount.account_id = @AccountId										-- Filtert die Ergebnisse nach der angegebenen account_id
			AND EXISTS (SELECT 1 FROM dbo.UserAccount WHERE account_id = @AccountId)	-- �berpr�ft, ob die account_id tats�chlich existiert

		GROUP BY 
			dbo.UserAccount.account_id,
			dbo.UserAccount.username
)
GO
