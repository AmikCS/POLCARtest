USE [Polcar_test]
GO
/****** Object:  StoredProcedure [dbo].[UpdateTask]    Script Date: 08.08.2024 20:36:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UpdateTask]
	@TaskID INT,
	@ChangedByUserID INT,
	@Title VARCHAR(200) = NULL,
	@Priority VARCHAR(50) = NULL,
	@Descriptions VARCHAR(MAX) = NULL,
	@Status VARCHAR(50) = NULL
AS
BEGIN 
	INSERT INTO TaskHistory (TaskID, ChangedByUserID, Title, Priority, Descriptions, Status)
	SELECT TaskID, @ChangedByUserID, Title, Priority, Descriptions, Status FROM TASKS WHERE TaskID = @TaskID;
	UPDATE TASKS
	SET Title = ISNULL(@Title, TITLE),
		Priority = ISNULL(@Priority, Priority),
		Descriptions = ISNULL(@Descriptions, Descriptions),
		Status = ISNULL(@Status, Status)
	WHERE TaskID = @TaskID;
END;