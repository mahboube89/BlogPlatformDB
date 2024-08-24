USE [BlogPlatformDB]
GO

/****** Object:  View [dbo].[View_Comments_With_PostTitles]    Script Date: 8/9/2024 8:47:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--==========| View_Posts_With_Comments_And_User_Details |==========--
--===================================================================

-- Beschreibung:	Diese View liefert eine detaillierte Übersicht über Blog-Posts 
--					zusammen mit den zugehörigen Kommentaren und den Benutzerinformationen 
--					der Kommentatoren.

-- Felder:
--   - post_id				: Die ID des BlogPosts
--   - post_title			: Der Titel des BlogPosts
--   - commenter_username	: Der Benutzername der Person, die den Kommentar abgegeben hat
--   - comment_created_at	: Das Datum und die Uhrzeit, wann der Kommentar erstellt wurde
--   - comment_text			: Der Inhalt des Kommentars

--=====================================================================

CREATE OR ALTER VIEW [dbo].[View_Posts_With_Comments_And_User_Details]
AS
SELECT TOP (100) PERCENT

	dbo.BlogPosts.post_id,
	dbo.BlogPosts.post_title,
	dbo.UserAccount.username AS commenter_username,
	dbo.Comments.created_at AS comment_created_at,
	dbo.Comments.comment_text

FROM            
	dbo.Comments 
INNER JOIN
	dbo.BlogPosts 
	ON dbo.Comments.post_id = dbo.BlogPosts.post_id 
INNER JOIN
	dbo.UserAccount 
	ON dbo.Comments.account_id = dbo.UserAccount.account_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[16] 2[13] 3) )"
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
         Begin Table = "Comments"
            Begin Extent = 
               Top = 66
               Left = 70
               Bottom = 238
               Right = 265
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BlogPosts"
            Begin Extent = 
               Top = 271
               Left = 396
               Bottom = 492
               Right = 569
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserAccount"
            Begin Extent = 
               Top = 8
               Left = 400
               Bottom = 256
               Right = 570
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
         Width = 1080
         Width = 3615
         Width = 2475
         Width = 2145
         Width = 2400
         Width = 2880
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2340
         Table = 1875
         Output = 1710
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Posts_With_Comments_And_User_Details'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Posts_With_Comments_And_User_Details'
GO


