USE [Polcar_test]
GO
/****** Object:  StoredProcedure [dbo].[DeleteTask]    Script Date: 08.08.2024 20:34:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[DeleteTask]
	@TaskID INT
AS 
BEGIN
	DELETE FROM TaskHistory WHERE TaskID = @TaskID;
	DELETE FROM Tasks WHERE TaskID = @TaskID;
END;