USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[PostTags]    Script Date: 8/7/2024 11:34:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create PostTags Table |===============--

CREATE TABLE [dbo].[PostTags](

	[post_id]	[int] NOT NULL,
	[tag_id]	[int] NOT NULL,

	-- FK
	CONSTRAINT [FK_PostTags_BlogPosts] FOREIGN KEY([post_id])
	REFERENCES [dbo].[BlogPosts] ([post_id]),

	-- FK
	CONSTRAINT [FK_PostTags_Tags] FOREIGN KEY([tag_id])
		REFERENCES [dbo].[Tags] ([tag_id])

) ON [PRIMARY]
GO



--------------------------------------------------------------------------
--===============| Create Nonclustered Index for PostID |===============--

CREATE NONCLUSTERED INDEX [IX_PostTags_PostID] 
	ON [dbo].[PostTags]
	([post_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO

-------------------------------------------------------------------------
--===============| Create Nonclustered Index for TagID |===============--

CREATE NONCLUSTERED INDEX [IX_PostTags_TagID] 
	ON [dbo].[PostTags]
	([tag_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO