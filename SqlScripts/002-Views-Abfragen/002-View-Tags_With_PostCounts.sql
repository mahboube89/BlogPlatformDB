USE [BlogPlatformDB]
GO

/****** Object:  View [dbo].[View_Tags_With_PostCounts]    Script Date: 8/9/2024 9:55:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--==========| View_Tags_With_PostCounts |==========--
--=================================================

-- Beschreibung:	Diese View liefert eine �bersicht �ber die Anzahl der Blog-Posts pro Tag.
--					Die Tags werden nach ihrer H�ufigkeit in den Blog-Posts gruppiert und gez�hlt.

-- Felder:
--   - tag_name		: Der Name des Tags
--   - post_count	: Die Anzahl der Blog-Posts, die diesem Tag zugeordnet sind

--==================================================

CREATE VIEW [dbo].[View_Tags_With_PostCounts]
AS
SELECT

	dbo.Tags.tag_name,
	COUNT(dbo.PostTags.post_id) AS post_count -- Die Anzahl der Blog-Posts f�r diesen Tag
FROM            
	dbo.PostTags 
INNER JOIN
    dbo.Tags 
	ON dbo.PostTags.tag_id = dbo.Tags.tag_id 
INNER JOIN
    dbo.BlogPosts 
	ON dbo.PostTags.post_id = dbo.BlogPosts.post_id

GROUP BY
	dbo.Tags.tag_name

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[13] 3) )"
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
         Begin Table = "PostTags"
            Begin Extent = 
               Top = 13
               Left = 381
               Bottom = 109
               Right = 551
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tags"
            Begin Extent = 
               Top = 30
               Left = 119
               Bottom = 139
               Right = 289
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BlogPosts"
            Begin Extent = 
               Top = 11
               Left = 633
               Bottom = 230
               Right = 803
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
         Width = 1500
         Width = 2460
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1920
         Alias = 2265
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Tags_With_PostCounts'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Tags_With_PostCounts'
GO


