CREATE TABLE [dbo].[NavigationObject] (
    [object_nav_key]    BIGINT           IDENTITY (1, 1) NOT NULL,
    [community_id]      UNIQUEIDENTIFIER NOT NULL,
    [object_guid]       UNIQUEIDENTIFIER NOT NULL,
    [object_type]       INT              NOT NULL,
    [parent_guid]       UNIQUEIDENTIFIER NULL,
    [parent_type]       INT              NULL,
    [is_disabled]       BIT              CONSTRAINT [DF_dboNavigationObject_IsDisabled_0] DEFAULT ((0)) NULL,
    [url_node]          NVARCHAR (200)   NOT NULL,
    [url_full]          NVARCHAR (2400)  NOT NULL,
    [url_hash]          AS               (CONVERT([binary](20),hashbytes('SHA1',lower([url_full])),(0))) PERSISTED NOT NULL,
    [parent_space_guid] UNIQUEIDENTIFIER NULL,
    [depth]             AS               (len([url_full])-len(replace([url_full],N'/',N''))) PERSISTED NOT NULL,
    CONSTRAINT [PK_dboNavigationObject] PRIMARY KEY CLUSTERED ([object_nav_key] ASC),
    CONSTRAINT [CHK_dboNavigationObject_MaxDepth100] CHECK ([depth]<=(100)),
    CONSTRAINT [FK_dboNavigationObject_CommunityGUID] FOREIGN KEY ([community_id]) REFERENCES [dbo].[Community] ([ID]),
    CONSTRAINT [FK_dboNavigationObject_ObjectGUID] FOREIGN KEY ([object_guid]) REFERENCES [object].[object] ([pkobjectid]),
    CONSTRAINT [FK_dboNavigationObject_ObjectType] FOREIGN KEY ([object_type]) REFERENCES [object].[type] ([pktypeid]),
    CONSTRAINT [FK_dboNavigationObject_ParentGUID] FOREIGN KEY ([parent_guid]) REFERENCES [object].[object] ([pkobjectid]),
    CONSTRAINT [FK_dboNavigationObject_ParentObjectType] FOREIGN KEY ([parent_type]) REFERENCES [object].[type] ([pktypeid]),
    CONSTRAINT [FK_dboNavigationObject_ParentSpace] FOREIGN KEY ([parent_space_guid]) REFERENCES [object].[object] ([pkobjectid])
);


GO
CREATE NONCLUSTERED INDEX [UQI_dboNavigationObject_SpaceMembership]
    ON [dbo].[NavigationObject]([parent_space_guid] ASC, [community_id] ASC, [object_guid] ASC)
    INCLUDE([is_disabled]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IXI_dboNavigationObject_ParentGUID]
    ON [dbo].[NavigationObject]([parent_guid] ASC, [community_id] ASC, [is_disabled] ASC)
    INCLUDE([object_guid], [object_type], [parent_type], [parent_space_guid]) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQI_dboNavigationObject_Node]
    ON [dbo].[NavigationObject]([object_guid] ASC, [community_id] ASC, [is_disabled] ASC)
    INCLUDE([parent_space_guid], [parent_guid], [url_full], [object_type]);


GO
CREATE NONCLUSTERED INDEX [IXI_dboNavigationObject_CommunityObjType]
    ON [dbo].[NavigationObject]([community_id] ASC, [object_type] ASC)
    INCLUDE([object_guid], [parent_space_guid], [parent_type], [is_disabled], [parent_guid], [url_full]);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_dboNavigationObject_URLHash]
    ON [dbo].[NavigationObject]([community_id] ASC, [url_hash] ASC, [is_disabled] ASC);

