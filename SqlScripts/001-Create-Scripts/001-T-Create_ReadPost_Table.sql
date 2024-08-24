USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[ReadPosts]    Script Date: 8/7/2024 10:57:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create ReadPosts Table |===============--

CREATE TABLE [dbo].[ReadPosts](

	[read_id]		[int] IDENTITY(1,1) NOT NULL,
	[account_id]	[int]				NOT NULL,
	[post_id]		[int]				NOT NULL,
	[read_at]		[datetime]			NOT NULL	DEFAULT (getdate()),

	-- PK
	CONSTRAINT [PK_ReadPosts_ReadID] PRIMARY KEY CLUSTERED ([read_id] ASC),

	-- FK
	CONSTRAINT [FK_ReadPosts_BlogPosts] FOREIGN KEY([post_id])
		REFERENCES [dbo].[BlogPosts] ([post_id]),
	
	-- FK
	CONSTRAINT [FK_ReadPosts_UserAccount] FOREIGN KEY([account_id])
		REFERENCES [dbo].[UserAccount] ([account_id]),



) ON [PRIMARY]
GO



-----------------------------------------------------------------------------
--===============| Create Nonclustered Index for AccountID |===============--

CREATE NONCLUSTERED INDEX [IX_ReadPost_AccountID] 
	ON [dbo].[ReadPosts]
	([account_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--------------------------------------------------------------------------
--===============| Create Nonclustered Index for PostID |===============--

CREATE NONCLUSTERED INDEX [IX_ReadPost_PostID] 
	ON [dbo].[ReadPosts]
	([post_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

--'read_at' : Darf nicht in der Zukunft liegen.
--==========================================================--

ALTER TABLE dbo.ReadPosts ADD CONSTRAINT
	CK_ReadPosts_ReadAt 
	CHECK (read_at <= GETDATE())
GO