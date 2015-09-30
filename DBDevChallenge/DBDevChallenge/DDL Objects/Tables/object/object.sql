CREATE TABLE [object].[object] (
    [pkobjectid]   UNIQUEIDENTIFIER NOT NULL,
    [fkparentid]   UNIQUEIDENTIFIER NULL,
    [title]        NVARCHAR (512)   NULL,
    [fktypeid]     INT              NOT NULL,
    [createddate]  DATETIME         NOT NULL,
    [createdby]    UNIQUEIDENTIFIER NOT NULL,
    [modifieddate] DATETIME         NULL,
    [modifiedby]   UNIQUEIDENTIFIER NULL,
    [recycledid]   UNIQUEIDENTIFIER NULL,
    [description]  NVARCHAR (MAX)   NULL,
    [object_key]   BIGINT           IDENTITY (0, 1) NOT NULL,
    CONSTRAINT [PK_objectObject] PRIMARY KEY CLUSTERED ([pkobjectid] ASC),
    CONSTRAINT [FK_object_type] FOREIGN KEY ([fktypeid]) REFERENCES [object].[type] ([pktypeid]),
    CONSTRAINT [FK_objObject_Creator] FOREIGN KEY ([createdby]) REFERENCES [dbo].[tblUsers] ([User_Id]),
    CONSTRAINT [FK_objObject_ModdedBy] FOREIGN KEY ([modifiedby]) REFERENCES [dbo].[tblUsers] ([User_Id]),
    CONSTRAINT [UQ_objectObject_ObjectKey] UNIQUE NONCLUSTERED ([object_key] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_objectObject_ObjectType]
    ON [object].[object]([fktypeid] ASC, [recycledid] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IXI_objectObject_ParentChild]
    ON [object].[object]([fkparentid] ASC, [fktypeid] ASC)
    INCLUDE([title], [modifieddate], [recycledid], [createddate]);


GO
CREATE NONCLUSTERED INDEX [IXI_objectObject_modDate_RecycledID]
    ON [object].[object]([recycledid] ASC, [modifieddate] ASC)
    INCLUDE([pkobjectid], [fktypeid]);


GO
CREATE NONCLUSTERED INDEX [IXI_objectObject_CreatedDate]
    ON [object].[object]([createddate] ASC)
    INCLUDE([pkobjectid], [recycledid]);

