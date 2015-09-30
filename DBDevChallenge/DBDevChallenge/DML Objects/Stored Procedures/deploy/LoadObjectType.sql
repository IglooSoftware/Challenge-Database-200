
CREATE PROCEDURE [deploy].LoadObjectType
    @TypeID INT,
    @Name NVARCHAR(50),
    @Description VARCHAR(100),
    @IsContent BIT = 0,
    @IsChannel BIT = 0,
    @IsContainer BIT = 0,
    @IsApplication BIT = 0
AS
BEGIN
    SET NOCOUNT ON;
    
    IF (@Name IS NULL)
    BEGIN
        SET @Name = CAST(NEWID() AS NVARCHAR(38));
    END

    IF (@TypeID IS NULL OR @Description IS NULL)
    BEGIN
        RAISERROR('@TypeID and @Description cannot be NULL!', 16,1);
        RETURN 1;
    END
    
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM object.type WHERE pktypeid = @TypeID)
        BEGIN
            INSERT INTO object.type (pktypeid, name, description, is_content, is_channel, is_container)
                VALUES (@TypeID, @name, @description, @IsContent, @IsChannel, @IsContainer);
        END;
        ELSE
        BEGIN
            UPDATE object.type
                SET name = @name,
                    description = @description,
                    is_content = @IsContent,
                    is_channel = @IsChannel,
                    is_container = @IsContainer
                WHERE pktypeid = @TypeID;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = N'Failed to add object type: %i with name: %s' + NCHAR(13) + N'Err: ' + ERROR_MESSAGE();
            
        RAISERROR(@ErrorMessage, 16, 1, @TypeID, @Name);
        RETURN 1;
    END CATCH
    
    RETURN 0;
END