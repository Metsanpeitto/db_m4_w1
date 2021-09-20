/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';
SELECT * FROM animals WHERE name LIKE '%' || 'mon' || '%';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth < '2019-01-01';
SELECT name FROM animals WHERE neutered = 't' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR 'Pikachu';
SELECT  name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg > 10.4 AND weight_kg =< 17.3;


UPDATE animals SET species = 'unspecified';
ROLLBACK;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%' || 'mon' || '%';
UPDATE animals SET species = 'pokemon' WHERE species = null;

BEGIN TRANSACTION;
   DELETE FROM animals;
   ROLLBACK;
COMMIT TRANSACTION;

BEGIN;
   DELETE FROM animals WHERE date_of_birth > '2022-01-01';
   SAVEPOINT sp1;
   UPDATE animals SET weight_kg = weight_kg * -1 ;
   ROLLBACK TO sp1;
   UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
/* Who escapes the most, neutered or not neutered animals? */
SELECT SUM(escape_attempts), neutered FROM animals GROUP BY neutered;
/* What is the minimum and maximum weight of each type of animal? */
SELECT MAX(weight_kg),MIN(weight_kg), neutered FROM animals GROUP BY neutered;
/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT AVG(escape_attempts), neutered FROM animals WHERE date_of_birth > '1990-01-01' AND date_of_birth < '2000-01-01' GROUP BY neutered ;