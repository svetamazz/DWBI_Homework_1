-- 2 creation parent_author table and child_book --
USE [s_matskiv_module_2];
GO
-- parent_author creation --
CREATE TABLE parent_author(
id INT CONSTRAINT pk_author_id PRIMARY KEY IDENTITY NOT NULL,
first_name NVARCHAR(50) NOT NULL,
last_name NVARCHAR(50) NOT NULL,
father_name NVARCHAR(50) NOT NULL,
age AS (YEAR(GETDATE())-YEAR(birth_date)),
birth_date DATE CONSTRAINT ck_birth CHECK(birth_date<GETDATE()) NOT NULL,
passport NVARCHAR(50) CONSTRAINT uk_passport UNIQUE NOT NULL,
[address] NVARCHAR(100) NOT NULL,
inserted_date DATETIME DEFAULT GETDATE() CONSTRAINT ck_inserted_date_parent CHECK(inserted_date<=GETDATE()) NULL,
updated_date DATETIME NULL,
CONSTRAINT ck_updated_date_after_inserted_parent CHECK(updated_date>=inserted_date)
);
GO 
-- child_book creation --
CREATE TABLE child_book(
id INT CONSTRAINT pk_book_id PRIMARY KEY IDENTITY NOT NULL,
title NVARCHAR(50) NOT NULL,
publication_date DATE CONSTRAINT ck_pub_date CHECK(publication_date<GETDATE()) NOT NULL,
pages_amount INT CONSTRAINT ck_pages_amount CHECK(pages_amount>0),
price NUMERIC(10,2) CONSTRAINT ck_price CHECK(price>0) NOT NULL,
edition INT CONSTRAINT ck_edition CHECK(edition>0) NOT NULL,
isbn CHAR(15) CONSTRAINT uq_isbn UNIQUE NOT NULL,
author_id INT CONSTRAINT fk_book_author FOREIGN KEY REFERENCES parent_author(id) NOT NULL,
inserted_date DATETIME DEFAULT GETDATE() CONSTRAINT ck_inserted_date_child CHECK(inserted_date<=GETDATE()) NULL,
updated_date DATETIME NULL,
CONSTRAINT ck_updated_dateafter_inserted_child CHECK(updated_date>=inserted_date) 
);