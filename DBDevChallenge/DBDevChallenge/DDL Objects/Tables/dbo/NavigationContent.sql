CREATE TABLE [dbo].[NavigationContent] (
    [content_nav_key]   BIGINT           IDENTITY (-9223372036854775808, 1) NOT NULL,
    [community_id]      UNIQUEIDENTIFIER NOT NULL,
    [object_guid]       UNIQUEIDENTIFIER NOT NULL,
    [object_type]       INT              NOT NULL,
    [parent_guid]       UNIQUEIDENTIFIER NULL,
    [parent_type]       INT              NULL,
    [is_disabled]       BIT              CONSTRAINT [DF_dboNavigationContent_IsDisabled_0] DEFAULT ((0)) NULL,
    [url_node]          NVARCHAR (200)   NOT NULL,
    [url_full]          NVARCHAR (2400)  NOT NULL,
    [url_hash]          AS               (CONVERT([binary](20),hashbytes('SHA1',lower([url_full])),(0))) PERSISTED NOT NULL,
    [depth]             AS               (len([url_full])-len(replace([url_full],N'/',N''))) PERSISTED NOT NULL,
    [parent_space_guid] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_dboNavigationContent] PRIMARY KEY CLUSTERED ([content_nav_key] ASC),
    CONSTRAINT [CHK_dboNavigationContent_MaxDepth100] CHECK ([depth]<=(100)),
    CONSTRAINT [FK_dboNavigationContent_ObjectGUID] FOREIGN KEY ([object_guid]) REFERENCES [object].[object] ([pkobjectid]),
    CONSTRAINT [FK_dboNavigationContent_ObjectType] FOREIGN KEY ([object_type]) REFERENCES [object].[type] ([pktypeid]),
    CONSTRAINT [FK_dboNavigationContent_ParentGUID] FOREIGN KEY ([parent_guid]) REFERENCES [object].[object] ([pkobjectid]),
    CONSTRAINT [FK_dboNavigationContent_ParentObjectType] FOREIGN KEY ([parent_type]) REFERENCES [object].[type] ([pktypeid])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQI_dboNavigationContent_ChannelParent]
    ON [dbo].[NavigationContent]([parent_guid] ASC, [community_id] ASC, [object_guid] ASC)
    INCLUDE([url_full], [url_node], [object_type], [parent_space_guid], [is_disabled]) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQI_dboNavigationContent_Object]
    ON [dbo].[NavigationContent]([object_guid] ASC, [community_id] ASC, [is_disabled] ASC)
    INCLUDE([parent_guid], [url_full], [object_type], [parent_space_guid]) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_dboNavigationContent_UrlHash]
    ON [dbo].[NavigationContent]([community_id] ASC, [url_hash] ASC);


GO
CREATE NONCLUSTERED INDEX [IXI_dboNavigationContentSpaceMembership]
    ON [dbo].[NavigationContent]([parent_space_guid] ASC, [is_disabled] ASC)
    INCLUDE([object_type], [parent_type], [object_guid], [community_id]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IXI_dboNavigationContent_CommunityObjType]
    ON [dbo].[NavigationContent]([community_id] ASC, [object_type] ASC)
    INCLUDE([is_disabled], [object_guid], [parent_space_guid]);

