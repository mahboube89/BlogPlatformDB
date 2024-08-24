USE [BlogPlatformDB]
GO

/****** Object:  Table [dbo].[PostUpdateLog]    Script Date: 8/13/2024 6:13:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-------------------------------------------------------------
--===============| Create Categories Table |===============--


CREATE TABLE [dbo].[PostUpdateLog](

	[log_id]			[int] IDENTITY(1,1) NOT NULL,
	[action_type]		[nvarchar](10)		NOT NULL,
	[post_id]			[int]				NOT NULL,
	[updated_at]		[datetime]			NOT NULL	DEFAULT (getdate()),
	[updated_by]		[nvarchar](255)		NOT NULL	DEFAULT (original_login()),
	[log_description]	[nvarchar](500)		NOT NULL,

	-- PK
	CONSTRAINT [PK__PostUpdateLog] PRIMARY KEY CLUSTERED 
	([log_id] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
	ON [PRIMARY]

) ON [PRIMARY]
GO




--===============| Adding CHECK Constraints |===============--
-- 'action_type' : Nur die zulässigen Werte können für action_type eingegeben werden .
--==========================================================--

ALTER TABLE [dbo].[PostUpdateLog]  WITH CHECK ADD  CONSTRAINT
	[CK_PostUpdateLog_ActionType] 
	CHECK  (([action_type]='DELETE' OR [action_type]='UPDATE' OR [action_type]='INSERT'))
GO

ALTER TABLE [dbo].[PostUpdateLog] CHECK CONSTRAINT [CK_PostUpdateLog_ActionType]
GO


