USE [Polcar_test]
GO
/****** Object:  StoredProcedure [dbo].[ArchiveOldTasks]    Script Date: 08.08.2024 20:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ArchiveOldTasks]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SixMonthsAgo DATETIME = DATEADD(MONTH, -6, GETDATE());

----- przenoszenie zadania jak jest starsze niż 6 msc
    INSERT INTO ArchivedTasks (OriginalTaskID, TenantID, CreatedByUserID, Title, Priority, Descriptions, Status, CreatedDate)
    SELECT TaskID, TenantID, CreatedByUserID, Title, Priority, Descriptions, Status, CreatedDate
    FROM Tasks
    WHERE Status = 'Zakonczone' AND CreatedDate < @SixMonthsAgo;

----- usuowanie zadań jak zakończone i starsze niż 6 miesięcy
    DELETE FROM Tasks
    WHERE Status = 'Zakonczone' AND CreatedDate < @SixMonthsAgo;
END;
