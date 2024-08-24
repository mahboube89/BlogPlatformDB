 USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[Likes]    Script Date: 8/7/2024 10:07:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--------------------------------------------------------
--===============| Create Likes Table |===============--

CREATE TABLE [dbo].[Likes](

	[like_id]		[int] IDENTITY(1,2) NOT NULL,
	[account_id]	[int]				NOT NULL,
	[post_id]		[int]				NOT NULL,
	[create_at]		[datetime]			NOT NULL	DEFAULT (getdate()),

	-- PK
	CONSTRAINT [PK_Likes] PRIMARY KEY CLUSTERED 
	([like_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY],

	--FK
	CONSTRAINT [FK_Likes_BlogPosts] FOREIGN KEY([post_id])
		REFERENCES [dbo].[BlogPosts] ([post_id]),

	-- FK
	CONSTRAINT [FK_Likes_UserAccount] FOREIGN KEY([account_id])
		REFERENCES [dbo].[UserAccount] ([account_id])


) ON [PRIMARY]
GO


-----------------------------------------------------------------------------
--===============| Create Nonclustered Index for AccountID |===============--

CREATE NONCLUSTERED INDEX [IX_Likes_AccountID] ON [dbo].[Likes]
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--------------------------------------------------------------------------
--===============| Create Nonclustered Index for PostID |===============--

CREATE NONCLUSTERED INDEX [IX_Likes_PostID] ON [dbo].[Likes]
(
	[post_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 'create_at' : Darf nicht in der Zukunft liegen.
--==========================================================--

ALTER TABLE dbo.Likes ADD CONSTRAINT
	CK_Likes_CreateAt 
	CHECK (create_at <= GETDATE())
GO