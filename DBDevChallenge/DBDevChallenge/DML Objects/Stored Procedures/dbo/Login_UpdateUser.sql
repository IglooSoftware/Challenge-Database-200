
CREATE PROCEDURE dbo.Login_UpdateUser
    @pguid_UserID UNIQUEIDENTIFIER,
    @PingDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.tblUsers
        SET CommunityLastLogin_DateTime = @PingDate
    WHERE [User_Id] = @pguid_UserID;

END