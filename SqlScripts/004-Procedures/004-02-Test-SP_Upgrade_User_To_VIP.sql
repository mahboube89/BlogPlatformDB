USE BlogPlatformDB
GO

-- =============| TEST | SP_Upgrade_User_To_VIP |==============--


--==============================================================
-- Testfall 1			: Eine gültige Benutzerrolle (role_id = 300), gültiger Betrag (120 EUR)
-- Erwartetes Ergebnis	: `Der Benutzer wurde erfolgreich auf VIP aktualisiert, und die Zahlung wurde erfasst.`
--==============================================================

DECLARE @ResultMessage NVARCHAR(255);

EXEC dbo.SP_Upgrade_User_To_VIP 
    @AccountId			= 28,				
    @Amount				= 120,				-- Betrag für 12 Monate VIP. 40, für 6 Monate und 20, für 1 Monat.
    @PaymentMethod		= 'Credit Card',	
    @TransactionId		= 'TX12345440032',	
    @PaymentDescription = 'VIP-Mitgliedschaft für 12 Monate', 
    @ResultMessage		= @ResultMessage OUTPUT;

PRINT @ResultMessage;

-- Überprüfen, ob die Zahlung hinzugefügt wurde
SELECT * 
FROM 
	dbo.Payment
WHERE 
	account_id = 8 AND transaction_id = 'TX12345440032';
---------

SELECT * FROM dbo.UserAccount WHERE account_id = 28;




--==============================================================
-- Testfall 2			: Einer Benutzer, der bereits VIP ist
-- Erwartetes Ergebnis	: `Der Benutzer ist bereits ein VIP.`
--==============================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Upgrade_User_To_VIP 
--    @AccountId			= 4,
--    @Amount				= 40,  
--    @PaymentMethod		= 'Credit Card',	
--    @TransactionId		= 'TX0055321113',	
--    @PaymentDescription = 'VIP-Mitgliedschaft für 3 Monate', 
--    @ResultMessage		= @ResultMessage OUTPUT;

--PRINT @ResultMessage;
---------------
--SELECT * FROM dbo.UserAccount WHERE account_id = 4;

--==============================================================
-- Testfall 3			: Eine ungültige Rolle (z.B. role_id = 200 für author)
-- Erwartetes Ergebnis	: `Nur Benutzer mit der Rolle "user" können VIP werden.`
--==============================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Upgrade_User_To_VIP 
--    @AccountId			= 1, -- is Author
--    @Amount				= 40,  
--    @PaymentMethod		= 'Credit Card',	
--    @TransactionId		= 'TX0055321187',	
--    @PaymentDescription = 'VIP-Mitgliedschaft für 3 Monate', 
--    @ResultMessage		= @ResultMessage OUTPUT;

--PRINT @ResultMessage;
---------------
--SELECT * FROM dbo.UserAccount WHERE account_id = 1;


--===============================================================
-- Testfall 4			: Eine ungültige Zahlungsmethode
-- Erwartetes Ergebnis	: `Ungültige Zahlungsmethode. Zulässige Methoden sind: PayPal, Credit Card, Bank Transfer.`
--===============================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Upgrade_User_To_VIP 
--    @AccountId			= 27, 
--    @Amount				= 40,  
--    @PaymentMethod		= 'Vorkasse', -- Ungültige Zahlungsmethode	
--    @TransactionId		= 'TX0055701131',	
--    @PaymentDescription = 'VIP-Mitgliedschaft für 3 Monate', 
--    @ResultMessage		= @ResultMessage OUTPUT;

--PRINT @ResultMessage;



--===============================================================
-- Testfall 5			: Einer ungültigen Betrag
-- Erwartetes Ergebnis	: `Ungültiger Betrag für VIP-Mitgliedschaft.`
--===============================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Upgrade_User_To_VIP 
--    @AccountId			= 27, 
--    @Amount				= 35,   -- Ungültiger Betrag
--    @PaymentMethod		=  'Credit Card',
--    @TransactionId		= 'TX0023458790',	
--    @PaymentDescription = 'VIP-Mitgliedschaft für ungültigen Betrag', 
--    @ResultMessage		= @ResultMessage OUTPUT;

--PRINT @ResultMessage;



--===============================================================
-- Testfall 6			: Einer Benutzer mit ungültiger AccountId (Benutzer existiert nicht)
-- Erwartetes Ergebnis	: Die Prozedur sollte einen Fehler zurückgeben, dass der Benutzer nicht existiert.
--==============================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Upgrade_User_To_VIP 
--    @AccountId			= 999, -- Ungültige AccountId
--    @Amount				= 20,
--    @PaymentMethod		=  'Credit Card',
--    @TransactionId		= 'TX0023458780',	
--    @PaymentDescription = 'VIP-Mitgliedschaft für 1 Monat', 
--    @ResultMessage		= @ResultMessage OUTPUT;

--PRINT @ResultMessage;