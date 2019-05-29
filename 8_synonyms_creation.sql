-- 8 synonyms creation --
USE [s_matskiv_module_2];
GO

-- schema for synonyms creation --
CREATE SCHEMA syn;
GO

-- sysnonym to parent_author table
CREATE SYNONYM syn.author FOR dbo.parent_author
GO
-- retrieve data from synonym to parent_author
SELECT * FROM syn.author;
GO
SELECT age
FROM syn.author
WHERE first_name='Max';
GO

-- sysnonym to person_second table
CREATE SYNONYM syn.person_second FOR dbo.person_second
GO
-- retrieve data from sysnonym to get_books_of_1_edition view
SELECT *
FROM syn.person_second

-- sysnonym to get_books_of_1_edition view
CREATE SYNONYM syn.books_view FOR dbo.get_books_of_1_edition
GO
-- retrieve data from sysnonym to get_books_of_1_edition view
SELECT *
FROM syn.books_view
