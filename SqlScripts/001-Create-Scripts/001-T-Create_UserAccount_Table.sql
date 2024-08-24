USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[UserAccount]    Script Date: 8/7/2024 5:14:39 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------
--===============| Create UserAccount Table |===============--

CREATE TABLE [dbo].[UserAccount](

	[account_id]		[int] IDENTITY(1,1) NOT NULL,
	[username]			[nvarchar](50)		NOT NULL,
	[email]				[nvarchar](100)		NOT NULL,
	[role_id]			[int]				NOT NULL	DEFAULT ((300)), -- 300 = User
	[password]			[nvarchar](255)		NOT NULL,
	[create_at]			[datetime]			NOT NULL	DEFAULT (getdate()),
	[is_vip]			[bit]				NOT NULL	DEFAULT ((0)),
	[vip_start_date]	[datetime]				NULL,
	[vip_end_date]		[datetime]				NULL,
	[is_2fa_enabled]	[bit]				NOT NULL	DEFAULT ((0)),

	-- PK
	CONSTRAINT [PK_UserAccount_accountID] PRIMARY KEY CLUSTERED ([account_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	
	-- FK
	CONSTRAINT [FK_UserAccount_Role] FOREIGN KEY([role_id])
		REFERENCES [dbo].[Role] ([role_id])
		ON DELETE CASCADE

) ON [PRIMARY]
GO


------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for Email |===============--

SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UserAccount_Email] 
	ON [dbo].[UserAccount]
	([email] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

-----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for Username |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UserAccount_Username] 
	ON [dbo].[UserAccount]
	([username] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



--===============| Adding CHECK Constraints |===============--

-- 'role_id'		: Nur bestimmte Werte annehmen kann. 100 = Admin, 200 = Author, 300 = User 
-- 'is_vip'			: Nur die Werte 0 (false) oder 1 (true) annehmen kann
-- 'vip_end_date'	: Wenn vorhanden, nach vip_start_date liegt.
-- 'create_at'		: Nicht in der Zukunft liegt.

--==========================================================--

ALTER TABLE dbo.UserAccount ADD CONSTRAINT
	CK_UserAccount_RoleID 
	CHECK (role_id IN (100, 200, 300)) 
GO

ALTER TABLE dbo.UserAccount ADD CONSTRAINT
	CK_UserAccount_IsVIP 
	CHECK (is_vip IN (0, 1))
GO

ALTER TABLE dbo.UserAccount ADD CONSTRAINT
	CK_UserAccount_VipEndDate 
	CHECK (vip_end_date IS NULL OR vip_end_date > vip_start_date)
GO

ALTER TABLE dbo.UserAccount ADD CONSTRAINT
	CK_UserAccount_CreateAt 
	CHECK (create_at <= GETDATE())
GO