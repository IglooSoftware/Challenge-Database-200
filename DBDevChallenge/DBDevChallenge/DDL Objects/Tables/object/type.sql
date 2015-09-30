CREATE TABLE [object].[type] (
    [pktypeid]       INT           NOT NULL,
    [name]           NVARCHAR (50) NOT NULL,
    [description]    VARCHAR (100) NULL,
    [is_content]     BIT           CONSTRAINT [DF_objectType_IsContent_0] DEFAULT ((0)) NOT NULL,
    [is_channel]     BIT           CONSTRAINT [DF_objectType_IsChannel_0] DEFAULT ((0)) NOT NULL,
    [is_container]   BIT           CONSTRAINT [DF_objectType_IsContainer_0] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_objectType] PRIMARY KEY CLUSTERED ([pktypeid] ASC),
    CONSTRAINT [UQ_objectType_Name] UNIQUE NONCLUSTERED ([name] ASC)
);

