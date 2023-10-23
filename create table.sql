CREATE TABLE IF NOT EXISTS wal_info  (
				invoice_id VARCHAR(30),
				branch VARCHAR(5),
				city VARCHAR(30),
				customer_type VARCHAR(30),
				gender VARCHAR(10),
				product_line VARCHAR(100),
				unit_price DECIMAL(10,2),
				quantity INT,
				VAT float(6),
				total DECIMAL(10,2),
				date DATE,
				time TIMESTAMP,
				payment_method DECIMAL(10,2),
				cogs DECIMAL(10,2),
				gross_margin_percentage FLOAT(9),
				gross_income DECIMAL(10,2),
				rating FLOAT(2)
	
)

ALTER TABLE wal_info
ALTER COLUMN branch TYPE VARCHAR(10),
ALTER COLUMN  unit_price TYPE VARCHAR(10),
ALTER COLUMN  quantity TYPE VARCHAR(10),
ALTER COLUMN  VAT TYPE VARCHAR(10),
ALTER COLUMN  total TYPE VARCHAR(10),
ALTER COLUMN  date TYPE VARCHAR(10),
ALTER COLUMN  time TYPE VARCHAR(10),
ALTER COLUMN  payment_method TYPE VARCHAR(20),
ALTER COLUMN  cogs TYPE VARCHAR(10),
ALTER COLUMN  gross_margin_percentage TYPE VARCHAR(30),
ALTER COLUMN  gross_income TYPE VARCHAR(20),
ALTER COLUMN  rating TYPE VARCHAR(10);




