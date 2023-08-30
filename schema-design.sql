INSERT INTO location (city, state, country) VALUES ('Nashville', 'Tennessee', 'United States'), ('Memphis', 'Tennessee','United States'), ('Phoenix', 'Arizona', 'United States'), ('Denver', 'Colorado', 'United States');
SELECT * FROM location

INSERT INTO person ("firstName", "lastName", age, location_id) VALUES ('Chickie', 'Ourtic', 21, 1), ('Hilton', 'OHanley', 37, 1), ('Barbe', 'Purver', 50, 3), ('Reeta', 'Sammons', 34, 2), ('Abbott', 'Fishbourne', 49, 1), ('Winnie', 'Whines', 19, 4), ('Samantha', 'Leese', 35, 2), ('Edouard', 'Lorimer', 29, 1), ('Mattheus', 'Shaplin', 27, 3), ('Donnell', 'Corney', 25, 3), ('Wallis', 'Kauschke', 28, 3), ('Melva', 'Lanham', 20, 2), ('Amelina', 'McNirlan', 22, 4), ('Courtney', 'Holley', 22, 1), ('Sigismond', 'Vala', 21, 4), ('Jacquelynn', 'Halfacre', 24, 2), ('Alanna', 'Spino', 25, 3), ('Isa', 'Slight', 32, 1), ('Kakalina', 'Renne', 26, 3);
SELECT * FROM person;

INSERT INTO interest (title) VALUES ('Programming'), ('Gaming'), ('Computers'), ('Music'), ('Movies'), ('Cooking'), ('Sports');
SELECT * FROM interest;

INSERT INTO person_interest (person_id, interest_id) VALUES (1, 1), (1, 2), (1, 6), (2, 1), (2, 7), (2, 4), (3, 1), (3, 3), (3, 4), (4, 1), (4, 2), (4, 7), (5, 6), (5, 3), (5, 4), (6, 2), (6, 7), (7, 1), (7, 3), (8, 2), (8, 4), (9, 5), (9, 6), (10, 7), (10, 5), (11, 1), (11, 2), (11, 5), (12, 1), (12, 4), (12, 5), (13, 2), (13, 3), (13, 7), (14, 2), (14, 4), (14, 6), (15, 1), (15, 5), (15, 7), (16, 2), (16,3), (16,4), (17,1), (17,3), (17,5), (17,7), (18,2), (18,4), (18,6), (19,1), (19,2), (19,3), (19,4), (19,5), (19,6), (19,7); 
SELECT * FROM person_interest;

UPDATE person SET age=age+1 WHERE "firstName"='Chickie' OR "firstName"='Winnie' OR "firstName"='Edouard' OR "firstName"='Courtney' OR "firstName"='Melva' OR "firstName"='Isa' OR "firstName"='Abbott' OR "firstName"='Reeta';
SELECT * FROM person ORDER BY id ASC;

SELECT * FROM person JOIN person_interest ON person_interest.person_id=person.id;

-- Can you just set the cascade constraint on FKs when you create the table in the GUI? 
-- Or edit the constraint rather than making a new one?
ALTER TABLE person ADD CONSTRAINT location_id 
	FOREIGN KEY (location_id)
	REFERENCES location (id)
	ON DELETE CASCADE;
	
DELETE FROM person WHERE "firstName"='Hilton' OR "firstName"='Alanna';
SELECT * FROM person JOIN person_interest ON person_interest.person_id=person.id;


-- FINAL ASSIGNMENT QUERIES:
SELECT "firstName", "lastName" FROM person;

SELECT "firstName", "lastName", location.city, location.state FROM person 
	JOIN location ON location.id = location_id WHERE city='Nashville';

SELECT location.city, COUNT(location_id) as employees_per_city FROM person 
	JOIN location ON location.id = location_id 
	GROUP BY city;

SELECT interest.title, COUNT(title) FROM person_interest
	JOIN interest ON interest.id = interest_id
	GROUP BY title;

SELECT "firstName", "lastName", location.city, location.state, interest.title FROM person
	JOIN location ON location.id = location_id
	JOIN person_interest AS pi ON pi.person_id = person.id
	JOIN interest ON interest.id = pi.interest_id
	WHERE location.city='Nashville' AND pi.interest_id=1;

SELECT person_age.range AS range, count(*) AS count
	FROM (
		SELECT age,
		CASE when age>=20 and age<30 then '20-29'
			when age>=30 and age<40 then '30-39'
			else '40-50' end as range
		from person) person_age
	GROUP BY range
	ORDER BY range ASC;
