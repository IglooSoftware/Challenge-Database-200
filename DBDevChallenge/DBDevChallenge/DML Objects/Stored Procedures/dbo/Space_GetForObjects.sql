
CREATE PROCEDURE dbo.Space_GetForObjects
    @Objects dbo.GuidList READONLY
AS
BEGIN
    SET NOCOUNT ON;

    SELECT  
        o.object_uid,
        o.community_id
    FROM 
    (
        SELECT  
            n.community_id,
            o.item AS object_uid
        FROM @Objects o
        JOIN dbo.NavigationObject n
            ON o.item = n.object_guid
        UNION ALL
        SELECT  
            n.community_id,
            o.item AS object_uid
        FROM @Objects o
        JOIN dbo.NavigationContent n
            ON o.item = n.object_guid
    ) o;

END