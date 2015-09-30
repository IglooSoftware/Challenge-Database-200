CREATE TABLE [dbo].[Person_community_Membership] (
    [userID] UNIQUEIDENTIFIER NOT NULL,
    [com_id] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([com_id] ASC, [userID] ASC),
    CONSTRAINT [FK_PCM_CommunityID] FOREIGN KEY ([com_id]) REFERENCES [dbo].[Community] ([ID]),
    CONSTRAINT [FK_PCM_Usr] FOREIGN KEY ([userID]) REFERENCES [dbo].[tblUsers] ([User_Id])
);

