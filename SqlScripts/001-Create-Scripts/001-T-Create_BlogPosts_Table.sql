USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[BlogPosts]    Script Date: 8/7/2024 9:05:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-------------------------------------------------------------
--===============| Create BlogPosts Table |===============--

CREATE TABLE [dbo].[BlogPosts](
	[post_id]		[int] IDENTITY(10,1)	NOT NULL,
	[author_id]		[int]					NOT NULL,
	[category_id]	[int]					NOT NULL,
	[post_title]	[nvarchar](255)			NOT NULL,
	[post_content]	[nvarchar](max)			NOT NULL,
	[is_premium]	[bit]					NOT NULL	DEFAULT ((0)),
	[create_at]		[datetime]				NOT NULL	DEFAULT (getdate()),
	[update_at]		[datetime]					NULL,
	[is_deleted]	[bit]					NOT NULL	DEFAULT ((0)),	


	-- PK
	CONSTRAINT [PK_BlogPosts_PostID] PRIMARY KEY CLUSTERED 
		([post_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
		ON [PRIMARY],
	
	-- FK
	CONSTRAINT [FK_BlogPosts_AuthorProfile] FOREIGN KEY([author_id])
		REFERENCES [dbo].[AuthorProfile] ([author_id]),
	-- FK
	CONSTRAINT [FK_BlogPosts_Categories] FOREIGN KEY([category_id])
		REFERENCES [dbo].[Categories] ([category_id])
			
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


------------------------------------------------------------------------------------
--===============| Create Nonclustered Index for AuthorID  |===============--

CREATE NONCLUSTERED INDEX [IX_BlogPosts_AuthorID] 
	ON [dbo].[BlogPosts]
	([author_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--------------------------------------------------------------------------------------
--===============| Create Nonclustered Index for CategoryID  |===============--

CREATE NONCLUSTERED INDEX [IX_BlogPosts_CategoryID] 
	ON [dbo].[BlogPosts]
	([category_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


------------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for PostTitle  |===============--

CREATE UNIQUE NONCLUSTERED INDEX [IX_BlogPosts_PostTitle] 
	ON [dbo].[BlogPosts]
	([post_title] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 'is_premium'	: Nur gültige Werte -> 0 (false) oder 1 (true)
-- 'is_deleted'	: Nur gültige Werte -> 0 (false) oder 1 (true)
-- 'create_at'	: Darf nicht in der Zukunft liegen.
--==========================================================--

ALTER TABLE dbo.BlogPosts ADD CONSTRAINT
    CK_BlogPosts_IsPremium CHECK (is_premium IN (0, 1))
GO

ALTER TABLE dbo.BlogPosts ADD CONSTRAINT
    CK_BlogPosts_IsDeleted CHECK (is_deleted IN (0, 1))
GO

ALTER TABLE dbo.BlogPosts ADD CONSTRAINT
    CK_BlogPosts_CreateAt CHECK (create_at <= GETDATE())
GO
