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

ALTER TABLE animals ADD COLUMN species varchar(100);

/* Tasks-3*/ 


/* Create a table named owners with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
full_name: string
age: integer   */

CREATE TABLE owners (
    id SERIAL NOT NULL PRIMARY KEY,
    full_name varchar(100),
    age INT
    );

/* Create a table named species with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
name: string */

CREATE TABLE species (
    id SERIAL NOT NULL PRIMARY KEY,
    name varchar(100)
    );

/*  Modify animals table:
Make sure that id is set as autoincremented PRIMARY KEY */
ALTER TABLE animals	ADD COLUMN id SERIAL PRIMARY KEY;
/* Remove column species */
ALTER TABLE animals DROP COLUMN species;
/* Add column species_id which is a foreign key referencing species table */
ALTER TABLE animals ADD  COLUMN species_id INT, ADD FOREIGN KEY (species_id) REFERENCES species(id);
/* Add column owner_id which is a foreign key referencing the owners table */
ALTER TABLE animals ADD  COLUMN owner_id INT, ADD FOREIGN KEY (owner_id) REFERENCES owners(id);
