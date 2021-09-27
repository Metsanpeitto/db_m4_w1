/* Populate database with sample data. */

INSERT INTO animals (name) VALUES ('Luna');
INSERT INTO animals (name) VALUES ('Daisy');
INSERT INTO animals (name) VALUES ('Charlie');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon','2020-02-03',0,'true',10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon','2018-11-15',2,'true',8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu','2021-01-07',1,'false',15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon','2017-05-12',5,'true',11);

/* task-2 */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander','2020-02-08',0,'false',-11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon','2022-11-15',2,'true',-5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle','1993-04-04',3,'false',-12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon','2005-06-13',1,'true',-45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon','2005-06-07',7,'true',20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom','1998-10-13',3,'true',17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Testomon','1998-10-13',3,'true',17);


/* Tasks-3*/ 
INSERT INTO owners (full_name, age) VALUES ('Sam Smith',34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell',19);
INSERT INTO owners (full_name, age) VALUES ('Bob',45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond',77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester ',14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker',34);

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

UPDATE animals SET species_id = ( SELECT id FROM species WHERE name = 'Digimon' ) WHERE name LIKE '%mon';
UPDATE animals SET species_id = ( SELECT id FROM species WHERE name = 'Pokemon' )  WHERE name NOT LIKE '%mon';
UPDATE animals SET owner_id =  ( SELECT id FROM owners WHERE full_name = 'Sam Smith' ) WHERE name = 'Agumon';
UPDATE animals SET owner_id =  ( SELECT id FROM owners WHERE full_name = 'Jennifer Orwell' ) WHERE name = 'Agumon' OR name = 'Pikachu';
UPDATE animals SET owner_id =  ( SELECT id FROM owners WHERE full_name = 'Bob' ) WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id =  ( SELECT id FROM owners WHERE full_name = 'Melody Pond' ) WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id =  ( SELECT id FROM owners WHERE full_name = 'Dean Winchester' ) WHERE( name = 'Angemon') OR (name = 'Boarmon');


/* Taks-4  */
INSERT INTO vets (name, age, date_of_graduation ) VALUES ('William Tatcher' , 45, '2000-4-23');
INSERT INTO vets (name, age, date_of_graduation ) VALUES ('Maisy Smith' , 26 , '2019-1-17');
INSERT INTO vets (name, age, date_of_graduation ) VALUES ('Stephanie Mendez' , 64 , '1981-5-4');
INSERT INTO vets (name, age, date_of_graduation ) VALUES ('Jack Harkness' , 38 , '2008-6-8');


INSERT INTO specializations (vet_id, species_id) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'William Tatcher'),
  (SELECT id FROM species WHERE name = 'Pokemon'));

INSERT INTO specializations (vet_id, species_id) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez'),
  (SELECT id FROM species WHERE name = 'Pokemon'));

INSERT INTO specializations (vet_id, species_id) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez'),
  (SELECT id FROM species WHERE name = 'Digimon'));

INSERT INTO specializations (vet_id, species_id) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Jack Harkness'),
  (SELECT id FROM species WHERE name = 'Digimon'));


INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'William Tatcher' LIMIT 1), 
  (SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), 
'William Tatcher' ,'Boarmon',  '2021-01-11');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1),
  (SELECT id FROM animals WHERE name = 'Agumon' LIMIT 1),   
'Stephanie Mendez' ,'Agumon',  '2020-07-22');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), 
  (SELECT id FROM animals WHERE name = 'Gabumon' LIMIT 1),  
'Jack Harkness' , 'Gabumon', '2021-02-02');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ( (SELECT vet_id FROM vets WHERE name = 'Maisy Smith' LIMIT 1),  
 (SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), 
'Maisy Smith' ,'Pikachu',  '2020-01-05');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Maisy Smith' LIMIT 1),  
 (SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1),     
'Maisy Smith' , 'Pikachu', '2020-03-08');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Maisy Smith'  LIMIT 1), 
  (SELECT id FROM animals WHERE name = 'Pikachu'  LIMIT 1),  
'Maisy Smith' ,'Pikachu',  '2020-05-14');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ( (SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez'  LIMIT 1),
 (SELECT id FROM animals WHERE name = 'Devimon'  LIMIT 1), 
'Stephanie Mendez' ,'Devimon',  '2020-05-04');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Jack Harkness'  LIMIT 1),
   (SELECT id FROM animals WHERE name = 'Charmander'  LIMIT 1), 
'Jack Harkness' ,'Charmander',  '2021-02-24');


INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Maisy Smith'  LIMIT 1),
  (SELECT id FROM animals WHERE name = 'Plantmon'  LIMIT 1),
'Maisy Smith' ,'Plantmon',  '2019-12-21');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'William Tatcher'  LIMIT 1),
   (SELECT id FROM animals WHERE name = 'Plantmon'  LIMIT 1),   
'William Tatcher' , 'Plantmon', '2020-09-10');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Maisy Smith'   LIMIT 1),
  (SELECT id FROM animals WHERE name = 'Plantmon'  LIMIT 1),  
'Maisy Smith' ,'Plantmon',  '2021-04-07');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez'  LIMIT 1),
  (SELECT id FROM animals WHERE name = 'Squirtle'  LIMIT 1),  
 'Stephanie Mendez' , 'Squirtle','2019-09-29');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Jack Harkness'  LIMIT 1),
  (SELECT id FROM animals WHERE name = 'Angemon'  LIMIT 1),   
'Jack Harkness' ,'Angemon',  '2020-10-03');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Jack Harkness'  LIMIT 1),
 (SELECT id FROM animals WHERE name = 'Angemon'  LIMIT 1),    
'Jack Harkness' , 'Angemon', '2020-11-04');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Maisy Smith' LIMIT 1),
 (SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1),  
'Maisy Smith' , 'Boarmon', '2019-01-24');


INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Maisy Smith'  LIMIT 1),
  (SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1),   
'Maisy Smith' ,'Boarmon',  '2019-04-05');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Maisy Smith'  LIMIT 1),
  (SELECT id FROM animals WHERE name = 'Boarmon'  LIMIT 1),   
'Maisy Smith' , 'Boarmon', '2020-02-27');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ( (SELECT vet_id FROM vets WHERE name = 'Maisy Smith'  LIMIT 1), 
  (SELECT id FROM animals WHERE name = 'Boarmon'  LIMIT 1), 
'Maisy Smith' , 'Boarmon', '2020-09-3');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ((SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez'  LIMIT 1),
  (SELECT id FROM animals WHERE name = 'Boarmon'  LIMIT 1),   
 'Stephanie Mendez' ,'Boarmon', '2020-05-24');

INSERT INTO visits (vet_id, animal_id,vet_name, animal_name, date_of_visit) VALUES
 ( (SELECT vet_id FROM vets WHERE name = 'William Tatcher'  LIMIT 1),
   (SELECT id FROM animals WHERE name = 'Boarmon'  LIMIT 1), 
'William Tatcher' ,'Boarmon',  '2021-01-11');

/*  Taks 5: database performance audit */
/*  Run the following statements to add data to your database (executing them might take a few minutes):*/
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT vet_id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;


