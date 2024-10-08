USE [Polcar_test]
GO
/****** Object:  StoredProcedure [dbo].[GenerateTaskNotifications]    Script Date: 08.08.2024 21:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GenerateTaskNotifications]
AS
BEGIN
    SET NOCOUNT ON;

-- Powiadomienia o terminie
    INSERT INTO Notifications (UserID, Message)
    SELECT CreatedByUserID, 'Zbliża się termin zakończenia zadania: ' + Title
    FROM Tasks
    WHERE DATEDIFF(DAY, GETDATE(), CreatedDate) <= 7 AND Status = 'W toku';
END;


INSERT INTO Tasks (TenantID, CreatedByUserID, Title, Priority, Descriptions, Status, CreatedDate)
VALUES 
(1, 1, 'Zadanie 1', 'Wysoki', 'Opis zadania 1', 'W toku', DATEADD(DAY, -3, GETDATE())),
(1, 2, 'Zadanie 2', 'Sredni', 'Opis zadania 2', 'W toku', DATEADD(DAY, -5, GETDATE())),
(1, 3, 'Zadanie 3', 'Niski', 'Opis zadania 3', 'Nowe', DATEADD(DAY, -1, GETDATE()));


EXEC dbo.GenerateTaskNotifications;

SELECT * FROM notifications;