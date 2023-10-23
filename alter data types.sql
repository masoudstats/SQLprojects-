SELECT * FROM wal_info LIMIT(5);

DELETE FROM wal_info
WHERE invoice_id = 'Invoice ID'


---------------------------
-- change data type per each column.

ALTER TABLE wal_info
	ALTER COLUMN unit_price TYPE  DECIMAL(8,3)
	USING unit_price::DECIMAL(8,3),

	ALTER COLUMN quantity TYPE INT
	USING quantity::INT,
	
	ALTER COLUMN vat TYPE FLOAT(4)
	USING vat::FLOAT(4),
	
	ALTER COLUMN total TYPE DECIMAL(10,2)
	USING total::DECIMAL(10,2),
	
	ALTER COLUMN date TYPE DATE
	USING date::DATE,
	
	ALTER COLUMN time TYPE TIME
	USING time::TIME,
	
	ALTER COLUMN gross_margin_percentage TYPE DECIMAL(10,2)
	USING gross_margin_percentage::DECIMAL(10,2),
	
	ALTER COLUMN cogs TYPE DECIMAL(10,2)
	USING cogs::DECIMAL(10,2);
	
	
	