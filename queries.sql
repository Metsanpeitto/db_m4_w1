/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth < '2019-01-01';
SELECT name FROM animals WHERE neutered = 't' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR 'Pikachu';
SELECT  name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg > 10.4 AND weight_kg =< 17.3;



/* task-2 */

/* Inside a transaction update the animals table by setting the species column to unspecified.
 Verify that change was made. Then roll back the change and verify that species columns went back 
 to the state before tranasction.                                                                   */
BEGIN;
   UPDATE animals SET species = 'unspecified';
   SELECT species FROM animals;
ROLLBACK;
    SELECT species FROM animals;

/*  Inside a transaction:
Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
Commit the transaction.
Verify that change was made and persists after commit.*/
BEGIN;
   UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
   UPDATE animals SET species = 'pokemon' WHERE species = null;
COMMIT;

/* Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction. */  
BEGIN;
   DELETE FROM animals;
   ROLLBACK;
SELECT * FROM animals;

/*  - Inside a transaction:
  - Delete all animals born after Jan 1st, 2022.
  - Create a savepoint for the transaction.
  - Update all animals' weight to be their weight multiplied by -1.
  - Rollback to the savepoint
  - Update all animals' weights that are negative to be their weight multiplied by -1.
  - Commit transaction  */
BEGIN;
   DELETE FROM animals WHERE date_of_birth > '2022-01-01';
   SAVEPOINT sp1;
   UPDATE animals SET weight_kg = weight_kg * -1 ;
   ROLLBACK TO sp1;
   UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/*  - Write queries to answer the following questions:
  - How many animals are there?
  - How many animals have never tried to escape?
  - What is the average weight of animals?
  - Who escapes the most, neutered or not neutered animals?
  - What is the minimum and maximum weight of each type of animal?
  - What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT SUM(escape_attempts), neutered FROM animals GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT MAX(weight_kg),MIN(weight_kg), species_id FROM animals GROUP BY species_id;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT AVG(escape_attempts), species_id  FROM animals WHERE date_of_birth > '1990-01-01' AND date_of_birth < '2000-01-01' GROUP BY species_id ;




/* Tasks-3*/ 

/* What animals belong to Melody Pond? */
SELECT * FROM animals INNER JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT * FROM animals INNER JOIN species ON species.id = animals.species_id WHERE species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT full_name, name  FROM owners LEFT JOIN animals ON animals.owner_id = owners.id ;

/*  How many animals are there per species?  */ 
SELECT species.name, COUNT(*) FROM animals FULL OUTER JOIN species ON animals.species_id = species.id GROUP BY species.id;

/* List all Digimon owned by Jennifer Orwell. */
SELECT animals.name, species.name FROM animals 
INNER JOIN owners 
ON  owners.id = animals.owner_id
INNER JOIN species 
ON  species.id = animals.species_id
WHERE owners.full_name = 'Jennifer Orwell'
AND species.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape.  */
SELECT animals.name FROM animals
LEFT JOIN owners 
ON owners.id = animals.owner_id
WHERE animals.escape_attempts = 0
AND owners.full_name = 'Dean Winchester';

/* Who owns the most animals? */
SELECT full_name, COUNT(*) as total FROM owners
LEFT JOIN animals 
ON owners.id = animals.owner_id GROUP BY full_name ORDER BY total desc;


/* Tasks-4*/ 

/*  Who was the last animal seen by William Tatcher? */
SELECT animal_name FROM visits WHERE vet_name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

/*  How many different animals did Stephanie Mendez see?  */
SELECT DISTINCT animal_name FROM visits WHERE vet_name = 'Stephanie Mendez';

/*  List all vets and their specialties, including vets with no specialties.  */
SELECT name, species_id FROM specializations LEFT JOIN vets ON specializations.vet_id = vets.vet_id ;

/*  List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.  */
SELECT DISTINCT name  FROM visits JOIN animals ON 
visits.vet_name = 'Stephanie Mendez'
AND visits.date_of_visit > '2020-04-01' AND visits.date_of_visit < '2020-08-30' ;

/*  What animal has the most visits to vets?  */
SELECT DISTINCT animals.name, COUNT(animal_name)  FROM visits JOIN animals ON 
visits.animal_name = animals.name
GROUP BY animals.name ORDER BY COUNT(animal_name) DESC LIMIT 1;

/*  Who was Maisy Smith's first visit?  */
SELECT animal_name, date_of_visit FROM visits WHERE vet_name = 'Maisy Smith'  ORDER BY date_of_visit   ASC
 LIMIT 1;

/*  Details for most recent visit: animal information, vet information, and date of visit. */
SELECT animal_name, animal_id, vet_id, vet_name, date_of_visit 
FROM visits ORDER BY date_of_visit DESC LIMIT 1;

/*  How many visits were with a vet that did not specialize in that animal's species? */
SELECT COUNT(visits.id) ,visits.vet_name
FROM visits
INNER JOIN vets ON vets.vet_id = visits.vet_id
INNER JOIN specializations ON
specializations.vet_id != visits.vet_id
INNER JOIN animals ON animals.id = visits.animal_id
INNER JOIN species ON specializations.species_id = (SELECT animals.species FROM animals WHERE animals.name = visits.animal_name)
GROUP BY visits.vet_name ORDER BY COUNT(visits.id) DESC
;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT  animals.species  FROM visits
JOIN animals ON
animals.name = visits.animal_name
JOIN species ON
species.id = animals.species
WHERE vet_name = 'Maisy Smith'
GROUP BY animals.species
ORDER BY COUNT(*) DESC
LIMIT 1;
;

/*  1st Saturate the DB with new visits entries                   */
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT vet_id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;


/*  Taks 5: database performance audit */
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;
/*  After creating the index animal_id_index */
explain analyze SELECT COUNT(animal_id) FROM visits where animal_id = 4;

explain analyze SELECT * FROM visits where vet_id = 2;
/*  After creating the index animal_id_index */
explain analyze SELECT vet_id FROM visits where vet_id = 2;

explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';
/*  After creating the index animal_id_index */
explain analyze SELECT email FROM owners where email = 'owner_18327@mail.com';
