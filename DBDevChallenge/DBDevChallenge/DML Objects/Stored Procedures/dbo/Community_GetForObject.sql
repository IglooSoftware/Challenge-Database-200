
CREATE PROCEDURE dbo.Community_GetForObject
    @ObjectID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT  
        oc.community_id
    FROM 
    (
        SELECT  
            community_id
        FROM dbo.NavigationObject
        WHERE object_guid = @ObjectID
        UNION ALL
        SELECT  
            community_id
        FROM dbo.NavigationContent
        WHERE object_guid = @ObjectID
    ) oc;

END