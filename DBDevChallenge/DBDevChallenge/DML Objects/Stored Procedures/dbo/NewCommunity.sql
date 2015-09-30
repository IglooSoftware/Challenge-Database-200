
CREATE PROCEDURE dbo.NewCommunity
    @DomainName NVARCHAR(128),
    @Name NVARCHAR(200),
    @CommunityLanguage NVARCHAR(50),
    @CommunityTimezone NVARCHAR(20),
    @Community UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CommunityOutput TABLE
    (
        community_id UNIQUEIDENTIFIER NOT NULL
    );


    INSERT INTO dbo.Community (DomainName, Name, communityLanguage, tzAbbr)
    OUTPUT inserted.ID INTO @CommunityOutput (community_id)
        VALUES (@DomainName, @Name, @CommunityLanguage, @CommunityTimezone);
        
    SET @Community = (SELECT community_id FROM @CommunityOutput);
    
END