CREATE INDEX IDX_Tenants_TenantID ON Tenants (TenantID);
CREATE INDEX IDX_Users_UserID_TenantID ON Users (UserID, TenantID);
CREATE INDEX IDX_Tasks_TaskID_TenantID ON Tasks (TaskID, TenantID);
CREATE INDEX IDX_Tasks_CreatedByUserID ON Tasks (CreatedByUserID);
CREATE INDEX IDX_TaskHistory_TaskID ON TaskHistory (TaskID);