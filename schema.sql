/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT SERIAL,
    name varchar(100),
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN NOT NULL DEFAULT FALSE,
    weight_kg DECIMAL(3) NOT NULL
);

ALTER TABLE animals ADD COLUMN species varchar(100);

/* Create a table named owners with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
full_name: string
age: integer   */

CREATE TABLE owners (
    id INT SERIAL,
    full_name varchar(100),
    age INT,
    PRIMARY KEY(id)
    );

/* Create a table named species with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
name: string */

CREATE TABLE species (
    id INT SERIAL,
    name varchar(100),    
    PRIMARY KEY(id)
    );


/* Remove column species */
ALTER TABLE animals DROP COLUMN species;
/*  Add column species_id which is a foreign key referencing species table  */
ALTER TABLE animals ADD  species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
/* Add column owner_id which is a foreign key referencing the owners table */
ALTER TABLE animals ADD  owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);
