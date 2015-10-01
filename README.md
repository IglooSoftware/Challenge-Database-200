# Code-Challenge-DB
Our code challenge for anyone interested in being a database developer here at Igloo.

## Background
You are a new database developer at iGleww Inc. iGleww sells a cloud-based solution that allows customers to create communities and then add content (wikis, blogs, documents, etc.) to those communities.
iGleww has had a lot of different developers or varying degrees of skill modify their database over the years and the current state of the database is poor. 
iGleww has hired a solid team of data professionals now and they are working toward paying off a lot of technical debt.

## Instructions
Below you will find a series of tasks. To complete each task you will need to use SQL Server and/or Visual Studio. In doing so you will typically generate TSQL scripts and potentially modify the Database project. On some occasions
a text file may be all you need to answer questions. In each case create a directory named for the task number (under a single root directorym eg. "IglooDBChallenge") and store any and all work generated. If you modify the database project or any 
of its files, include the entire solution directory.


## Tasks
### Task 1
The table object.object contains a list of all objects the iGleww cloud solution can work with. When an object is flagged for deletion, the recycledid column will be non-NULL and when the object is not flagged the value is NULL. A team member has asked you to write a script that will return pkobjectid, createddate, and a bool (column name: is_deleted) indicating whether the object is deleted or not for all rows in the table.

### Task 2
The query you wrote in task 2 turned out to be useful, but the team wants to be able to quickly switch between returning deleted and undeleted objects. Write a query that will return the same columns from task 1, but only deleted or non-deleted objects based on a parameter. The parameter should be a bool and return enabled objects when true, deleted when false.

### Task 3
One of the front end developers got a hold of your query from task 2. They are demoing a proof-of-concept recycle bin function based on it. You run the query.  
a) Do you notice the results coming back in any discernable order?  
b) If so, what order?  
c) The Jr. DBA isn't convinced that you're correct. How can you prove to them that you are correct?  
d) Can the front end developer depend on the results always returning this way? Why or why not?

### Task 3
The DBA team is swamped and needs some help. Please provide them with a query that will return the names and schema names of each iGleww created stored procedure in the database.

### Task 4
There are two 'navigation' tables in the database: NavigationObject and NavigationContent. These tables model the parent-child hierarchy that exists between iGleww communities, containers, and content. Content objects are leaf-level objects, never have children, and are stored in the NavigationObject table. Containers have parents and children with the exception of community objects which are root objects and are object_type 3. You have been tasked with writing a recursive query that returns community_guid, object_guid, parent_guid, and is_disabled for all container and content objects in the community with object_guid = 'DF5E1A78-0973-4B02-AC33-5FF211F115B4'.

### Task 5
Your code from task 5 was submitted for review but the data team wasn't impressed with the performance or complexity during the review cycle. Write this query again so that it returns the same results but doesn't use recursion.

### Task 6
The data team has agreed on a naming convention for DDL objects in the iGleww database. The naming convention is as follows:  
> 1. Table names will not contain abbreviations.  
> 2. Table names will not contain underscores, special characters, numbers, or be reserved words.  
> 3. Table names must be able to be referenced without block identifiers.  
> 4. Views will carry the prefix v, tables will contain no prefixes.  
> 5. Table names will be in PascalCase.  
> 6. Using plurals is appropriate for tables that define multiple relations. Eg. FoosBars would be an appropriate name for a table where the rows describe relations between one or more Foos and one or more Bars.  

Armed with this knowledge (and your own good judgement and knowledge of best practices) you have been tasked with renaming any tables that aren't named correctly.  
Use comments in the TSQL scripts to provide reasoning for naming choices made. Provide one or more change scripts (generated however you feel is best) that will result in the schema being updated without data loss and with all DDL and DML dependencies fully functional.  

### Task 7
The deployment team has asked that you provide a DACPac file to them for deployment. The previous version deployed is 1.0.0.0 and the Data Architect at iGleww has seen your changes and asked that you bump the minor version in the DACPac by one. Create the DACPac file and submit it along with a text file that explains how the deployment team can deploy it to their staging MS SQL Server (sqlAyyz.staging.igleww.com) via the command line.

### Task 8
The deployment team liked your submission from task 8, and they want a PowerShell script to run it for them with the mandatory command line parameters but their PS expert is on vacation. Can you provide a script they can use?

### Task 9
The production DBAs have noticed a performance problem! They have determined that a platform DAL call which gets a community ID for a URL is being called with high frequency and that it ultimately calls the stored procedure *object.GetParentCommunity*. You take a look and realize the procedure is very old and via a source control check note it was written by a JS developer...  
You have been tasked with fixing this procedure to ensure it returns the following attributes for the parent community object in the most efficient manner possible.  
Params: object GUID, title, createddate.
Changing input paramaters *is* an option in this case.

### Task 10
The platform team has updated their code and now they only need the community GUID for a series of objects passed in. You've been tasked with providing them a stored procedure they can call to get parent community GUIDs for C# lists of object GUIDs passed in.



   
   
-=WORK IN PROGRESS=-
   
   
When you complete all the tasks, zip up the "IglooDBChallenge" directory and submit your archive to careers@igloosoftware.com.