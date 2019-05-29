-- 5 pair tables creation --
USE [s_matskiv_module_2];
GO
-- main table(person) creation --
CREATE TABLE person(
id INT CONSTRAINT pk_person_id PRIMARY KEY IDENTITY NOT NULL,
first_name NVARCHAR(50) NOT NULL,
last_name NVARCHAR(50) NOT NULL,
father_name NVARCHAR(50) NULL,
gender VARCHAR(10) CONSTRAINT ck_gender CHECK(gender='male' OR gender='female') NOT NULL,
birth_date DATE CONSTRAINT ck_birth_person CHECK(birth_date<GETDATE()) NOT NULL,
passport NVARCHAR(50) CONSTRAINT uk_passport_person UNIQUE NOT NULL,
country NVARCHAR(50) NULL,
city NVARCHAR(50) NULL,
[address] NVARCHAR(100) NULL,
favourite_color NVARCHAR(25) NULL,
life_kredo NVARCHAR(100) NULL 
);
GO
-- secondary table(person_second) creation --
CREATE TABLE person_second(
id INT NOT NULL,
first_name NVARCHAR(50) NOT NULL,
last_name NVARCHAR(50) NOT NULL,
father_name NVARCHAR(50) NULL,
gender VARCHAR(10) CONSTRAINT ck_gender_second CHECK(gender='male' OR gender='female') NOT NULL,
birth_date DATE CONSTRAINT ck_birth_second CHECK(birth_date<GETDATE()) NOT NULL,
passport NVARCHAR(50) NOT NULL,
country NVARCHAR(50) NULL,
city NVARCHAR(50) NULL,
[address] NVARCHAR(100) NULL,
favourite_color NVARCHAR(25) NULL,
life_kredo NVARCHAR(100) NULL,
date_of_operation DATETIME DEFAULT GETDATE() CONSTRAINT ck_date_of_operation CHECK(date_of_operation<=GETDATE()) NULL,
type_of_operation CHAR(1) CONSTRAINT type_oper CHECK(type_of_operation='U' OR type_of_operation='I' OR type_of_operation='D') NOT NULL
);