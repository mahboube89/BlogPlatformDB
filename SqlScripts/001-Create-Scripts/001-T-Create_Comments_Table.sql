 USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[Comments]    Script Date: 8/7/2024 11:49:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------------------------
--===============| Create Comments Table |===============--

CREATE TABLE [dbo].[Comments](
	[comment_id]		[int] IDENTITY(1,1) NOT NULL,
	[account_id]		[int]				NOT NULL,
	[post_id]			[int]				NOT NULL,
	[comment_text]		[nvarchar](max)		NOT NULL,
	[parent_comment_id] [int]					NULL,
	[created_at]		[datetime]			NOT NULL	DEFAULT (getdate()),

	-- PK
	CONSTRAINT [PK_Comments_CommentID] PRIMARY KEY CLUSTERED 
		([comment_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],

	-- FK
	CONSTRAINT [FK_Comments_BlogPosts] FOREIGN KEY([post_id])
		REFERENCES [dbo].[BlogPosts] ([post_id]),

	-- FK
	CONSTRAINT [FK_Comments_Comments] FOREIGN KEY([parent_comment_id])
		REFERENCES [dbo].[Comments] ([comment_id]),

	-- FK
	CONSTRAINT [FK_Comments_UserAccount] FOREIGN KEY([account_id])
		REFERENCES [dbo].[UserAccount] ([account_id])


	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


-----------------------------------------------------------------------------
--===============| Create Nonclustered Index for AccountID |===============--

CREATE NONCLUSTERED INDEX [IX_Comments_AccountID] ON [dbo].[Comments]
	([account_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO


--------------------------------------------------------------------------
--===============| Create Nonclustered Index for PostID |===============--

CREATE NONCLUSTERED INDEX [IX_Comments_PostID] ON [dbo].[Comments]
	([post_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 'created_at'		: Darf nicht in der Zukunft liegen.
-- 'comment_text'	: Darf nicht leer oder nur aus Leerzeichen besteht
--==========================================================--

ALTER TABLE dbo.Comments ADD CONSTRAINT
	CK_Comments_CreateAt 
	CHECK (created_at <= GETDATE())
GO


ALTER TABLE dbo.Comments ADD CONSTRAINT
	CK_Comments_CommentText 
	CHECK (LEN(LTRIM(RTRIM(comment_text))) > 0)
GO