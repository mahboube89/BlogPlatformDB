USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[Images]    Script Date: 8/7/2024 9:39:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------
--===============| Create Images Table |===============--

CREATE TABLE [dbo].[Images](

	[image_id]		[int] IDENTITY(1,1) NOT NULL,
	[post_id]		[int]				NOT NULL,
	[image_url]		[nvarchar](255)			NULL,
	[image_caption]	[nvarchar](255)			NULL,
	[upload_date]	[datetime]			NOT NULL	DEFAULT (getdate()),

	-- PK
	CONSTRAINT [PK_Images_ImageID] PRIMARY KEY CLUSTERED 
	([image_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	

	-- FK
	CONSTRAINT [FK_Images_BlogPosts] FOREIGN KEY([post_id])
		REFERENCES [dbo].[BlogPosts] ([post_id])
		ON DELETE CASCADE,

	-- UQ
	CONSTRAINT [UQ_Images_ImageURL] UNIQUE NONCLUSTERED 
	([image_url] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

) ON [PRIMARY]
GO


--------------------------------------------------------------------------
--===============| Create Nonclustered Index for PostID |===============--

CREATE NONCLUSTERED INDEX [IX_Images_PostID] ON [dbo].[Images]
	([post_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 1. 'upload_date' : Darf nicht in der Zukunft liegen.
--==========================================================--

ALTER TABLE dbo.Images ADD CONSTRAINT
	CK_Images_UploadDate 
	CHECK (upload_date <= GETDATE()) 
GO