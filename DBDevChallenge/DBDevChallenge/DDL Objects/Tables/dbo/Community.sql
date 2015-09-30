CREATE TABLE [dbo].[Community] (
    [ID]                UNIQUEIDENTIFIER CONSTRAINT [DF_dboCommunity_NewSeqID] DEFAULT (newsequentialid()) NOT NULL,
    [DomainName]        NVARCHAR (128)   NOT NULL,
    [Name]              NVARCHAR (200)   NULL,
    [communityLanguage] NVARCHAR (50)    CONSTRAINT [DF_dboCommunity_communityLanguage] DEFAULT ('en') NOT NULL,
    [tzAbbr]            NVARCHAR (100)   NULL,
    CONSTRAINT [PK_dboCommunity] PRIMARY KEY CLUSTERED ([ID] ASC), 
    CONSTRAINT [FK_Community_Object] FOREIGN KEY (ID) REFERENCES object.object (pkobjectid)
);

