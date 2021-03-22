USE TestBd
GO
INSERT INTO TestSchema.TestTable
VALUES (4, 'Bicycle', 0, '2020-08-23'),
       (5, 'Rocket',1, '2020-01-01'),
	   (6, 'Motorcycle',NULL, '2020-08-26'),
	   (7, 'Submarine',0, '1999-05-16')
INSERT INTO TestSchema.TestTable (Id, InvoiceDate)
VALUES (8, '2020-08-25')
INSERT INTO TestSchema.TestTable (Id, Name)
VALUES (9, 'Scooter')
UPDATE TestSchema.TestTable
SET IsSold = 0
WHERE IsSold IS NULL
DELETE FROM TestSchema.TestTable
WHERE Name IS NULL OR InvoiceDate IS NULL
GO
CREATE TABLE TestSchema.TestTable2 
   (Id INT NOT NULL,
	Name VARCHAR(20),
	IsSold BIT,
	InvoiceDate DATE);
GO
INSERT INTO TestSchema.TestTable2
VALUES 
	(1, 'Speed Boat', 1, '2020-11-08'),
	(7, 'Submarine', 0, '1999-05-16'),
	(8, 'Segway', 1, '2021-01-01');
GO
MERGE TestSchema.TestTable AS T_Base
USING TestSchema.TestTable2 AS T_Source
ON (T_Base.Id = T_Source.Id)
WHEN MATCHED AND T_Base.Name <> T_Source.Name
THEN UPDATE SET Name = T_Source.Name, IsSold = T_Source.IsSold, InvoiceDate = T_Source.InvoiceDate
WHEN NOT MATCHED 
THEN INSERT (Id, Name, IsSold, InvoiceDate) 
VALUES (T_Source.Id, T_Source.Name, T_Source.IsSold, T_Source.InvoiceDate);