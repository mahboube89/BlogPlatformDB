USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[Subscriber]    Script Date: 8/9/2024 9:25:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-------------------------------------------------------------
--===============| Create Subscriber Table |===============--

CREATE TABLE [dbo].[Subscriber](

	[subscriber_id]		[int] IDENTITY(1,1) NOT NULL,
	[account_id]		[int]				NOT NULL,
	[subscription_date]	[datetime]			NOT NULL	DEFAULT (getdate()),
	[is_active]			[bit]				NOT NULL	DEFAULT ((1)),
	[expiration_date]	[datetime]				NULL,

	-- PK
	CONSTRAINT [PK_Subscriber_SubscriberID] PRIMARY KEY CLUSTERED 
	([subscriber_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY],
	
	-- UQ
	CONSTRAINT [UQ_Subscriber_AccountID] UNIQUE NONCLUSTERED 
	([account_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY],

	-- FK
	CONSTRAINT [FK_Subscriber_UserAccount] FOREIGN KEY([account_id])
	REFERENCES [dbo].[UserAccount] ([account_id])


) ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 1. 'expiration_date'   : (Falls angegeben) liegt nach dem 'subscription_date'.
-- 2. 'is_active'         : Nur gültige Werte -> 0 (false) oder 1 (true).
-- 3. 'subscription_date' : Darf nicht in der Zukunft liegen.
--==========================================================--


ALTER TABLE [dbo].[Subscriber]  WITH CHECK ADD  CONSTRAINT [CK_Subscriber_ExpireDate] 
	CHECK  (([expiration_date] IS NULL OR [expiration_date]>[subscription_date]))
GO

ALTER TABLE [dbo].[Subscriber]  WITH CHECK ADD  CONSTRAINT [CK_Subscriber_IsActive] 
	CHECK  (([is_active]=(1) OR [is_active]=(0)))
GO

ALTER TABLE [dbo].[Subscriber]  WITH CHECK ADD  CONSTRAINT [CK_Subscriber_SubscriptionDate] 
	CHECK  (([subscription_date]<=getdate()))
GO


