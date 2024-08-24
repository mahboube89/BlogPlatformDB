USE [BlogPlatformDB]
GO

/****** Object:  View [dbo].[View_Author_With_PostCounts]    Script Date: 8/9/2024 9:25:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ==========| View_Authors_With_More_Than_Two_Posts |==========--
-- ===============================================================

-- Beschreibung:	Diese View liefert eine ‹bersicht ¸ber Autoren, die 
--					mehr als zwei Blog-Posts verfasst haben, zusammen mit 
--					ihren Profilinformationen und der Anzahl der Posts.

-- Felder:
--   - author_id		: Die eindeutige ID des Autors
--   - first_name		: Der Vorname des Autors
--   - last_name		: Der Nachname des Autors
--   - author_username	: Der Benutzername des Autors
--   - author_bio		: Die Biografie des Autors
--   - post_count		: Die Anzahl der Blog-Posts, die der Autor verfasst hat

-- ===============================================================

CREATE VIEW [dbo].[View_Authors_With_More_Than_Two_Posts]
AS
SELECT

	dbo.AuthorProfile.author_id,
	dbo.UserProfile.first_name,
	dbo.UserProfile.last_name,
	dbo.UserAccount.username AS author_username,
	dbo.AuthorProfile.biography AS author_bio,

	-- Die Anzahl der Blog-Posts des Autors
	COUNT(dbo.BlogPosts.post_id) AS post_count

FROM
	dbo.BlogPosts 
INNER JOIN
	dbo.AuthorProfile 
	ON dbo.BlogPosts.author_id = dbo.AuthorProfile.author_id 
INNER JOIN
	dbo.UserAccount 
	ON dbo.AuthorProfile.account_id = dbo.UserAccount.account_id
INNER JOIN
	dbo.UserProfile 
	ON dbo.UserAccount.account_id = dbo.UserProfile.account_id

GROUP BY 
	dbo.UserAccount.username,
	dbo.AuthorProfile.biography,
	dbo.AuthorProfile.author_id,
	dbo.UserProfile.first_name,
	dbo.UserProfile.last_name

HAVING
	(COUNT(dbo.BlogPosts.post_id) > 2) -- Filterung, um nur Autoren mit mehr als 2 Blog-Posts einzuschlieﬂen
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "BlogPosts"
            Begin Extent = 
               Top = 14
               Left = 61
               Bottom = 226
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AuthorProfile"
            Begin Extent = 
               Top = 14
               Left = 372
               Bottom = 179
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserAccount"
            Begin Extent = 
               Top = 15
               Left = 655
               Bottom = 270
               Right = 841
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1140
         Width = 1995
         Width = 2955
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 2235
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Authors_With_More_Than_Two_Posts'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Authors_With_More_Than_Two_Posts'
GO


