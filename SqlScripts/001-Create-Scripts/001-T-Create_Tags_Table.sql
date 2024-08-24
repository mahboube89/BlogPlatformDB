USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[Tags]    Script Date: 8/7/2024 11:27:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-------------------------------------------------------
--===============| Create Tags Table |===============--

CREATE TABLE [dbo].[Tags](

	[tag_id]	[int] IDENTITY(1,1) NOT NULL,
	[tag_name]	[nvarchar](50)		NOT NULL,

	-- PK
	CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED ([tag_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]

) ON [PRIMARY]
GO

---------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for TagName |===============--

CREATE UNIQUE NONCLUSTERED INDEX [IX_Tags_TagName] 
	ON [dbo].[Tags]
	([tag_name] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 1. 'tag_name' : Darf  nicht leer sein oder nur aus Leerzeichen bestehen
--==========================================================--

ALTER TABLE dbo.Tags ADD CONSTRAINT
	CK_Tags_TagName 
	CHECK (LEN(LTRIM(RTRIM(tag_name))) > 0)
GO