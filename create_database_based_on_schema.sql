/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,name VARCHAR NOT NULL,date_of_birth DATE NOT NULL,escape_attempts INT NOT NULL,neutered 
BOOL NOT NULL,weight_kg DECIMAL(50,2) NOT NULL, species_id INT NOT NULL,owner_id INT NOT NULL,FOREIGN KEY(owner_id) REFERENCES owners(id), FOREIGN KEY(species_id) REFERENCES species(id));

-- Create a table named owners with the following columns:
CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,full_name VARCHAR NOT NULL,age INT NOT NULL,email VARCHAR(120) NOT NULL);

-- Create a table named species with the following columns:
CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,name VARCHAR NOT NULL);

CREATE TABLE vets(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, name VARCHAR NOT NULL, age INT NOT NULL, date_of_graduation DATE);


-- many to many relationship between vets and species

CREATE TABLE specializations(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, vets_id INT,species_id INT,FOREIGN KEY(species_id) REFERENCES species(id),FOREIGN KEY(vets_id) REFERENCES vets(id));

-- many to many relationship between vets and animals
CREATE TABLE visits(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, animals_id INT,vets_id INT, visit_date DATE, FOREIGN KEY(animals_id) REFERENCES animals(id),FOREIGN KEY(vets_id) REFERENCES vets(id));

-- create index on owners table owners
CREATE INDEX owner_email ON owners(email ASC);

-- create index on vets table on column animals_id
CREATE INDEX visits_animals_id ON visits(animals_id ASC);

-- create index on vets table on column vets_id 
CREATE INDEX visit_vets_id ON visits(vets_id ASC);
