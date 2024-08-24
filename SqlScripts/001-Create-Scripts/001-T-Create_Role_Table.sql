USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[Role]    Script Date: 8/7/2024 5:33:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-------------------------------------------------------
--===============| Create Role Table |===============--

CREATE TABLE [dbo].[Role](

	[role_id]		[int] IDENTITY(100,100)	NOT NULL,
	[role_name]		[nvarchar](20)			NOT NULL,

	-- PK
	CONSTRAINT [PK_Role_RoleID] PRIMARY KEY CLUSTERED 
		([role_id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Indx for RoleName |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Role_RoleName] 
	ON [dbo].[Role]
	([role_name] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--===============| Adding CHECK Constraints |===============--

-- 'role_name' : Darf  nicht leer sein oder nur aus Leerzeichen bestehen
-- 'role_name' : Nur die zulässigen Werte können für role_name in der Role-Tabelle eingegeben werden .
--==========================================================--

ALTER TABLE dbo.Role 
ADD CONSTRAINT CK_Role_RoleNameA 
	CHECK (LEN(LTRIM(RTRIM(role_name))) > 0)
GO

ALTER TABLE dbo.Role 
ADD CONSTRAINT CK_Role_RoleNameB 
	CHECK (role_name IN ('User', 'Admin', 'Author'))
GO
