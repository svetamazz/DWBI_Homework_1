-- 6 triggers creation for pair tables --
USE [s_matskiv_module_2];
GO
-- update trigger on main table(person) --
CREATE TRIGGER update_trigger_person ON person
AFTER UPDATE
AS
BEGIN

IF (@@ROWCOUNT=0) RETURN

DECLARE @operation CHAR(1)='U'
INSERT INTO person_second(id,first_name,last_name,father_name,gender,birth_date,passport,country,city,[address],favourite_color,life_kredo,type_of_operation) 
SELECT p.id,p.first_name,p.last_name,p.father_name,p.gender,p.birth_date,p.passport,p.country,p.city,p.[address],p.favourite_color,p.life_kredo,@operation
FROM person p
JOIN inserted
ON p.id=inserted.id;

END
GO
-- delete trigger on main table(person) --
CREATE TRIGGER delete_trigger_person ON person
AFTER DELETE
AS
BEGIN

IF (@@ROWCOUNT=0) RETURN

DECLARE @operation CHAR(1)='D'
INSERT INTO person_second(id,first_name,last_name,father_name,gender,birth_date,passport,country,city,[address],favourite_color,life_kredo,type_of_operation) 
SELECT p.id,p.first_name,p.last_name,p.father_name,p.gender,p.birth_date,p.passport,p.country,p.city,p.[address],p.favourite_color,p.life_kredo,@operation
FROM deleted p;

END
GO
-- insert trigger on main table(person) --
CREATE TRIGGER insert_trigger_person ON person
AFTER INSERT
AS
BEGIN

IF (@@ROWCOUNT=0) RETURN

DECLARE @operation CHAR(1)='I'
INSERT INTO person_second(id,first_name,last_name,father_name,gender,birth_date,passport,country,city,[address],favourite_color,life_kredo,type_of_operation) 
SELECT p.id,p.first_name,p.last_name,p.father_name,p.gender,p.birth_date,p.passport,p.country,p.city,p.[address],p.favourite_color,p.life_kredo,@operation
FROM person p
JOIN inserted
ON p.id=inserted.id;

END
GO
