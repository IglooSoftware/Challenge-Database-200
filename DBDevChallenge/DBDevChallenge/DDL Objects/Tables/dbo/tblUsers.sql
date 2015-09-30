CREATE TABLE [dbo].[tblUsers] (
    [User_Id]                     UNIQUEIDENTIFIER CONSTRAINT [DF_tblUsr_newID] DEFAULT (newsequentialid()) NOT NULL,
    [UserName]                    NVARCHAR (100)   NOT NULL,
    [FName]                       NVARCHAR (70)    NULL,
    [MName]                       NVARCHAR (50)    NULL,
    [LName]                       NVARCHAR (70)    NULL,
    [Creation_DateTime]           DATETIME         CONSTRAINT [DF_Users_Creation_DateTime] DEFAULT (getdate()) NOT NULL,
    [Modified_DateTime]           DATETIME         CONSTRAINT [DF_Users_Modified_DateTime] DEFAULT (getdate()) NOT NULL,
    [Status]                      BIT              CONSTRAINT [DF_Users_Status] DEFAULT ((0)) NOT NULL,
    [CommunityLastLogin_DateTime] DATETIME         NULL,
    [preferredEmail]              NVARCHAR (100)   NULL,
    [email]                       AS               (isnull([preferredEmail],[UserName])) PERSISTED NOT NULL,
    CONSTRAINT [PK_dboIGLOOUsers] PRIMARY KEY CLUSTERED ([User_Id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQI_IGLOO_Users_Username]
    ON [dbo].[tblUsers]([UserName] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_dboIGLOOUsers_Email]
    ON [dbo].[tblUsers]([email] ASC);

