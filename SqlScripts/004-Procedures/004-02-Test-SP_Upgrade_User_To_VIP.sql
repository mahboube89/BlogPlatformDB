USE BlogPlatformDB
GO

-- =============| TEST | SP_Upgrade_User_To_VIP |==============--


--==============================================================
-- Testfall 1			: Eine g�ltige Benutzerrolle (role_id = 300), g�ltiger Betrag (120 EUR)
-- Erwartetes Ergebnis	: `Der Benutzer wurde erfolgreich auf VIP aktualisiert, und die Zahlung wurde erfasst.`
--==============================================================

DECLARE @ResultMessage NVARCHAR(255);

EXEC dbo.SP_Upgrade_User_To_VIP 
    @AccountId			= 28,				
    @Amount				= 120,				-- Betrag f�r 12 Monate VIP. 40, f�r 6 Monate und 20, f�r 1 Monat.
    @PaymentMethod		= 'Credit Card',	
    @TransactionId		= 'TX12345440032',	
    @PaymentDescription = 'VIP-Mitgliedschaft f�r 12 Monate', 
    @ResultMessage		= @ResultMessage OUTPUT;

PRINT @ResultMessage;

-- �berpr�fen, ob die Zahlung hinzugef�gt wurde
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
--    @PaymentDescription = 'VIP-Mitgliedschaft f�r 3 Monate', 
--    @ResultMessage		= @ResultMessage OUTPUT;

--PRINT @ResultMessage;
---------------
--SELECT * FROM dbo.UserAccount WHERE account_id = 4;

--==============================================================
-- Testfall 3			: Eine ung�ltige Rolle (z.B. role_id = 200 f�r author)
-- Erwartetes Ergebnis	: `Nur Benutzer mit der Rolle "user" k�nnen VIP werden.`
--==============================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Upgrade_User_To_VIP 
--    @AccountId			= 1, -- is Author
--    @Amount				= 40,  
--    @PaymentMethod		= 'Credit Card',	
--    @TransactionId		= 'TX0055321187',	
--    @PaymentDescription = 'VIP-Mitgliedschaft f�r 3 Monate', 
--    @ResultMessage		= @ResultMessage OUTPUT;

--PRINT @ResultMessage;
---------------
--SELECT * FROM dbo.UserAccount WHERE account_id = 1;


--===============================================================
-- Testfall 4			: Eine ung�ltige Zahlungsmethode
-- Erwartetes Ergebnis	: `Ung�ltige Zahlungsmethode. Zul�ssige Methoden sind: PayPal, Credit Card, Bank Transfer.`
--===============================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Upgrade_User_To_VIP 
--    @AccountId			= 27, 
--    @Amount				= 40,  
--    @PaymentMethod		= 'Vorkasse', -- Ung�ltige Zahlungsmethode	
--    @TransactionId		= 'TX0055701131',	
--    @PaymentDescription = 'VIP-Mitgliedschaft f�r 3 Monate', 
--    @ResultMessage		= @ResultMessage OUTPUT;

--PRINT @ResultMessage;



--===============================================================
-- Testfall 5			: Einer ung�ltigen Betrag
-- Erwartetes Ergebnis	: `Ung�ltiger Betrag f�r VIP-Mitgliedschaft.`
--===============================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Upgrade_User_To_VIP 
--    @AccountId			= 27, 
--    @Amount				= 35,   -- Ung�ltiger Betrag
--    @PaymentMethod		=  'Credit Card',
--    @TransactionId		= 'TX0023458790',	
--    @PaymentDescription = 'VIP-Mitgliedschaft f�r ung�ltigen Betrag', 
--    @ResultMessage		= @ResultMessage OUTPUT;

--PRINT @ResultMessage;



--===============================================================
-- Testfall 6			: Einer Benutzer mit ung�ltiger AccountId (Benutzer existiert nicht)
-- Erwartetes Ergebnis	: Die Prozedur sollte einen Fehler zur�ckgeben, dass der Benutzer nicht existiert.
--==============================================================

--DECLARE @ResultMessage NVARCHAR(255);

--EXEC dbo.SP_Upgrade_User_To_VIP 
--    @AccountId			= 999, -- Ung�ltige AccountId
--    @Amount				= 20,
--    @PaymentMethod		=  'Credit Card',
--    @TransactionId		= 'TX0023458780',	
--    @PaymentDescription = 'VIP-Mitgliedschaft f�r 1 Monat', 
--    @ResultMessage		= @ResultMessage OUTPUT;

--PRINT @ResultMessage;