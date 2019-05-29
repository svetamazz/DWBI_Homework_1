-- 3 creation update triggers for parent_author table and child_book table --
USE [s_matskiv_module_2];
GO
-- update trigger for parent_author creation --
CREATE TRIGGER update_trigger_parent_author ON parent_author
AFTER UPDATE
AS
BEGIN

IF (@@ROWCOUNT=0) RETURN

UPDATE parent_author
SET updated_date=GETDATE()
WHERE id IN (SELECT id FROM inserted);

END
GO
-- update trigger for child_book creation --
CREATE TRIGGER update_trigger_child_book ON child_book
AFTER UPDATE
AS
BEGIN

IF (@@ROWCOUNT=0) RETURN

UPDATE child_book
SET updated_date=GETDATE()
WHERE id IN (SELECT id FROM inserted);

END