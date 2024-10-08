USE [Polcar_test]
GO
/****** Object:  StoredProcedure [dbo].[GetStats]    Script Date: 08.08.2024 20:36:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetStats]
	@TenantID INT,
	@ManaagerID INT 
AS 
BEGIN
	SELECT 
		u.UserID, u.Username, t.status, COUNT(t.TaskID) AS TaskCount, MONTH(t.CreatedDate) AS TaskMonth
	FROM USERS u
	JOIN Tasks T ON u.UserID = t.CreatedByUserID
	WHERE u.TenantID = @TenantID AND u.UserID IN 
			(SELECT UserID 
			FROM USERS
			WHERE TenantID = @TenantID)
	GROUP BY u.userID, u.UserName, t.status, MONTH(t.CreatedDate);
END;