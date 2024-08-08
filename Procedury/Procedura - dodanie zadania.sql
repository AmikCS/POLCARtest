USE [Polcar_test]
GO
/****** Object:  StoredProcedure [dbo].[AddTask]    Script Date: 08.08.2024 20:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[AddTask]
	@TenantID INT,
	@CreatedByUserId INT,
	@Title VARCHAR(200),
	@Priority VARCHAR(50),
	@Descriptions VARCHAR(MAX),
	@STATUS VARCHAR(50)
AS
BEGIN
	INSERT INTO Tasks (TenantID, CreatedByUserID, Title, Priority, Descriptions, Status)
	VALUES(@TenantID, @CreatedByUserId, @Title, @Priority, @Descriptions, @STATUS);
END;
