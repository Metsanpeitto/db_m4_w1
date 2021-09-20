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


