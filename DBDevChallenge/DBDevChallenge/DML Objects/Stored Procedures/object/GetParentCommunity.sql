
CREATE PROCEDURE object.GetParentCommunity
    @URL NVARCHAR(2400),
    @CommunityGUID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @URLHash BINARY(16) = HASHBYTES('SHA1', LOWER(@URL)),
        @ObjectId UNIQUEIDENTIFIER,
        @ParentId UNIQUEIDENTIFIER;

    SET @ParentId = (SELECT parent_guid FROM dbo.NavigationContent WHERE url_hash = @URLHash AND community_id = @CommunityGUID 
    UNION ALL SELECT parent_guid FROM dbo.NavigationContent WHERE url_hash = @URLHash AND community_id = @CommunityGUID); 

    WITH ObjectParents AS
    (
        SELECT  
            object_guid
        FROM dbo.NavigationObject
        WHERE object_guid = @ParentId
            AND community_id = @CommunityGUID
        UNION ALL
        SELECT  
            c.object_guid
        FROM dbo.NavigationObject c
        JOIN ObjectParents p
            ON p.object_guid = c.parent_guid
            AND c.community_id = @CommunityGUID
    )
    SELECT  
        o.*
    FROM ObjectParents op
    JOIN object.object o
        ON op.object_guid = o.pkobjectid
    WHERE o.fktypeid = 3;

END