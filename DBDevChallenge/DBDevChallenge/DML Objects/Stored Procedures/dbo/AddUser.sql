

CREATE PROCEDURE dbo.AddUser
    @UserName NVARCHAR(100),
    @Name NVARCHAR(256),
    @MiddleName NVARCHAR(25),
    @LastName VARCHAR(70),
    @Created DATETIME,
    @Community UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @User_Id UNIQUEIDENTIFIER = NEWID(),
        @TodayNow DATETIME = GETDATE();

    INSERT INTO dbo.tblUsers ([User_Id], UserName, FName, MName, LName, [Status])
        VALUES (@User_Id, @UserName, @Name, @MiddleName, @LastName, 0);
        
    INSERT INTO dbo.Person_community_Membership (userID, com_id)
        VALUES (@User_Id, @Community);

    UPDATE dbo.tblUsers
        SET [Status] = 1
    WHERE [User_Id] = @User_Id;

END