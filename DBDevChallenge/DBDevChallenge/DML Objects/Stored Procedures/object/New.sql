
CREATE PROCEDURE object.New
    @ObjectID UNIQUEIDENTIFIER,
    @ParentID UNIQUEIDENTIFIER = NULL,
    @Title NVARCHAR(512),
    @ObjectType TINYINT,
    @CreatedDate DATETIME,
    @CreatedByUserID UNIQUEIDENTIFIER,
    @Description NVARCHAR(MAX),
    @URL NVARCHAR(2400),
    @TargetCommunity UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ParentType UNIQUEIDENTIFIER;

    BEGIN TRY
        BEGIN TRANSACTION New;

        INSERT INTO object.object (pkobjectid, title, fktypeid, createddate, createdby, recycledid, [description])
            VALUES (@ObjectID, @Title, @ObjectType, @CreatedDate, @CreatedByUserID, NULL, @Description);

        IF EXISTS (SELECT * FROM object.type WHERE pktypeid = @ObjectType AND is_container = 1)
        BEGIN
            INSERT INTO dbo.NavigationObject (community_id, object_guid, object_type, parent_guid, parent_type, url_full, url_node, parent_space_guid)
                SELECT
                    @TargetCommunity,
                    @ObjectID,
                    @ObjectType,
                    @ParentID,
                    object_type,
                    @URL,
                    ISNULL(RIGHT(@URL, CHARINDEX(N'/', REVERSE(@URL))-1), N''),
                    parent_space_guid
                FROM dbo.NavigationObject WHERE object_guid = @ParentID;

            IF (@@ROWCOUNT = 0) --Probably a community object
            BEGIN 
                INSERT INTO dbo.NavigationObject (community_id, object_guid, object_type, parent_guid, parent_type, url_full, url_node, parent_space_guid)
                    VALUES (@TargetCommunity, @ObjectID, @ObjectType, NULL, NULL, N'', N'', NULL);
            END
        END
        ELSE
        BEGIN
            INSERT INTO dbo.NavigationObject (community_id, object_guid, object_type, parent_guid, parent_type, url_full, url_node, parent_space_guid)
                SELECT
                    @TargetCommunity,
                    @ObjectID,
                    @ObjectType,
                    @ParentID,
                    object_type,
                    @URL,
                    ISNULL(RIGHT(@URL, CHARINDEX(N'/', REVERSE(@URL))-1), N''),
                    parent_space_guid
                FROM dbo.NavigationObject WHERE object_guid = @ParentID;
        END

        COMMIT TRANSACTION New;
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(MAX) = ERROR_MESSAGE();
        PRINT @ErrMsg;
    END CATCH
END