
EXEC [deploy].LoadObjectType 1, N'Document', 'A document.', 1;
EXEC [deploy].LoadObjectType 2, N'Folder', 'A folder. Holds a collection of folders and/or documents.', 0, 0, 1;
EXEC [deploy].LoadObjectType 3, N'Community', 'A community object. Top level container.';
EXEC [deploy].LoadObjectType 6, N'Forum Channel', 'A forum channel. Holds a collection of forum topics.', 0, 1, 1;
EXEC [deploy].LoadObjectType 9, N'Blog Article', 'A blog article.', 1;
EXEC [deploy].LoadObjectType 18, N'Forum Topic', 'A forum topic.', 1;
EXEC [deploy].LoadObjectType 27, N'Wiki Article', 'A wiki article.', 1;
EXEC [deploy].LoadObjectType 28, N'Wiki Channel', 'A wiki channel. Holds a collection of wiki articles.', 0, 1, 1;
EXEC [deploy].LoadObjectType 42, N'Microblog Channel', 'A micro blog channel.', 0, 1, 1;
EXEC [deploy].LoadObjectType 43, N'Microblog Post', 'A micro blog post.', 1;
EXEC [deploy].LoadObjectType 517, N'Page', 'A page. Container for other containers.', 0, 0, 1;
EXEC [deploy].LoadObjectType 521, N'Space', 'A space object. Container for other containers, excluding other spaces.', 0, 0, 1;
GO