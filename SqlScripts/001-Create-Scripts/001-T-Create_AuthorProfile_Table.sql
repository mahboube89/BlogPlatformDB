USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[AuthorProfile]    Script Date: 8/7/2024 6:07:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------
--===============| Create AuthorProfile Table |===============--

CREATE TABLE [dbo].[AuthorProfile](

	[author_id]		[int] IDENTITY(200,1)	NOT NULL,
	[account_id]	[int]					NOT NULL,
	[biography]		[nvarchar](255)			NULL,
	[social_links]	[nvarchar](max)			NULL,
	[experties]		[nvarchar](255)			NOT NULL,

	-- PK
	CONSTRAINT [PK_AuthorProfile_AuthorID] PRIMARY KEY CLUSTERED 
		([author_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	
	-- FK
	CONSTRAINT [FK_AuthorProfile_UserAccount] FOREIGN KEY([account_id])
		REFERENCES [dbo].[UserAccount] ([account_id])
		ON DELETE CASCADE

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


-----------------------------------------------------------------------------------
--===============| Create Unique Unclustered Index For AccountID |===============--

CREATE UNIQUE NONCLUSTERED INDEX [IX_AuthorProfile_AccountID] 
	ON [dbo].[AuthorProfile]
	([account_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 1. 'experties' : Darf nicht leer sein oder nur aus Leerzeichen bestehen
--==========================================================--
ALTER TABLE dbo.AuthorProfile ADD CONSTRAINT
	CK_AuthorProfile_Experties 
	CHECK (LEN(LTRIM(RTRIM(experties))) > 0)
GO
