-- 7 checking constraints behavior --
USE [s_matskiv_module_2];
GO

-------***parent_author table***-------

-- (INCORRECT)insert data into parent_author table | error reason(id identity) 
INSERT INTO parent_author(id,first_name,last_name,father_name,birth_date,passport,[address]) 
VALUES(1,'Max','Payne','Yay','1995','NL41239','NewYork city');
GO
-- (CORRECT)insert data into parent_author table 
INSERT INTO parent_author(first_name,last_name,father_name,birth_date,passport,[address]) 
VALUES('Max','Payne','Yay','1995','NL41239','NewYork city');
GO
-- (INCORRECT)insert data into parent_author table | error reason(passport unique constraint) 
INSERT INTO parent_author(first_name,last_name,father_name,birth_date,passport,[address]) 
VALUES('Mary','Jayne','Yay','1999','NL41239','Los Angeles');
GO
-- (CORRECT)insert data into parent_author table | error reason(passport unique constraint) 
INSERT INTO parent_author(first_name,last_name,father_name,birth_date,passport,[address]) 
VALUES('Mary','Jayne','Yay','1999','PP434439','Los Angeles');
GO
-- (INCORRECT)insert data into parent_author table | error reason(birth_date constraint -- 2020 > GETDATE()) 
INSERT INTO parent_author(first_name,last_name,father_name,birth_date,passport,[address]) 
VALUES('Piter','Parker','Yay','2020','KL984345','City');
GO
-- (CORRECT)insert data into parent_author table  
INSERT INTO parent_author(first_name,last_name,father_name,birth_date,passport,[address]) 
VALUES('Piter','Parker','Yay','1996','KL984345','City');
GO
-- (INCORRECT)insert data into parent_author table | error reason(birth_date inserted_date -- 2020 > GETDATE()) 
INSERT INTO parent_author(first_name,last_name,father_name,birth_date,passport,[address],inserted_date) 
VALUES('Robert','Jackson','Yay','1990','KL9DFFD','City','2020-01-01');
GO
-- (CORRECT)insert data into parent_author table  
INSERT INTO parent_author(first_name,last_name,father_name,birth_date,passport,[address],inserted_date) 
VALUES('Robert','Jackson','Yay','1990','KL9DFFD','City','2010-01-01');
GO
-- selection data --
SELECT * FROM parent_author;
-- (CORRECT)update data in parent_author table | column updated_data will be filled
UPDATE parent_author
SET first_name='Nick'
WHERE [address]='City';
GO
-- selection data --
SELECT * FROM parent_author;
GO


-------***child_book table***-------

--NOTE: constraints in this table are simmilar to previous, so I'll show only different

-- (INCORRECT)insert data into child_book table | error reason(FOREIGN KEY CONSTRAINT) 
INSERT INTO child_book(title,publication_date,pages_amount,price,edition,isbn,author_id)
VALUES('Harry Potter','2000-01-01',800,120,1,'9388-348-30',90);
GO
-- (CORRECT)insert data into child_book table
INSERT INTO child_book(title,publication_date,pages_amount,price,edition,isbn,author_id)
VALUES('Harry Potter','2000-01-01',800,120,1,'9388-348-30',1);
GO
-- (INCORRECT)insert data into child_book table | error reason(price CONSTRAINT - price<0) 
INSERT INTO child_book(title,publication_date,pages_amount,price,edition,isbn,author_id)
VALUES('The Hunger Games','2012-01-01',800,-120,1,'2323-2323',2);
GO
-- (CORRECT)insert data into child_book table
INSERT INTO child_book(title,publication_date,pages_amount,price,edition,isbn,author_id)
VALUES('The Hunger Games','2012-01-01',800,220,1,'2323-2323',2);
GO
-- selection data --
SELECT * FROM child_book;
GO


-------***views***-------

-- retrieve data from view
SELECT * FROM dbo.get_author_Max
-- hidden insert, because view without check option
INSERT INTO dbo.get_author_Max(first_name,last_name,father_name,birth_date,passport,[address])
VALUES('James','Jaymy','Jameson','1968-07-07','PO98751','addddressss');
-- retrieve data from view
SELECT * FROM dbo.get_author_Max
-- retrive data from real table 
SELECT * FROM dbo.parent_author

-- error insert, because view with check option
INSERT INTO dbo.get_author_Max_check(first_name,last_name,father_name,birth_date,passport,[address])
VALUES('James','Jaymy','Jameson','1968-07-07','PO908751','addddressss');

-- retrieve data from views on child_book table
SELECT * FROM dbo.get_books_of_1_edition
-- OR
SELECT * FROM dbo.get_books_of_1_edition_check


-------***pair tables(person,person_second) triggers***-------
-- (INCORRECT)insert data into person table | error reason(gender CHECK CONSTRAINT) 
INSERT INTO dbo.person(first_name,last_name,father_name,gender,birth_date,passport)
VALUES('Jon','Snow','Reddovych','чол','2000-02-04','KO45232');
-- (CORRECT)insert data into person table
INSERT INTO dbo.person(first_name,last_name,father_name,gender,birth_date,passport)
VALUES('Jon','Snow','Reddovych','male','2000-02-04','KO45232');
-- retrieving data from log person_second
SELECT * FROM dbo.person_second

-- deleting data from person table, to fill log table person_second
DELETE FROM dbo.person;
-- retrieving data from log person_second
SELECT * FROM dbo.person_second

-- inserting data to person table
INSERT INTO dbo.person(first_name,last_name,father_name,gender,birth_date,passport)
VALUES('Arya','Stark','Reddivna','female','2003-02-04','KO4SD5232'),
('Jon','Snow','Reddovych','male','2000-02-04','KO45232');
-- retrieving data from log person_second
SELECT * FROM dbo.person_second;

-- update rows in person to fill log table person_second
UPDATE dbo.person
SET country='Ukraine';
-- retrieving data from log person_second
SELECT * FROM dbo.person_second