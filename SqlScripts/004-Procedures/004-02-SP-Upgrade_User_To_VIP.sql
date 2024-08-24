USE [BlogPlatformDB]
GO

/****** Object:  StoredProcedure [dbo].[SP_Upgrade_User_To_VIP]    Script Date: 8/12/2024 11:44:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============| SP_Upgrade_User_To_VIP |==============--
-- =======================================================

-- Beschreibung: Aktualisiert den Benutzerstatus auf VIP
--               basierend auf einer g�ltigen Zahlung. 
--               Aktualisiert den VIP-Status des Benutzers 
--               und erfasst die Zahlung in der Payment-Tabelle.
--
-- Parameter:    
--   - @AccountId INT						: Die ID des Benutzerkontos.
--   - @Amount DECIMAL(10,2)				: Der Zahlungsbetrag.
--   - @PaymentMethod NVARCHAR(50)			: Die Zahlungsmethode (z.B. PayPal, Kreditkarte, Bank�berweisung).
--   - @TransactionId NVARCHAR(50)			: Die Transaktions-ID der Zahlung.
--   - @PaymentDescription NVARCHAR(255)	: Eine Beschreibung der Zahlung.
--   - @ResultMessage NVARCHAR(255) OUTPUT	: Ein Output-Parameter, der eine Nachricht �ber den Erfolg oder Misserfolg der Aktion zur�ckgibt.
--
-- R�ckgabewert: Keiner (aber die Prozedur gibt eine Nachricht 
--               �ber den @ResultMessage Parameter zur�ck, die 
--               den Erfolg oder Misserfolg der VIP-Aktualisierung angibt).

-- ========================================================

CREATE OR ALTER PROCEDURE [dbo].[SP_Upgrade_User_To_VIP] 
	@AccountId INT,
	@Amount DECIMAL(10,2),
	@PaymentMethod NVARCHAR(50),
	@TransactionId NVARCHAR(50),
	@PaymentDescription NVARCHAR(255),
	@ResultMessage NVARCHAR(255) OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @VipMonths INT;
	DECLARE @RoleId INT;

	BEGIN TRY

		-- �berpr�fen, ob die Zahlungsmethode g�ltig ist
		IF @PaymentMethod NOT IN('PayPal', 'Credit Card', 'Bank Transfer')
		BEGIN

			SET @ResultMessage = 'Ung�ltige Zahlungsmethode. Zul�ssige Methoden sind: PayPal, Credit Card, Bank Transfer.';
            RETURN;

		END -- ob die Zahlungsmethode g�ltig ist END
		


		-- �berpr�fen, ob der Benutzer die Rolle "user" hat
		SET @RoleId = (SELECT role_id FROM dbo.UserAccount WHERE account_id = @AccountId);

		IF @RoleId <> 300
		BEGIN

			SET @ResultMessage = 'Nur Benutzer mit der Rolle "user" k�nnen VIP werden.';
            RETURN;

		END -- �berpr�fen, ob der Benutzer die Rolle "user" hat END



		-- �berpr�fen, ob der Benutzer bereits ein VIP ist
		 IF (SELECT is_vip FROM dbo.UserAccount WHERE account_id = @AccountId) = 1
		 BEGIN

			SET @ResultMessage = 'Der Benutzer ist bereits ein VIP.';
            RETURN;

		 END -- �berpr�fen, ob der Benutzer bereits ein VIP ist END


		 -- Bestimmen der VIP-Dauer basierend auf dem Zahlungsbetrag
		 SET @VipMonths = CASE		 
			 WHEN @Amount = 120 THEN 12
			 WHEN @Amount = 40 THEN 3
			 WHEN @Amount = 20 THEN 1
			 ELSE 0 -- Falls Betrag ung�ltig ist
		 END

		 -- �berpr�fen, ob der Betrag g�ltig ist
		IF @VipMonths = 0
		BEGIN

			SET @ResultMessage = 'Ung�ltiger Betrag f�r VIP-Mitgliedschaft.';
			RETURN;

		END


		-- Schritt 1: VIP-Status und VIP-Daten im Benutzerkonto aktualisieren
		UPDATE [dbo].[UserAccount]
		SET
			is_vip = 1,
			vip_start_date = GETDATE(),
			vip_end_date = DATEADD(MONTH, @VipMonths, GETDATE()) -- VIP f�r die berechnete Anzahl von Monaten
		WHERE account_id = @AccountId;


		-- Schritt 2: Zahlung in die Payment-Tabelle einf�gen
		INSERT INTO [dbo].[Payment]
			(account_id, amount, payment_method, transaction_id, payment_description, payment_date)
		VALUES 
			(@AccountId, @Amount, @PaymentMethod, @TransactionId, @PaymentDescription, GETDATE());

		-- Erfolgsnachricht setzen
        SET @ResultMessage = 'Der Benutzer wurde erfolgreich auf VIP aktualisiert, und die Zahlung wurde erfasst.';

	END TRY
	BEGIN CATCH
		 SET @ResultMessage = 'Ein Fehler ist aufgetreten: ' + ERROR_MESSAGE();
		 THROW;
	END CATCH
  
END
GO


