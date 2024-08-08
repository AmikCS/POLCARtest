CREATE VIEW widok_UserTaskStats AS
SELECT 
    u.UserID, 
    u.Username, 
    COUNT(CASE WHEN t.Status = 'Nowe' THEN 1 END) AS NewTasks,
    COUNT(CASE WHEN t.Status = 'W toku' THEN 1 END) AS InProgressTasks,
    COUNT(CASE WHEN t.Status = 'Zakonczone' THEN 1 END) AS CompletedTasks
FROM Users u
LEFT JOIN Tasks t ON u.UserID = t.CreatedByUserID
GROUP BY u.UserID, u.Username;

CREATE VIEW widok_UserTaskCounts AS
SELECT CreatedByUserID, COUNT(*) AS TaskCount
FROM Tasks
GROUP BY CreatedByUserID;

CREATE VIEW widok_ArchivedTasks AS
SELECT * FROM TaskHistory
WHERE Status = 'Archived';

CREATE INDEX IDX_Tenants_TenantID ON Tenants (TenantID);
CREATE INDEX IDX_Users_UserID_TenantID ON Users (UserID, TenantID);
CREATE INDEX IDX_Tasks_TaskID_TenantID ON Tasks (TaskID, TenantID);
CREATE INDEX IDX_Tasks_CreatedByUserID ON Tasks (CreatedByUserID);
CREATE INDEX IDX_TaskHistory_TaskID ON TaskHistory (TaskID);