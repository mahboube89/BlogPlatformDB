 USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[Categories]    Script Date: 8/7/2024 8:53:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-------------------------------------------------------------
--===============| Create Categories Table |===============--

CREATE TABLE [dbo].[Categories](

	[category_id]		[int] IDENTITY(1,1) NOT NULL,
	[category_name]		[nvarchar](50)		NOT NULL,

	-- PK
	CONSTRAINT [PK_Categories_CategoryID] PRIMARY KEY CLUSTERED 
	([category_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
	ON [PRIMARY]

) ON [PRIMARY]
GO


----------------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for CategoryName  |===============--

CREATE UNIQUE NONCLUSTERED INDEX [IX_Categories_CategoryName] 
	ON [dbo].[Categories]
	([category_name] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 1. 'category_name'   : Darf nicht leer sein oder nur aus Leerzeichen bestehen.
--==========================================================--

ALTER TABLE dbo.Categories ADD CONSTRAINT
	CK_Categories_CategoryName 
	CHECK (LEN(LTRIM(RTRIM(category_name))) > 0)
GO