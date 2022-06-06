CREATE TABLE randoms_all (
id UNIQUEIDENTIFIER PRIMARY KEY,
random_int INTEGER,
datetime_value DATETIME DEFAULT CURRENT_TIMESTAMP,
random_float FLOAT,
random_string TEXT
);

INSERT INTO	randoms_all	VALUES ( 
	NEWID(),
	1,
	GETDATE(),
	1.4,
	'loren ipsum'
)

SELECT * FROM randoms_all
