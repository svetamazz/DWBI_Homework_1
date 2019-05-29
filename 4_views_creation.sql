-- 4 views creation --
USE [s_matskiv_module_2];
GO
-- creation view for parent_author table --
CREATE VIEW dbo.get_author(first_name,last_name,father_name,birth_date,passport,[address])
AS
SELECT first_name,last_name,father_name,birth_date,passport,[address]
FROM parent_author
WHERE first_name LIKE 'Max';
GO
-- creation view with check option for parent_author table --
CREATE VIEW dbo.get_author_check(first_name,last_name,father_name,birth_date,passport,[address])
AS
SELECT first_name,last_name,father_name,birth_date,passport,[address]
FROM parent_author
WHERE first_name LIKE 'Max'
WITH CHECK OPTION;
GO
-- creation view for child_book table --
CREATE VIEW get_books_of_1_edition(title,price,publication_date,isbn,edition,author_id)
AS
SELECT title,price,publication_date,isbn,edition,author_id
FROM child_book
WHERE edition=1;
GO
-- creation view with check option for child_book table --
CREATE VIEW get_books_of_1_edition_check(title,price,publication_date,isbn,edition,author_id)
AS
SELECT title,price,publication_date,isbn,edition,author_id
FROM child_book
WHERE edition=1
WITH CHECK OPTION;


