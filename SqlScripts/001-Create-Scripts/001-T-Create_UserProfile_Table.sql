USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[UserProfile]    Script Date: 8/7/2024 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--------------------------------------------------------------
--===============| Create UserProfile Table |===============--

CREATE TABLE [dbo].[UserProfile](

	[user_profile_id]	[int] IDENTITY(1,1) NOT NULL,
	[account_id]		[int]				NOT NULL,
	[first_name]		[nvarchar](50)		NULL,
	[last_name]			[nvarchar](50)		NULL,
	[bio]				[nvarchar](max)		NULL,
	[profile_pic_url]	[nvarchar](255)		NULL,
	[last_login]		[datetime]			NULL,
	[last_logout]		[datetime]			NULL,

	-- PK
	CONSTRAINT [PK_UserProfile_userProfileID] PRIMARY KEY CLUSTERED ([user_profile_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	
	-- FK
	CONSTRAINT [FK_UserProfile_UserAccount] FOREIGN KEY([account_id])
		REFERENCES [dbo].[UserAccount] ([account_id])
		ON DELETE CASCADE

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


------------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index For AccountID |===============--

CREATE UNIQUE NONCLUSTERED INDEX [IX_UserProfile_AccountID] 
	ON [dbo].[UserProfile]
	([account_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


-----------------------------------------------------------------------------
--===============| Create Nonclustered Index For LastLogin |===============--

CREATE NONCLUSTERED INDEX [IX_UserProfile_lastLogin] 
	ON [dbo].[UserProfile]
	([last_login] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 1. 'last_logout'	: Wenn vorhanden, nach last_login liegt. 
-- 2. 'first_name'	: Entweder leer ist (NULL) oder einen Wert enthält, der nicht nur aus Leerzeichen besteht.
-- 3. 'last_name'	: Entweder leer ist (NULL) oder einen Wert enthält, der nicht nur aus Leerzeichen besteht
--==========================================================--

ALTER TABLE dbo.UserProfile ADD CONSTRAINT
	CK_UserProfile_LastLogOut 
	CHECK (last_logout IS NULL OR last_logout > last_login)
GO

ALTER TABLE dbo.UserProfile ADD CONSTRAINT
	CK_UserProfile_FirstName 
	CHECK (LEN(LTRIM(RTRIM(first_name))) > 0 OR first_name IS NULL)
GO

ALTER TABLE dbo.UserProfile ADD CONSTRAINT
	CK_UserProfile_LastName 
	CHECK (LEN(LTRIM(RTRIM(last_name))) > 0 OR last_name IS NULL)
GO