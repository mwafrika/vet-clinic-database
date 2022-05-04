/*Queries that provide answers to the questions from all projects.*/
-- day 1 questions
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=TRUE AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered=TRUE;
SELECT * from animals WHERE name <> 'Gabumon';
SELECT * from animals WHERE weight_kg >=10.4 and weight_kg <= 17.3;

-- day2 questions

BEGIN;
update animals set species='unspecified' where species is null;
ROLLBACK;

BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species is NULL;
COMMIT;

BEGIN;
DELETE * FROM animals
ROLLBACK;


BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022/01/01';

-- Create a savepoint for the transaction.
SAVEPOINT sp1;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg*-1;

-- Rollback to the savepoint
ROLLBACK TO sp1;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg=(SELECT weight_kg FROM animals WHERE weight_kg < 0)*-1;

-- Commit transaction
COMMIT;

-- respond to questions about the data in the database

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) from animals WHERE escape_attempts=0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT name FROM animals WHERE escape_attempts=(SELECT MAX(escape_attempts) FROM animals);

-- What is the minimum and maximum weight of each type of animal?
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990/01/01' AND '2000/12/31';

-- wenesday tasks

-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
-- List of all animals that are pokemon (their type is Pokemon).
-- List all owners and their animals, remember to include those that don't own any animal.
-- How many animals are there per species?
-- List all Digimon owned by Jennifer Orwell.
-- List all animals owned by Dean Winchester that haven't tried to escape.
-- Who owns the most animals?            

SELECT name FROM animals as a INNER JOIN owners as o ON a.owner_id = o.id WHERE o.full_name ='Melody Pond';
SELECT a.name FROM animals as a INNER JOIN species as s ON species_id = s.id WHERE s.name ='Pokemon';
SELECT o.full_name, a.name FROM owners as o FULL JOIN animals as a ON o.id = a.owner_id;
SELECT s.name,COUNT(*) FROM animals as a INNER JOIN species as s ON a.species_id = s.id GROUP BY s.name;
SELECT a.name FROM animals as a INNER JOIN owners as o ON a.species_id = o.id WHERE o.full_name='Jennifer Orwell';
SELECT a.name FROM animals as a INNER JOIN owners as o ON a.owner_id = o.id WHERE o.full_name='Dean Winchester' AND a.escape_attempts=0;
SELECT o.full_name, COUNT(*) as c FROM owners as o INNER JOIN animals as a ON a.owner_id = o.id GROUP BY o.full_name ORDER by c DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT name FROM animals WHERE id = (SELECT animals_id FROM visits WHERE vets_id = (SELECT id FROM vets WHERE name LIKE 'William Tatcher') ORDER BY visit_date DESC limit 1);

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(name) FROM animals as a JOIN visits as v ON a.id = v.animals_id WHERE v.vets_id=(SELECT id FROM vets WHERE name='Stephanie Mendez');

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, sp.name FROM vets as v FULL JOIN specializations as s ON  v.id = s.vets_id FULL JOIN species as sp ON sp.id = s.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name,v.visit_date, ve.name  from animals as a JOIN visits as v ON a.id = v.animals_id JOIN vets as ve ON ve.id = v.vets_id WHERE v.vets_id= (SELECT id FROM vets WHERE name='Stephanie Mendez') AND (v.visit_date BETWEEN '2020/04/01' AND '2020/08/30');

-- What animal has the most visits to vets?
SELECT a.name, COUNT(v.visit_date) as c FROM animals as a JOIN visits as v ON a.id = v.animals_id GROUP by a.name ORDER BY c DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name, ve.name, v.visit_date from animals as a JOIN visits as v on a.id = v.animals_id JOIN vets as ve on ve.id = v.vets_id WHERE ve.name='Maisy Smith' ORDER by v.visit_date asc LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name, ve.name, v.visit_date from animals as a JOIN visits as v on a.id = v.animals_id JOIN vets as ve on ve.id = v.vets_id ORDER by v.visit_date asc LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
select count(*) from visits 
    left join animals on animals.id = visits.animals_id 
    left join vets on vets.id = visits.vets_id
    where animals.species_id not in (select animals.species_id from specializations where specializations.vets_id = vets.id);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
select species.name, count(*) from visits left join animals on animals.id = visits.animals_id 
    left join species ON animals.species_id = species.id
    left join vets ON vets.id = visits.vets_id where vets.name = 'Maisy Smith' group by species.name;

-- analyze the execution time for owners table
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';

-- and analyze the execution time for visits table
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

-- analyze the execution time for visits table
explain analyze SELECT * FROM visits where vet_id = 2;