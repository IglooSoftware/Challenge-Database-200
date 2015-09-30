# Code-Challenge-DB
Our code challenge for anyone interested in being a database developer here at Igloo.

# Background
You are a new database developer at iGleww Inc. iGleww sells a cloud-based solution that allows customers to create communities and then add content (wikis, blogs, documents, etc.) to those communities.
iGleww has had a lot of different developers or varying degrees of skill modify their database over the years and the current state of the database is poor. 
iGleww has hired a solid team of data professionals now and they are working toward paying off a lot of technical debt.

# Instructions
Below you will find a series of tasks. To complete each task you will need to use SQL Server and/or Visual Studio. In doing so you will typically generate TSQL scripts and potentially modify the Database project. On some occasions
a text file may be all you need to answer questions. In each case create a directory named for the task number (under a single root directorym eg. "IglooDBChallenge") and store any and all work generated. If you modify the database project or any 
of its files, include the entire solution directory.


# Tasks
1. The table object.object contains a list of all objects the iGleww cloud solution can work with. When an object is flagged for deletion, the recycledid column will be non-NULL and when the object is not flagged the value is NULL.
   A team member has asked you to write a script that will return pkobjectid, createddate, and a bool (column name: is_deleted) indicating whether the object is deleted or not for all rows in the table.

2. The query you wrote in task 2 turned out to be useful, but the team wants to be able to quickly switch between returning deleted and undeleted objects. Write a query that will return the same columns from task 1, but only deleted or non-deleted objects based on a parameter.
The parameter should be a bool and return enabled objects when true, deleted when false.

3. One of the front end developers got a hold of your query from task 2. They are demoing a proof-of-concept recycle bin function based on it. You run the query.
   a) Do you notice the results coming back in any discernable order? 
   b) If so, what order? 
   c) The Jr. DBA isn't convinced that you're correct. How can you prove to them that you are correct?
   d) Can the front end developer depend on the results always returning this way? If so, why? If not, why not?

4. The Jr. DBA is swamped and needs some help. Please provide them with a query that will return the names and schemas of each iGleww-created stored procedure in the database.

5. There are two 'navigation' tables in the database: NavigationObject and NavigationContent. These tables model the parent-child hierarchy that exists between iGleww communities, containers, and content. Content objects are leaf-level
   objects, never have children, and are stored in the NavigationObject table. Containers have parents and children with the exception of community objects which are root objects and are object_type 3.
   You have been tasked with writing a recursive query that returns community_guid, object_guid, parent_guid, and is_disabled for all container and content objects in the community with object_guid = 'DF5E1A78-0973-4B02-AC33-5FF211F115B4'.

6. Your code from task 5 was submitted for review and the Sr. database developer wasn't impressed with the performance or complexity. Write this query again so that it returns the same results but doesn't use recursion.

7.    

   
   
-=WORK IN PROGRESS=-
   
   
When you complete all the tasks, zip up the "IglooDBChallenge" directory and submit your archive to careers@igloosoftware.com.