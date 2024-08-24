USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[SavedPosts]    Script Date: 8/7/2024 11:17:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-------------------------------------------------------------
--===============| Create SevedPosts Table |===============--
CREATE TABLE [dbo].[SavedPosts](

	[seved_post_id] [int] IDENTITY(1,1) NOT NULL,
	[account_id]	[int]				NOT NULL,
	[post_id]		[int]				NOT NULL,
	[seved_at]		[datetime]			NOT NULL	DEFAULT (getdate()),

	-- PK
	CONSTRAINT [PK_SavedPosts_SavedPostID] PRIMARY KEY CLUSTERED 
		([seved_post_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],
	
	-- UQ
	CONSTRAINT [UQ_SavedPosts_AccountID_PostID] UNIQUE NONCLUSTERED (account_id,post_id) 
		WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
		ON [PRIMARY],

	-- FK
	CONSTRAINT [FK_SavedPosts_BlogPosts] FOREIGN KEY([post_id])
		REFERENCES [dbo].[BlogPosts] ([post_id])
		ON UPDATE CASCADE
		ON DELETE CASCADE,

	-- FK
	CONSTRAINT [FK_SavedPosts_UserAccount] FOREIGN KEY([account_id])
		REFERENCES [dbo].[UserAccount] ([account_id])
		ON DELETE CASCADE

) ON [PRIMARY]
GO


---------------------------------------------------------------------------
--===============| Create Nonclustered Index for AccountID |===============--

CREATE NONCLUSTERED INDEX [IX_SavedPosts_AccountID] 
	ON [dbo].[SavedPosts]
	([account_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO


---------------------------------------------------------------------------
--===============| Create Nonclustered Index for AccountID |===============--

CREATE NONCLUSTERED INDEX [IX_SavedPosts_PostID] 
	ON [dbo].[SavedPosts]
	([post_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 1. 'seved_at' : Darf nicht in der Zukunft liegen.
--==========================================================--

ALTER TABLE dbo.SavedPosts ADD CONSTRAINT
	CK_SavedPosts_SavedAt 
	CHECK (seved_at <= GETDATE())
GO
