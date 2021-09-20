/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT AUTO_INCREMENT,
    name varchar(100),
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN NOT NULL DEFAULT FALSE,
    weight_kg DECIMAL(3) NOT NULL
);

/* task-2 */
/* Add a column species of type string to your animals table. Modify your schema.sql file. */
ALTER TABLE animals ADD COLUMN species varchar(100);