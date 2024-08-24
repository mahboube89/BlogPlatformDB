USE [BlogPlatformDB]
GO

/****** Object:  View [dbo].[View_Comments_With_Replies]    Script Date: 8/9/2024 9:38:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--==========| View_Comments_With_Replies |==========--
--========================================================

-- Beschreibung:	Diese View zeigt Kommentare und ihre verschachtelten Antworten 
--					für jeden Blog-Post an. Hauptkommentare und ihre Antworten sind miteinander verknüpft.

-- Felder:
--   - post_id				: Die ID des Blog-Posts
--   - comment_id			: Die ID des Hauptkommentars
--   - comment_text			: Der Text des Hauptkommentars
--   - reply_id				: Die ID der Antwort (falls vorhanden)
--   - reply_text			: Der Text der Antwort (falls vorhanden)
--   - commenter_username	: Der Benutzername des Hauptkommentators
--   - replier_username		: Der Benutzername der antwortenden Person

--========================================================

CREATE VIEW [dbo].[View_Comments_With_Replies]
AS
SELECT

	dbo.Comments.post_id,
	dbo.Comments.comment_id,
	dbo.Comments.comment_text,
	dbo.Comments.created_at AS comment_created_at,
	dbo.UserAccount.username AS commenter_username,
	Reply.comment_id AS reply_id,
	Reply.comment_text AS reply_text,
	Reply.created_at AS reply_created_at,
	UserAccount_1.username AS replier_username

FROM
	dbo.Comments 
LEFT OUTER JOIN
    dbo.Comments AS Reply 
	ON Reply.parent_comment_id = dbo.Comments.comment_id 
LEFT OUTER JOIN
    dbo.UserAccount 
	ON dbo.Comments.account_id = dbo.UserAccount.account_id 
LEFT OUTER JOIN
    dbo.UserAccount AS UserAccount_1 
	ON Reply.account_id = UserAccount_1.account_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[28] 2[12] 3) )"
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
               Top = 83
               Left = 261
               Bottom = 263
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Comments_1"
            Begin Extent = 
               Top = 85
               Left = 523
               Bottom = 264
               Right = 718
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserAccount"
            Begin Extent = 
               Top = 22
               Left = 3
               Bottom = 261
               Right = 173
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserAccount_1"
            Begin Extent = 
               Top = 20
               Left = 786
               Bottom = 260
               Right = 956
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
      Begin ColumnWidths = 10
         Width = 284
         Width = 1005
         Width = 1275
         Width = 2520
         Width = 2505
         Width = 2490
         Width = 1395
         Width = 1875
         Width = 1965
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2775
         Table = 1695
         Output = 1410
         Append = 1400
         NewValue = 1170
         SortType = 1650
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Comments_With_Replies'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Comments_With_Replies'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Comments_With_Replies'
GO


