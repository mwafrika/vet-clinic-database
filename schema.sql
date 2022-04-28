/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,name VARCHAR NOT NULL,date_of_birth DATE NOT NULL,escape_attempts INT NOT NULL,neutered 
BOOL NOT NULL,weight_kg DECIMAL(50,2) NOT NULL);

ALTER TABLE animals ADD species VARCHAR(50);

-- Create a table named owners with the following columns:
CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,full_name VARCHAR NOT NULL,age INT NOT NULL);

-- Create a table named species with the following columns:
CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,name VARCHAR NOT NULL);

-- Remove column species
ALTER TABLE animals DROP species;

-- add species_id column to animals table
ALTER TABLE animals ADD species_id INT;

-- Add a foreign key constraint to the species_id column
ALTER TABLE animals ADD FOREIGN KEY(species_id) REFERENCES species(id);

-- add owner_id column to animals table
ALTER TABLE animals ADD owner_id INT;

-- Add a foreign key constraint to the owner_id column
ALTER TABLE animals ADD FOREIGN KEY(owner_id) REFERENCES owners(id);