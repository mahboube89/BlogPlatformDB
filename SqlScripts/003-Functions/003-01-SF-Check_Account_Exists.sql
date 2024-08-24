USE BlogPlatformDB
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--==========| SF_Check_Account_Exists |==========--
-- ================================================

-- Beschreinung: Diese Funktion nimmt die `account_id` als Parameter und 
--				 gibt 1 zurück, wenn die `account_id` existiert, andernfalls 0.

-- Rückgabewert:
--   - 1: Wenn die `account_id` existiert
--   - 0: Wenn die `account_id` nicht existiert

-- ================================================

CREATE FUNCTION dbo.SF_Check_Account_Exists(@AccountId INT)

RETURNS BIT
AS
BEGIN

	DECLARE @Exists BIT;	-- Variable zum Speichern des Rückgabewerts

	IF EXISTS (SELECT 1 FROM dbo.UserAccount WHERE account_id = @AccountId)
		SET @AccountId = 1 ; -- Die account_id existiert
	ELSE
		SET @AccountId = 0 ; -- Die account_id existiert nicht

	RETURN @Exists;
		
END;


