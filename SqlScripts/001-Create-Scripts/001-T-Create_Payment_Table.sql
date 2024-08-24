USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[Payment]    Script Date: 8/7/2024 8:22:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--------------------------------------------------------------
--===============| Create Payment Table |===============--

CREATE TABLE [dbo].[Payment](

	[payment_id]			[int] IDENTITY(1,1) NOT NULL,
	[account_id]			[int]				NOT NULL,
	[amount]				[decimal](10, 2)	NOT NULL,
	[payment_method]		[nvarchar](50)		NOT NULL,
	[transaction_id]		[nvarchar](50)		NOT NULL,
	[payment_description]	[nvarchar](255)		NOT NULL,
	[payment_date]			[datetime]			NOT NULL	DEFAULT (getdate()),

	-- PK
	CONSTRAINT [PK_Payment_PaymentID] PRIMARY KEY CLUSTERED 
		([payment_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

	-- FK
	CONSTRAINT [FK_Peyment_UserAccount] FOREIGN KEY([account_id])
		REFERENCES [dbo].[UserAccount] ([account_id]) ON DELETE CASCADE

) ON [PRIMARY]
GO


---------------------------------------------------------------------------
--===============| Create Nonclustered Index for AccountID |===============--

CREATE NONCLUSTERED INDEX [IX_Payment_AccountID] 
	ON [dbo].[Payment]
	([account_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


-------------------------------------------------------------------------------
--===============| Create Nonclustered Index for PaymentDate |===============--

CREATE NONCLUSTERED INDEX [IX_Payment_PaymentDate] 
	ON [dbo].[Payment]
	([payment_date] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



-------------------------------------------------------------------------
--===============| Create Nonclustered Index for PaymentMethod |===============--

SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [IX_Payment_PaymentMethod] 
	ON [dbo].[Payment]
	([payment_method] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


---------------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for TransactionID |===============--


CREATE UNIQUE NONCLUSTERED INDEX UQ_Payment_TransactionID ON dbo.Payment
	(transaction_id)
	WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 'amount'			: Darf nicht negative sein.
-- 'payment_date'	: Darf nicht in der Zukunft liegen.
-- 'payment_method'  : Nur bestimmte Zahlungsmethoden erlaubt sind
--==========================================================--

ALTER TABLE dbo.Payment ADD CONSTRAINT
	CK_Payment_Amount CHECK (amount >= 0)
GO

ALTER TABLE dbo.Payment ADD CONSTRAINT
	CK_Payment_PaymentDate CHECK (payment_date <= GETDATE())
GO

ALTER TABLE dbo.Payment ADD CONSTRAINT
	CK_Payment_PaymentMethod CHECK (payment_method IN ('Credit Card', 'PayPal', 'Bank Transfer'))
GO
