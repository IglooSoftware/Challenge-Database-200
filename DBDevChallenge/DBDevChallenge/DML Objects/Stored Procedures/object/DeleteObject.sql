
CREATE PROCEDURE object.DeleteObject
    @ObjectID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    --Need to get FKs first

    DELETE FROM dbo.NavigationContent WHERE object_guid = @ObjectID;

    DELETE FROM dbo.NavigationObject WHERE object_guid = @ObjectID;

    UPDATE object.object
        SET recycledid = NEWID()
    WHERE pkobjectid = @ObjectID;

END